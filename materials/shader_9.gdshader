shader_type canvas_item;

#include "simple_noise.gdshaderinc"
#include "perlin_noise.gdshaderinc"
#include "simplex_noise.gdshaderinc"
#include "voronoi_noise.gdshaderinc"

uniform float Scale = 10;
uniform vec3 Color1 : source_color = vec3(0.0);
uniform vec3 Color2 : source_color = vec3(1.0);

void fragment() {
	vec2 pos = UV.xy * Scale;
	
	vec3 color;
	if (UV.x < 0.5) {
		if (UV.y < 0.5) {
			color = vec3(mix(Color1, Color2, simple_fractal_3(vec3(pos, TIME / 2.0), 1)));
		} else {
			color = vec3(mix(Color1, Color2, perlin_fractal_3(vec3(pos, TIME / 2.0), 1)));
		}
 	} else {
		if (UV.y < 0.5) {
			color = vec3(mix(Color1, Color2, simplex_fractal_3(vec3(pos, TIME / 2.0), 1)));
		} else {
			float v = voronoi_fractal_3(vec3(pos, TIME / 2.0), 1).x;
			color = vec3(mix(Color1, Color2, v));
		}
	}
	
	COLOR = vec4(color, 1.0);
}
