shader_type canvas_item;

void fragment() {
	vec2 pos = UV.xy;
	
	float dist = distance(pos, vec2(0.5));
	
	COLOR = vec4(vec3(dist), 1.0);
}

