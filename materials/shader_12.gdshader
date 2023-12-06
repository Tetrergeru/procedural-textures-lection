shader_type canvas_item;

#include "simple_noise.gdshaderinc"
#include "perlin_noise.gdshaderinc"
#include "simplex_noise.gdshaderinc"
#include "voronoi_noise.gdshaderinc"

uniform float Scale = 100;

void fragment() {
	vec2 pos = UV.xy * Scale;
	
	float color = simple_fractal_3(vec3(pos, TIME / 2.0), 10);
	
	COLOR = vec4(vec3(color), 1.0);
}
