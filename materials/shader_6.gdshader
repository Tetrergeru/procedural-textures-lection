shader_type canvas_item;

uniform float Stripes = 5.0;
uniform vec3 Color1 : source_color;
uniform vec3 Color2 : source_color;

void fragment() {
	vec2 pos = UV.xy;
	
	vec3 color = mix(Color1, Color2, clamp(pos.x, 0.0, 1.0));
	
	COLOR = vec4(color, 1.0);
}

