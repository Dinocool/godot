#!/bin/bash
# FRED ortho fix: Godot launcher with logging support

# Get current directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Create bin directory if it doesn't exist
mkdir -p bin

# Set log file path with timestamp
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
LOGFILE="godot_output_.log"

echo "Starting Godot with logging..."
echo "Log file: $LOGFILE"
echo "Working directory: $(pwd)"
echo.

# Check if Godot executable exists
GODOT_EXEC="bin/godot.windows.editor.x86_64.mono.exe"
if [ ! -f "$GODOT_EXEC" ]; then
    echo "Error: Godot executable not found at $GODOT_EXEC"
    echo "Please build Godot first or update the path in this script."
    exit 1
fi

# Set project path
PROJECT_PATH="D:\Projects\Godot\PixelArt\game"

# Check if project exists
if [ ! -d "$PROJECT_PATH" ]; then
    echo "Error: Project directory not found at $PROJECT_PATH"
    exit 1
fi

# Run Godot with various logging options
echo "Attempting to run Godot with verbose logging..."
echo "Command: $GODOT_EXEC --verbose --log-file \"$LOGFILE\" --path \"$PROJECT_PATH\""
echo.

# Try different logging approaches
$GODOT_EXEC -e --log-file "$LOGFILE" --path "$PROJECT_PATH" 2>&1
EXIT_CODE=$?

echo.
echo "Godot exited with code: $EXIT_CODE"
echo "Log file: $LOGFILE"

# Show last few lines of the log if it exists
if [ -f "$LOGFILE" ]; then
    echo.
    echo "Last 20 lines from log file:"
    echo "====================================="
    tail -20 "$LOGFILE"
    echo "====================================="

    # Also check for errors
    ERROR_COUNT=$(grep -c "ERROR" "$LOGFILE" 2>/dev/null || echo "0")
    if [ "$ERROR_COUNT" -gt 0 ]; then
        echo "Found $ERROR_COUNT error(s) in the log file."
        echo "To see all errors, run: grep ERROR \"$LOGFILE\""
    fi
else
    echo "Warning: Log file was not created."
fi

echo.
echo "To view the full log later: cat \"$LOGFILE\""
echo "To search for errors: grep ERROR \"$LOGFILE\""
echo "To search for warnings: grep WARNING \"$LOGFILE\""