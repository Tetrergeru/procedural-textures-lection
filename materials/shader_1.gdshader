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
	vec2 pos = UV.xy * Scale;
	
	vec3 color;
	if (UV.x > 0.5) {
		if (UV.y > 0.5) {
			color = vec3(mix(Color1, Color2, simple_fractal_3(vec3(pos, TIME / 2.0), 4)));
		} else {
			color = vec3(mix(Color1, Color2, perlin_fractal_3(vec3(pos, TIME / 2.0), 4)));
		}
 	} else {
		if (UV.y > 0.5) {
			color = vec3(mix(Color1, Color2, floor(simplex_fractal_3(vec3(pos, TIME / 2.0), 4) * 2.0) / 2.0));
		} else {
			float v = voronoi_fractal_3(vec3(pos, TIME / 2.0), 1).x;
			color = vec3(mix(Color1, Color2, float(v < 0.5 && v > 0.25)) );
		}
	}
	//vec3 color = debug_simplex_gradient_2(pos);
	
	//vec3 color = debug_perlin_gradient_2(pos, Border / Scale);
	
	
	
	//vec3 color = debug_simplex_gradient_2(pos, Border);
	
	//vec3 
	
	//vec3 color = vec3(u_random(hash_3(int(pos.x), int(pos.y), int(TIME * 100.0))));
	
	COLOR = vec4(color, 1.0);
}

