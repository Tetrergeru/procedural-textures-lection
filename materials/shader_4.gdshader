shader_type canvas_item;

uniform float Stripes = 5.0;

void fragment() {
	vec2 pos = UV.xy;
	float dist = distance(pos, vec2(0.5));
	dist = mod(dist * Stripes * 2.0, 1.0);
	float color;
	
	if (pos.x + pos.y < 1.0) {
		color = dist;
	} else {
		color = float(dist > 0.5);
	}
	
	COLOR = vec4(vec3(color), 1.0);
}

