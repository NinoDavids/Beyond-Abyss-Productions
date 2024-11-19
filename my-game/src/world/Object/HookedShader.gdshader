shader_type spatial;
render_mode blend_mix, cull_front, unshaded;

uniform bool onoff = false;
uniform vec4 color : source_color = vec4(1,0,0,1);
uniform vec4 clear : source_color = vec4(0,0,0,0); //TempColor
uniform float size : hint_range(1.0, 1.5, 0.01) = 1.05;

void vertex() {
	VERTEX *= size;
}
void fragment() {
	if(!onoff)
	{
		ALBEDO = clear.rgb;
		ALPHA = 0.0;
	}
	else
	{
		ALBEDO = color.rgb;
		ALPHA = color.a;
	}
}
