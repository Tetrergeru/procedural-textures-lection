shader_type canvas_item;

#include "simple_noise.gdshaderinc"
#include "perlin_noise.gdshaderinc"
#include "simplex_noise.gdshaderinc"
#include "voronoi_noise.gdshaderinc"

uniform float Scale = 1;
uniform float Border = 0.01;

uniform vec3 Color1 : source_color = vec3(0.0);
uniform vec3 Color2 : source_color = vec3(1.0);

void fragment() {
	vec2 pos = UV.xy;
	
	COLOR = vec4(pos, 0.0, 1.0);
}

