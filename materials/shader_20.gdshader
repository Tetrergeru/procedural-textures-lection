shader_type canvas_item;

#include "simple_noise.gdshaderinc"
#include "perlin_noise.gdshaderinc"
#include "simplex_noise.gdshaderinc"
#include "voronoi_noise.gdshaderinc"
#include "voronoi_deleting.gdshaderinc"

uniform float Scale = 10;
uniform vec3 Color1 : source_color = vec3(1.0);
uniform vec3 Color2 : source_color = vec3(0.0);

void fragment() {
	vec2 pos = UV.xy * Scale;
	
	float color = mix(0.5, 1.0, voronoi_noise_3(vec3(pos, TIME)).x);
	
	COLOR = vec4(mix(Color1, Color2, color), 1.0);
}
