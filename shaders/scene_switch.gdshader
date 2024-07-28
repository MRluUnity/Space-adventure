shader_type canvas_item;
uniform float scan_progress : hint_range(0, 1);
uniform int mode : hint_range(0, 5) = 0;
uniform vec4 color : source_color;

float mode_switch(int _mode, vec2 _uv){
	float alpha;
	switch (_mode){
		case 0:
			alpha = step(scan_progress, _uv.y);
			break;
		case 1:
			alpha = step(scan_progress, _uv.x);
			break;
		case 2:
			alpha = step(scan_progress * 2., _uv.x + _uv.y);
			break;
		case 3:
			alpha = step(_uv.y, 1. - scan_progress);
			break;
		case 4:
			alpha = step(_uv.x, 1. - scan_progress);
			break;
		case 5:
			alpha = step(_uv.x + _uv.y, 1. - (scan_progress * 2.));
			break;
	};
	return alpha;
}

void fragment() {
    COLOR = color;
    vec2 uv = SCREEN_UV;
	COLOR.a = mode_switch(mode, uv);
}