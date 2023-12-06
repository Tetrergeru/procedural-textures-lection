shader_type canvas_item;

#include "simple_noise.gdshaderinc"
#include "perlin_noise.gdshaderinc"
#include "simplex_noise.gdshaderinc"
#include "voronoi_noise.gdshaderinc"

uniform float Scale = 10;

void fragment() {
	vec2 pos = UV.xy * Scale;
	
	float color = perlin_fractal_2(pos, 10);
	
	COLOR = vec4(vec3(color), 1.0);
}
