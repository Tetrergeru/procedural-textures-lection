shader_type canvas_item;

uniform float Stripes = 5.0;
uniform vec3 Color1 : source_color;
uniform vec3 Color2 : source_color;

void fragment() {
	vec2 pos = UV.xy;
	
	float dist = distance(pos, vec2(0.5)) - TIME / 10.0;
	dist = mod(dist * Stripes * 2.0, 1.0);
	vec3 color = mix(Color1, Color2, float(dist > 0.5));
	
	COLOR = vec4(color, 1.0);
}

