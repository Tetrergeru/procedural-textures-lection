shader_type canvas_item;

#include "simple_noise.gdshaderinc"
#include "perlin_noise.gdshaderinc"
#include "simplex_noise.gdshaderinc"
#include "voronoi_noise.gdshaderinc"
#include "voronoi_deleting.gdshaderinc"

uniform float Scale = 10;
uniform float DeleteChance : hint_range(0.0, 1.0) = 0.0;

void fragment() {
	vec2 pos = UV.xy * Scale;
	
	float color = voronoi_deleting_2(pos, DeleteChance).y;
	
	COLOR = vec4(vec3(color), 1.0);
}
