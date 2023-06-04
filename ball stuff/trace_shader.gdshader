// NOTE: Shader automatically converted from Godot Engine 4.0.stable's StandardMaterial3D.

shader_type spatial;
uniform float distance_from_ball;

render_mode 

blend_mix
, depth_draw_opaque
, cull_back,diffuse_burley
//, specular_schlick_ggx
, unshaded,shadows_disabled
, specular_toon;

void fragment() {
	ALBEDO = vec3(0.8, 0.2, 0.3);
	ALPHA = 0.7;
}