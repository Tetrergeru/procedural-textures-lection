shader_type canvas_item;

#include "simple_noise.gdshaderinc"
#include "perlin_noise.gdshaderinc"
#include "simplex_noise.gdshaderinc"
#include "voronoi_noise.gdshaderinc"
#include "voronoi_deleting.gdshaderinc"

uniform float Scale = 10;
uniform float RotationStrength : hint_range(0.0, 1.0) = 1.0;
uniform vec3 Color1 : source_color = vec3(1.0);
uniform vec3 Color2 : source_color = vec3(0.0);

void fragment() {
	vec2 pos = UV.xy * Scale;
	
	vec2 rot_pos = pos / 3.0;
	float a = simplex_fractal_2(rot_pos, 2) * PI * 2.0 * sin(TIME) * RotationStrength;
	float s = sin(a);
	float c = cos(a);
	mat2 rot = mat2(
		vec2(c, -s),
		vec2(s, c)
	);
	pos = rot * pos;
	
	vec2 l_pos = pos - floor(pos);
	float dist = abs(l_pos.x);
	
	COLOR = vec4(mix(Color1, Color2, dist), 1.0);
}
