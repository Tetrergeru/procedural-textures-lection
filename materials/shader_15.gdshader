shader_type canvas_item;

#include "simple_noise.gdshaderinc"
#include "perlin_noise.gdshaderinc"
#include "simplex_noise.gdshaderinc"
#include "voronoi_noise.gdshaderinc"

uniform float Scale = 10;

void fragment() {
	vec2 pos = UV.xy * Scale;
	
	vec3 color = debug_simplex_gradient_2(pos, 0.1);
	
	COLOR = vec4(color, 1.0);
}
