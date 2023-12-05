shader_type canvas_item;

uniform float Scale = 5.0;

void fragment() {
	vec2 pos = UV.xy;
	
	if (UV.x + UV.y < 1.0) {
		COLOR = vec4(floor(UV.xy * Scale) / Scale, 0.0, 1.0);
	} else {
		pos *= Scale;
		vec2 lpos = pos - floor(pos);
		float dist = min(
			min(lpos.x, lpos.y),
			min(1.0 - lpos.x, 1.0 - lpos.y)
		) * 2.0;
		COLOR = vec4(vec3(1.0) * dist, 1.0);
	}
}

