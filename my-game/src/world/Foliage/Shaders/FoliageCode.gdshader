shader_type spatial;
render_mode  cull_disabled,diffuse_burley, depth_prepass_alpha, shadows_disabled,alpha_to_coverage_and_one, depth_draw_always, specular_toon, ensure_correct_normals ;



uniform sampler2D alpha;
uniform vec3 color : source_color = vec3(0.223, 0.6, 0.21);
uniform vec3 color2: source_color = vec3(0.774, 0.597, 0.49);
uniform sampler2D noise;
uniform float noiseScale : hint_range(1, 25, 0.1) = 5;

varying vec3 worldPos;




void vertex() {

	worldPos = (MODEL_MATRIX * vec4(VERTEX, 0.0)).xyz;

	vec3 beshToBillBoard = (vec4(vec3(UV, 0.0), 1.0) * VIEW_MATRIX).xyz;
	vec3  billBoardToCamera = (vec4(beshToBillBoard, 1.0) * MODEL_MATRIX).xyz;
	vec3 conformBillBoardToMesh = billBoardToCamera + VERTEX;
	VERTEX = conformBillBoardToMesh;

}

void fragment() {
	vec3 noiseLevel = texture(noise, worldPos.xz / noiseScale).rgb;
	ALPHA = texture(alpha, UV).r;
	ALBEDO = mix(color, color2, 1) * mix(color, color2, noiseLevel);
	if(!FRONT_FACING){
		NORMAL = -NORMAL;
	}

}
