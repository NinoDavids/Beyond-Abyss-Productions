shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform float brightness : hint_range(0.0, 100, 0.1) = 3.0;
uniform float alpha: hint_range(0.0, 1.0, 0.1) = 0.0;

void fragment() {
    COLOR = texture(SCREEN_TEXTURE, SCREEN_UV);
    float avg = (COLOR.r + COLOR.g + COLOR.b) / brightness;
    COLOR.rgb = vec3(avg);
	COLOR.a = alpha;
}