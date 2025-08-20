// CC0, ElSuicio, 2025.
shader_type canvas_item;

uniform vec4 _Color : source_color = vec4(0.0, 0.0, 0.0, 1.0);

uniform float _Radius : hint_range(0.0, 10.0, 0.01) = 0.5;
uniform float _Smoot : hint_range(0.0, 1.0, 0.01) = 0.01;
uniform vec2 _Position = vec2(0.5, 0.5);

float one_minus_f(in float input)
{
	return 1.0 - input;
}

float circle(in float radius, in float smoot, in vec2 position, in vec2 st)
{
	smoot = max(smoot, 0.0001); // Prev div 0.

	vec2 p = position - st;
	float r = length(p);

	return smoothstep(radius, radius - smoot, r);
}

void fragment() {
	// SCREEN_PIXEL_SIZE.x == 1 / 1920 == 0.00052.
	// SCREEN_PIXEL_SIZE.y == 1 / 1080 == 0.00092.

	// RESOLUTION.x == 1.0 / SCREEN_PIXEL_SIZE.x == 1920.
	// RESOLUTION.y == 1.0 / SCREEN_PIXEL_SIZE.y == 1080.

	vec2 resolution = 1.0 / SCREEN_PIXEL_SIZE; // Get resolution.

	vec2 st = UV; // Base UV.

	float fix_pos = resolution.x / resolution.y;

	st.x *= fix_pos; // Fix UV ratio.

	vec2 pos = _Position;
	pos.x *= fix_pos; // Fix position.

	COLOR *= vec4(one_minus_f( circle(_Radius, _Smoot, pos, st) )) * _Color;
}