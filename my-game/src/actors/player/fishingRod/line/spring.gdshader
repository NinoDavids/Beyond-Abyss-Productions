shader_type spatial;
render_mode blend_mix, depth_draw_opaque, cull_disabled, diffuse_lambert, specular_schlick_ggx;

uniform vec4 Color : source_color = vec4(0.585062, 0.585062, 0.585062, 1.000000);



void fragment() {
// ColorParameter:2
	vec4 n_out2p0 = Color;


// Output:0
	ALBEDO = vec3(n_out2p0.xyz);


}