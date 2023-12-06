shader_type spatial;
render_mode skip_vertex_transform;

#include "simple_noise.gdshaderinc"
#include "perlin_noise.gdshaderinc"
#include "simplex_noise.gdshaderinc"
#include "voronoi_noise.gdshaderinc"
#include "voronoi_deleting.gdshaderinc"

uniform float Scale = 10;
uniform float Roughness : hint_range(0.0, 1.0) = 0.2;
uniform vec3 Color1 : source_color = vec3(1.0);
uniform vec3 Color2 : source_color = vec3(0.0);

varying vec3 WorldPos;

void vertex() {
	vec3 pos = VERTEX * Scale;
	WorldPos = pos;
	
	VERTEX = (MODELVIEW_MATRIX * vec4(VERTEX, 1.0)).xyz;
	NORMAL = normalize((MODELVIEW_MATRIX * vec4(NORMAL, 0.0)).xyz);
	
	//VERTEX += NORMAL * voronoi_noise_3(pos).x * Roughness;
	VERTEX += NORMAL * simplex_fractal_3(pos, 10) * Roughness;
}

void fragment() {
	//float color = voronoi_noise_3(WorldPos).x * 1.1;
	float color = simplex_fractal_3(WorldPos, 3) * 1.1;
	color = color * 2.0 - 1.0;
	color = floor(color * 5.0) / 5.0; 
	ALBEDO = mix(Color1, Color2, color);
}
