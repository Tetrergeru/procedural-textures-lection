#include "random.gdshaderinc"
#include "simplex_noise.gdshaderinc"

vec2 vornoi_weighted_delta_2(ivec2 pos) {
	float x = s_random(hash_3(pos.x, pos.y, 1));
	float y = s_random(hash_3(pos.x, pos.y, 2)) * sqrt(1.0 - x * x);
	return vec2(x, y) * 0.5;
}

#define SCALE 5.0

float voronoi_weighted_color_2(ivec2 pos) {
	float rand = simplex_fractal_2(vec2(pos) / SCALE, 5);
	return rand;//u_random(hash_3(pos.x, pos.y, 3));
}

float voronoi_weighted_weight_2(ivec2 pos) {
	//float rand = u_random(hash_3(pos.x, pos.y, 3));
	float rand = simplex_fractal_2(vec2(pos) / SCALE, 5);
	return mix(0.1, 1.0, rand);
}

vec3 voronoi_weighted_2(vec2 pos) {
	ivec2 ipos = ivec2(floor(pos));
	
	float dist = 1.0 / 0.0;
	float color = 1.0 / 0.0;
	float weight = 1.0 / 0.0;
	
	for (int i = -2; i <= 2; i++)
	for (int j = -2; j <= 2; j++) {
		ivec2 l_ipos = ipos + ivec2(i, j);
		vec2 voronoi_pos = vec2(l_ipos) + vornoi_weighted_delta_2(l_ipos);
		float l_dist = distance(pos, voronoi_pos);
		float l_weight = voronoi_weighted_weight_2(l_ipos);
		
		if (dist * weight > l_dist * l_weight) {
			dist = l_dist;
			color = voronoi_weighted_color_2(l_ipos);
			weight = l_weight;
		}
	}
	
	return vec3(dist, color, weight);
}
