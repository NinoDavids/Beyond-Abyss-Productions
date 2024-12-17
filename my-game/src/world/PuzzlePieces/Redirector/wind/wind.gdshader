shader_type spatial;

uniform float time_scale = 1.5;
uniform float side_to_side = 0.1;
uniform float pivot = 1.0;
uniform float wave = 1.0;
uniform float twist = 1.0;

void vertex() {
	float time = TIME * time_scale;
	VERTEX.x += cos(time) * side_to_side;
	
	float pivot_angle = cos(time) * 0.1 * pivot;
	mat2 rotation_matrix = mat2(vec2(cos(pivot_angle), -sin(pivot_angle)), vec2(sin(pivot_angle), cos(pivot_angle)));
	VERTEX.xz = rotation_matrix * VERTEX.xz;
	
	float body = (VERTEX.z + 1.0) / 0.25;
	VERTEX.x += cos(time + body) * wave;
	
	float twist_angle = cos(time + body) * 0.3 * twist;
	mat2 twist_matrix = mat2(vec2(cos(twist_angle), -sin(twist_angle)), vec2(sin(twist_angle), cos(twist_angle)));
	VERTEX.xy = twist_matrix * VERTEX.xy;
}
