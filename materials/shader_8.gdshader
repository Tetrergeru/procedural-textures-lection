shader_type canvas_item;

uniform float Scale = 5.0;
uniform float Border : hint_range(0, 1) = 0.6;
uniform float Angle : hint_range(0, 360) = 45.0 ;

void fragment() {
	float s = sin(Angle / 180.0 * PI);
	float c = cos(Angle / 180.0 * PI);
	mat2 rot = mat2(vec2(c, -s), vec2(s, c));
	vec2 pos = rot * UV.xy;
	
	if (distance(pos, vec2(0.0)) < Border) {
		COLOR = vec4(abs(floor(pos * Scale) / Scale), 0.0, 1.0);
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

