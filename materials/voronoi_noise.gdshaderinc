#include "random.gdshaderinc"

vec2 vornoi_delta_2(ivec2 pos) {
	float x = s_random(hash_3(pos.x, pos.y, 1));
	float y = s_random(hash_3(pos.x, pos.y, 2)) * sqrt(1.0 - x * x);
	return vec2(x, y) * 0.5;
}

float voronoi_color_2(ivec2 pos) {
	return u_random(hash_3(pos.x, pos.y, 3));
}

vec2 voronoi_noise_2(vec2 pos) {
	ivec2 ipos = ivec2(floor(pos));
	
	float dist = 1.0 / 0.0;
	float color = 1.0 / 0.0;
	
	for (int i = -1; i <= 1; i++)
	for (int j = -1; j <= 1; j++) {
		ivec2 l_ipos = ipos + ivec2(i, j);
		vec2 voronoi_pos = vec2(l_ipos) + vornoi_delta_2(l_ipos);
		float l_dist = distance(pos, voronoi_pos);
		
		if (dist > l_dist) {
			dist = l_dist;
			color = voronoi_color_2(l_ipos);
		}
	}
	
	return vec2(dist, color);
}

vec3 vornoi_delta_3(ivec3 pos) {
	float x = s_random(hash_4(pos.x, pos.y, pos.z, 1));
	float y = s_random(hash_4(pos.x, pos.y, pos.z, 2)) * sqrt(1.0 - x * x);
	float z = s_random(hash_4(pos.x, pos.y, pos.z, 3)) * sqrt(1.0 - x * x - y * y);
	return vec3(x, y, z) * 0.5;
}

float voronoi_color_3(ivec3 pos) {
	return u_random(hash_4(pos.x, pos.y, pos.z, 4));
}

vec2 voronoi_noise_3(vec3 pos) {
	ivec3 ipos = ivec3(floor(pos));
	
	float dist = 1.0 / 0.0;
	float color = 1.0 / 0.0;
	
	for (int i = -1; i <= 1; i++)
	for (int j = -1; j <= 1; j++)
	for (int k = -1; k <= 1; k++) {
		ivec3 l_ipos = ipos + ivec3(i, j, k);
		vec3 voronoi_pos = vec3(l_ipos) + vornoi_delta_3(l_ipos);
		float l_dist = distance(pos, voronoi_pos);
		
		if (dist > l_dist) {
			dist = l_dist;
			color = voronoi_color_3(l_ipos);
		}
	}
	
	return vec2(dist, color);
}

float voronoi_fractal_2(vec2 pos, int iters) {
	float res = 0.0;
	float scale = 1.0;
	float sum = 0.0;

	for (int i = 0; i < iters; i++) {
		res += voronoi_noise_2(pos * scale).x / scale;
		sum += 1.0 / scale;
		scale *= 2.0;
	}
	
	return smooth_step(0, 1, res / sum);
}

vec2 voronoi_fractal_3(vec3 pos, int iters) {
	vec2 res = vec2(0.0);
	float scale = 1.0;
	float sum = 0.0;

	for (int i = 0; i < iters; i++) {
		res += voronoi_noise_3(pos * scale) / scale;
		sum += 1.0 / scale;
		scale *= 2.0;
	}
	
	return res / sum;
}
