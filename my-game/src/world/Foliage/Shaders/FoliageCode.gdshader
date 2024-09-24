shader_type spatial;
render_mode  cull_disabled, diffuse_lambert, specular_toon, depth_prepass_alpha, shadows_disabled;

uniform sampler2D alpha;
uniform vec3 color : source_color = vec3(0.223, 0.6, 0.21);
uniform vec3 color2: source_color = vec3(0.774, 0.597, 0.49);
varying vec3 worldPos;
uniform sampler2D noise;
uniform float noiseScale : hint_range(0, 40, 0.1) = 5;




void vertex() {

	worldPos = (MODEL_MATRIX * vec4(VERTEX, .0)).xyz;

	vec3 beshToBillBoard = (vec4(vec3(UV, 0.0), 1.0) * VIEW_MATRIX).xyz;
	vec3  billBoardToCamera = (vec4(beshToBillBoard, 1.0) * MODEL_MATRIX).xyz;
	vec3 conformBillBoardToMesh = billBoardToCamera + VERTEX;
	VERTEX = conformBillBoardToMesh;

}

void fragment() {

	vec3 noiseLevel = texture(noise, worldPos.xz / noiseScale).rgb;
	ALPHA = texture(alpha, UV).r;
	ALBEDO = mix(color, color2, UV.x) * mix(color, color2, noiseLevel.r);
	if(!FRONT_FACING){
		NORMAL = -NORMAL;
	}

}
