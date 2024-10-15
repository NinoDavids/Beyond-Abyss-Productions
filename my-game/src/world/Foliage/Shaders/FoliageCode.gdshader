shader_type spatial;
render_mode diffuse_burley, depth_prepass_alpha, shadows_disabled,  specular_toon, ensure_correct_normals,fog_disabled ;


group_uniforms color;
uniform sampler2D alpha;
uniform vec3 color : source_color = vec3(0.223, 0.6, 0.21);
uniform vec3 color2: source_color = vec3(0.774, 0.597, 0.49);
uniform sampler2D noise;
uniform float noiseScale : hint_range(1, 25, 0.1) = 5;
uniform bool flipNormal = false;

varying vec3 worldPos;

group_uniforms wind;
uniform sampler2D WindNoise;
uniform float windSpeed: hint_range(0.0, .1, 0.001) = .1;
uniform float windStrenght: hint_range(0.0, 0.1, 0.001) = .001;
uniform vec3 windDirection = vec3(1,1,1);

void vertex() {
	if (flipNormal){
		NORMAL = -NORMAL;
	}
	
			
		worldPos = (MODEL_MATRIX * vec4(VERTEX, 0.0)).xyz;

		vec3 beshToBillBoard = (vec4(vec3(UV, 0.0), 0.0) * VIEW_MATRIX).xyz;
		vec3  billBoardToCamera = (vec4(beshToBillBoard, .0) * MODEL_MATRIX).xyz;
		
		float offset = TIME * windSpeed;
		float noise_tex = texture(WindNoise, vec2(worldPos.x-offset)).r;
		noise_tex -= .5;
		noise_tex *= windStrenght;
		VERTEX += billBoardToCamera + noise_tex * length(VERTEX.y) * length(VERTEX.xz) * windDirection;
	

	

}

void fragment() {
   	ALPHA = texture(alpha, UV).r;
   	ALPHA = step(.1, ALPHA);

	vec3 noiseLevel = texture(noise, worldPos.xz / noiseScale).rgb;

	ALBEDO = mix(color, color2, 1) * mix(color, color2, noiseLevel);
	NORMAL = FRONT_FACING ? NORMAL : -NORMAL;

}