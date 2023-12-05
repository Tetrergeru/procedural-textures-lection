shader_type canvas_item;

uniform float Scale = 15.0;

void fragment() {
	vec2 pos = UV.xy * Scale;
	
	ivec2 ipos = ivec2(floor(pos));
	float color = float((ipos.x + ipos.y) % 2 == 0);
	
	COLOR = vec4(vec3(color), 1.0);
}

