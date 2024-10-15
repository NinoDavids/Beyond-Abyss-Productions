shader_type spatial;
render_mode cull_disabled;

group_uniforms color;
uniform  vec3 colorLight: source_color;
uniform  vec3 colorDark: source_color;
uniform sampler2D noise;
uniform float noiseScale = 20;

group_uniforms wind;
uniform float wind_speed: hint_range(0.0, 2.0, 0.01) = .1;
uniform float wind_strength: hint_range(0.0, 1.0, 0.01) = .01;
uniform sampler2D windNoise;

varying vec3 worldPos;



void vertex() {
	worldPos = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
	
	float offset = TIME * wind_speed;
	float noise_tex = texture(windNoise, vec2(worldPos.y-offset)).r;
	noise_tex -= .5;
	noise_tex *= wind_strength;
	VERTEX.y += noise_tex * length(VERTEX.y) * length(VERTEX.xz);
	
}

void fragment() {
	
	
	vec3 noiseLevel = texture((noise), worldPos.xz/ noiseScale).rgb;
	ALBEDO = mix(colorDark, colorLight, UV.y) * mix(colorDark, colorLight, noiseLevel.r);
	
	NORMAL = FRONT_FACING ? NORMAL : -NORMAL;
}

