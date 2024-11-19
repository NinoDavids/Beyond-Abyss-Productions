shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform float frequency = 1;


void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 new_uv = SCREEN_UV;
	new_uv.y += sin(new_uv.x * frequency + TIME) * 0.01;
	
	vec3 new_colors = texture(SCREEN_TEXTURE, new_uv, 0.0).rgb;
	
	COLOR.rgb = new_colors;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
