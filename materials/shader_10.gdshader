shader_type canvas_item;

#include "simple_noise.gdshaderinc"
#include "perlin_noise.gdshaderinc"
#include "simplex_noise.gdshaderinc"
#include "voronoi_noise.gdshaderinc"

uniform float Scale = 100;

void fragment() {
	vec2 pos = UV.xy * Scale;
	
	ivec2 ipos = ivec2(floor(pos));
	float color = u_random(hash_2(ipos.x, ipos.y));
	
	COLOR = vec4(vec3(color), 1.0);
}
