shader_type canvas_item;

uniform vec4 top: hint_color = vec4(0.0, 0.05, 0.15, 1.0);
uniform vec4 bottom: hint_color = vec4(0.0, 0.5, 0.88, 1.0);

uniform vec4 circle_top: hint_color = vec4(0.27, 0.24, 0.9, 1.0);
uniform vec4 circle_bottom: hint_color = vec4(1.0, 0.56, 0.35, 1.0);

uniform float horizon_top = 0.4;
uniform float horizon_bottom = 0.6;
uniform float circle_radius = -0.1;
uniform float circle_feather = 0.55;

float circle(vec2 position, float radius, float feather)
{
	return smoothstep(radius, radius + feather, length(position - vec2(0.5)));
}

void fragment(){
	// Only the top half of the shader is shown above the 3D horizon.
	float compressed_y = smoothstep(horizon_top, horizon_bottom, UV.y);
	//create a vertical gradient
	vec3 sky = mix(top.xyz, bottom.xyz, vec3(compressed_y));
	vec3 alternate = mix(circle_top.xyz, circle_bottom.xyz, vec3(compressed_y));
	//create a vertical gradient
	float circle = circle(UV, circle_radius, circle_feather);
	// blend the two vertical gradients using an x value
	vec4 sky_total = vec4(mix(alternate, sky, vec3(circle)), 1.0);
	COLOR = sky_total;
}
