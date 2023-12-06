#include "random.gdshaderinc"

vec2 simplex_gradient_2(ivec2 pos) {
	float x = s_random(hash_3(pos.x, pos.y, 1));
	float y = s_random(hash_3(pos.x, pos.y, 2));
	return normalize(vec2(x, y));
}

float simplex_noise_2(vec2 pos) {
	const float F_2 = (sqrt(2.0 + 1.0) - 1.0) / 2.0;
	const float G_2 = (1.0 - 1.0 / sqrt(2.0 + 1.0)) / 2.0;
	
	float skew = (pos.x + pos.y) * F_2;
	vec2 skew_pos = vec2(pos.x + skew, pos.y + skew);
	
    ivec2 i_skew_pos = ivec2(floor(skew_pos));
	
	vec2 sk_l_p = skew_pos - vec2(i_skew_pos);
	
	ivec2[3] simplex_ps = {
		i_skew_pos,
		i_skew_pos + (sk_l_p.x > sk_l_p.y ? ivec2(1, 0) : ivec2(0, 1)),
		i_skew_pos + ivec2(1, 1)
	};

	float res = 0.0;
	
	for (int i = 0; i < 3; i++) {
		vec2 simplex_pos = vec2(simplex_ps[i]);
		
		float unskew = (simplex_pos.x + simplex_pos.y) * G_2;
		vec2 unskew_pos = vec2(simplex_pos.x - unskew, simplex_pos.y - unskew);
	
		vec2 unskew_local_pos = pos - vec2(unskew_pos);
		
		float r_2 = 0.6;
		float d_2 = dot(unskew_local_pos, unskew_local_pos);
		float r_d = max(r_2 - d_2, 0.0);
		float r_d_4 = pow(r_d, 4.0);
		
		vec2 grad = simplex_gradient_2(simplex_ps[i]);
		res += dot(unskew_local_pos, grad) * r_d_4 * 25.0;
	}
	
	res = res * 0.5 + 0.5;
	return res;
}

const float F_3 = (sqrt(3.0 + 1.0) - 1.0) / 3.0;
const float G_3 = (1.0 - 1.0 / sqrt(3.0 + 1.0)) / 3.0;

vec3 simplex_gradient_3(ivec3 pos) {
	float x = s_random(hash_3(pos.x, pos.y, 1));
	float y = s_random(hash_3(pos.x, pos.y, 2));
	float z = s_random(hash_3(pos.x, pos.y, 3));
	return normalize(vec3(x, y, z));
}

ivec3[4] sort_simplex_verts_3(ivec3 ipos, vec3 lp) {
	ivec3[4] simplex_ps;
	
	int hi = lp.x > lp.y ? (lp.x > lp.z ? 0 : 2) : (lp.y > lp.z ? 1 : 2);
	int lo = lp.x < lp.y ? (lp.x < lp.z ? 0 : 2) : (lp.y < lp.z ? 1 : 2);
	
	simplex_ps[0] = ipos;
	
	ipos[hi] += 1;
	simplex_ps[1] = ipos;
	
	ipos[3 - hi - lo] += 1;
	simplex_ps[2] = ipos;
	
	ipos[lo] += 1;
	simplex_ps[3] = ipos;
	
	return simplex_ps;
}

float simplex_noise_3(vec3 pos) {
	float skew = (pos.x + pos.y + pos.z) * F_3;
	vec3 skew_pos = vec3(pos.x + skew, pos.y + skew, pos.z + skew);
	
    ivec3 i_skew_pos = ivec3(floor(skew_pos));
	
	vec3 skew_local_pos = skew_pos - vec3(i_skew_pos);
	
	ivec3[4] simplex_ps = sort_simplex_verts_3(i_skew_pos, skew_local_pos);

	float res = 0.0;
	
	for (int i = 0; i < 4; i++) {
		vec3 simplex_pos = vec3(simplex_ps[i]);
		
		float unskew = (simplex_pos.x + simplex_pos.y + simplex_pos.z) * G_3;
		vec3 unskew_pos = vec3(simplex_pos.x - unskew, simplex_pos.y - unskew, simplex_pos.z - unskew);
	
		vec3 unskew_local_pos = pos - vec3(unskew_pos);
		
		float r_2 = 0.6;
		float d_2 = dot(unskew_local_pos, unskew_local_pos);
		float r_d = max(r_2 - d_2, 0.0);
		float r_d_4 = pow(r_d, 4.0);
		
		vec3 grad = simplex_gradient_3(simplex_ps[i]);
		res += dot(unskew_local_pos, grad) * r_d_4 * 25.0;
	}
	
	res = res * 0.5 + 0.5;
	return res;
}

float simplex_fractal_2(vec2 pos, int iters) {
	float res = 0.0;
	float scale = 1.0;
	float sum = 0.0;

	for (int i = 0; i < iters; i++) {
		res += simplex_noise_2(pos * scale) / scale;
		sum += 1.0 / scale;
		scale *= 2.0;
	}
	
	return smooth_step(0, 1, res / sum);
}

float simplex_fractal_3(vec3 pos, int iters) {
	float res = 0.0;
	float scale = 1.0;
	float sum = 0.0;

	for (int i = 0; i < iters; i++) {
		res += simplex_noise_3(pos * scale) / scale;
		sum += 1.0 / scale;
		scale *= 2.0;
	}
	
	return smooth_step(0, 1, res / sum);
}

vec3 debug_simplex_gradient_2(vec2 pos, float border) {
	const float F_2 = (sqrt(2.0 + 1.0) - 1.0) / 2.0;
	const float G_2 = (1.0 - 1.0 / sqrt(2.0 + 1.0)) / 2.0;
	
	vec2 skew_pos = vec2(
		pos.x + (pos.x + pos.y) * F_2,
		pos.y + (pos.x + pos.y) * F_2
	);
	
    ivec2 i_skew_pos = ivec2(floor(skew_pos));
	
	vec2 skew_local_pos = skew_pos - vec2(i_skew_pos);
	
	ivec2[3] simplex_ps = {
		i_skew_pos,
		i_skew_pos + (skew_local_pos.x > skew_local_pos.y ? ivec2(1, 0) : ivec2(0, 1)),
		i_skew_pos + ivec2(1, 1)
	};

	float res = 0.0;
	
	for (int i = 0; i < 3; i++) {
		vec2 simplex_pos = vec2(simplex_ps[i]);
		
		float unskew = (simplex_pos.x + simplex_pos.y) * G_2;
		vec2 uns = vec2(simplex_pos.x - unskew, simplex_pos.y - unskew);
	
		vec2 l_p = pos - vec2(uns);
		
		vec2 grad = simplex_gradient_2(simplex_ps[i]);
		
		mat2 rot = mat2(vec2(grad.y, grad.x), vec2(grad.x, -grad.y));
		vec2 r_pos = rot * l_p;
		
		if (abs(r_pos.x) + abs(r_pos.y / 5.0) < 0.1 && r_pos.y > 0.0) {
			return vec3(1.0, 0.0, 0.0);
		}
	}
	
	//float c = u_random(hash_3(i_skew_pos.x, i_skew_pos.y, simplex_ps[1].x));
	float c = simplex_noise_2(pos);
	return vec3(c);
}