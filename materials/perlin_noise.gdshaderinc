#include "random.gdshaderinc"

vec2 perlin_gradient_2(ivec2 pos) {
	float x = s_random(hash_3(pos.x, pos.y, 1));
	float y = s_random(hash_3(pos.x, pos.y, 2));
	return normalize(vec2(x, y));
}

float perlin_noise_2(vec2 pos) {
    ivec2 ipos = ivec2(floor(pos));
    ivec2 inxt = ivec2(floor(pos)) + ivec2(1);
	
	ivec2 p00 = ipos;
	ivec2 p01 = ivec2(ipos.x, inxt.y);
	ivec2 p10 = ivec2(inxt.x, ipos.y);
	ivec2 p11 = inxt;
	
	float v00 = dot(perlin_gradient_2(p00), pos - vec2(p00));
	float v01 = dot(perlin_gradient_2(p01), pos - vec2(p01));
	float v10 = dot(perlin_gradient_2(p10), pos - vec2(p10));
	float v11 = dot(perlin_gradient_2(p11), pos - vec2(p11));
	
    float v0 = smooth_step(v00, v10, pos.x - float(ipos.x));
    float v1 = smooth_step(v01, v11, pos.x - float(ipos.x));
	
	float v = smooth_step(v0, v1, pos.y - float(ipos.y));
	
	return v * 0.5 + 0.5;
}

vec3 perlin_gradient_3(ivec3 pos) {
	float x = s_random(hash_4(pos.x, pos.y, pos.z, 1));
	float y = s_random(hash_4(pos.x, pos.y, pos.z, 2));
	float z = s_random(hash_4(pos.x, pos.y, pos.z, 3));
	return normalize(vec3(x, y, z));
}

float perlin_noise_3(vec3 pos) {
    ivec3 ipos = ivec3(floor(pos));
    ivec3 inxt = ivec3(floor(pos)) + ivec3(1);
	
	ivec3 p000 = ipos;
	ivec3 p001 = ivec3(ipos.x, ipos.y, inxt.z);
	ivec3 p010 = ivec3(ipos.x, inxt.y, ipos.z);
	ivec3 p011 = ivec3(ipos.x, inxt.y, inxt.z);
	ivec3 p100 = ivec3(inxt.x, ipos.y, ipos.z);
	ivec3 p101 = ivec3(inxt.x, ipos.y, inxt.z);
	ivec3 p110 = ivec3(inxt.x, inxt.y, ipos.z);
	ivec3 p111 = inxt;
	
	float v000 = dot(perlin_gradient_3(p000), pos - vec3(p000));
	float v001 = dot(perlin_gradient_3(p001), pos - vec3(p001));
	float v010 = dot(perlin_gradient_3(p010), pos - vec3(p010));
	float v011 = dot(perlin_gradient_3(p011), pos - vec3(p011));
	float v100 = dot(perlin_gradient_3(p100), pos - vec3(p100));
	float v101 = dot(perlin_gradient_3(p101), pos - vec3(p101));
	float v110 = dot(perlin_gradient_3(p110), pos - vec3(p110));
	float v111 = dot(perlin_gradient_3(p111), pos - vec3(p111));
	
    float r00 = smooth_step(v000, v100, pos.x - float(ipos.x));
    float r01 = smooth_step(v001, v101, pos.x - float(ipos.x));
    float r10 = smooth_step(v010, v110, pos.x - float(ipos.x));
    float r11 = smooth_step(v011, v111, pos.x - float(ipos.x));
	
    float r0 = smooth_step(r00, r10, pos.y - float(ipos.y));
    float r1 = smooth_step(r01, r11, pos.y - float(ipos.y));
	
	float r = smooth_step(r0, r1, pos.z - float(ipos.z));
	
	return r * 0.5 + 0.5;
}

float perlin_fractal_2(vec2 pos, int iters) {
	float res = 0.0;
	float scale = 1.0;
	float sum = 0.0;

	for (int i = 0; i < iters; i++) {
		res += perlin_noise_2(pos * scale) / scale;
		sum += 1.0 / scale;
		scale *= 2.0;
	}
	
	return res / sum;
}

float perlin_fractal_3(vec3 pos, int iters) {
	float res = 0.0;
	float scale = 1.0;
	float sum = 0.0;

	for (int i = 0; i < iters; i++) {
		res += perlin_noise_3(pos * scale) / scale;
		sum += 1.0 / scale;
		scale *= 2.0;
	}
	
	return smooth_step(0, 1, res / sum);
}

vec3 debug_perlin_gradient_2(vec2 pos, float border) {
    ivec2 ipos = ivec2(floor(pos));
	
	for (int i = -1; i <= 1; i++)
	for (int j = -1; j <= 1; j++) {
		ivec2 ip = ipos + ivec2(i, j);
		vec2 l_pos = pos - vec2(ip);
		
		vec2 g = perlin_gradient_2(ip);
		mat2 rot = mat2(vec2(g.y, g.x), vec2(g.x, -g.y));
		vec2 r_pos = rot * l_pos;
		
		if (abs(r_pos.x) + abs(r_pos.y / 5.0) < border && r_pos.y > 0.0) {
			return vec3(1.0, 0.0, 0.0);
		}
		
		//if (length(l_pos) < 0.25) {
			//return vec3(dot(perlin_gradient_2(ip), pos - vec2(ip))) * 0.5 + 0.5;
		//}
	}
	
	float g = perlin_noise_2(pos);
	return vec3(g);
}