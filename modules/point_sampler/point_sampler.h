#ifndef POINT_SAMPLER_H
#define POINT_SAMPLER_H

#include "core/object/ref_counted.h"
#include "scene/resources/mesh.h"

class PointSampler : public RefCounted {
	GDCLASS(PointSampler, RefCounted);

	AABB aabb;
	Vector<Face3> faces;
	Vector<float> cumulative_areas;
	Vector<Vector3> point_samples;
	Vector<Vector3> normal_samples;

protected:
	static void _bind_methods();

public:

	void init(const Ref<Mesh> &mesh);
	void random(int amount, uint64_t seed);
	void poisson(float radius, float density, uint64_t seed);

	Vector<Vector3> get_point_samples() const;
	Vector<Vector3> get_normal_samples() const;

	PointSampler();
};

#endif // POINT_SAMPLER_H
