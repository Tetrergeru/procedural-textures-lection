#include "random.gdshaderinc"

float simple_noise_2(vec2 pos) {
    ivec2 ipos = ivec2(floor(pos));
    ivec2 inxt = ivec2(floor(pos)) + ivec2(1);
	
	float p00 = u_random(hash_2(ipos.x, ipos.y));
    float p01 = u_random(hash_2(ipos.x, inxt.y));
    float p10 = u_random(hash_2(inxt.x, ipos.y));
    float p11 = u_random(hash_2(inxt.x, inxt.y));

    float p0 = smooth_step(p00, p10, pos.x - float(ipos.x));
    float p1 = smooth_step(p01, p11, pos.x - float(ipos.x));
	
	float p = smooth_step(p0, p1, pos.y - float(ipos.y));

    return p;
}

float simple_noise_3(vec3 pos) {
    ivec3 ipos = ivec3(floor(pos));
    ivec3 inxt = ivec3(floor(pos)) + ivec3(1);

    float p000 = u_random(hash_3(ipos.x, ipos.y, ipos.z));
    float p001 = u_random(hash_3(ipos.x, ipos.y, inxt.z));
    float p010 = u_random(hash_3(ipos.x, inxt.y, ipos.z));
    float p011 = u_random(hash_3(ipos.x, inxt.y, inxt.z));
    float p100 = u_random(hash_3(inxt.x, ipos.y, ipos.z));
    float p101 = u_random(hash_3(inxt.x, ipos.y, inxt.z));
    float p110 = u_random(hash_3(inxt.x, inxt.y, ipos.z));
    float p111 = u_random(hash_3(inxt.x, inxt.y, inxt.z));

    float r00 = mix(p000, p100, pos.x - float(ipos.x));
    float r10 = mix(p010, p110, pos.x - float(ipos.x));
    float r0 = mix(r00, r10, pos.y - float(ipos.y));

    float r01 = mix(p001, p101, pos.x - float(ipos.x));
    float r11 = mix(p011, p111, pos.x - float(ipos.x));
    float r1 = mix(r01, r11, pos.y - float(ipos.y));
	
	float r = mix(r0, r1, pos.z - float(ipos.z));

    return r;
}

float simple_fractal_2(vec2 pos, int iters) {
	float res = 0.0;
	float scale = 1.0;
	float sum = 0.0;

	for (int i = 0; i < iters; i++) {
		res += simple_noise_2(pos * scale) / scale;
		sum += 1.0 / scale;
		scale *= 2.0;
	}
	
	return smoothstep(0, 1, res / sum);
}

float simple_fractal_3(vec3 pos, int iters) {
	float res = 0.0;
	float scale = 1.0;
	float sum = 0.0;

	for (int i = 0; i < iters; i++) {
		res += simple_noise_3(pos * scale) / scale;
		sum += 1.0 / scale;
		scale *= 2.0;
	}
	
	return smoothstep(0, 1, clamp(res / sum, 0.0, 1.0));
}