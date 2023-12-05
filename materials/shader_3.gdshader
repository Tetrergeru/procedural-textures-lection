shader_type canvas_item;

uniform float Border : hint_range(0, 1);

void fragment() {
	vec2 pos = UV.xy;
	
	float dist = distance(pos, vec2(0.5));
	float binary = float(dist > Border) / 2.0;
	
	COLOR = vec4(vec3(binary), 1.0);
}

