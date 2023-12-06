#include "random.gdshaderinc"
#include "simplex_noise.gdshaderinc"

vec2 vornoi_deleting_delta_2(ivec2 pos) {
	float x = s_random(hash_3(pos.x, pos.y, 1));
	float y = s_random(hash_3(pos.x, pos.y, 2)) * sqrt(1.0 - x * x);
	return vec2(x, y) * 0.5;
}

#define SCALE 10.0

float voronoi_deleting_color_2(ivec2 pos) {
	//float rand = simplex_fractal_2(vec2(pos) / SCALE, 4);
	float rand = u_random(hash_3(pos.x, pos.y, 3));
	return rand;
}

bool voronoi_deleting_delete_2(ivec2 pos, float delete_chance) {
	float rand = simplex_fractal_2(vec2(pos + ivec2(1000)) / SCALE, 4);
	return rand < delete_chance;
}

vec2 voronoi_deleting_2(vec2 pos, float delete_chance) {
	ivec2 ipos = ivec2(floor(pos));
	
	float dist = 1.0 / 0.0;
	float color = 1.0 / 0.0;
	
	for (int i = -3; i <= 3; i++)
	for (int j = -3; j <= 3; j++) {
		ivec2 l_ipos = ipos + ivec2(i, j);
		
		if (voronoi_deleting_delete_2(l_ipos, delete_chance)) {
			continue;
		}
		
		vec2 voronoi_pos = vec2(l_ipos) + vornoi_deleting_delta_2(l_ipos);
		float l_dist = distance(pos, voronoi_pos);
		
		if (dist > l_dist) {
			dist = l_dist;
			color = voronoi_deleting_color_2(l_ipos);
		}
	}
	
	return vec2(dist, color);
}
