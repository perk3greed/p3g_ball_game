// NOTE: Shader automatically converted from Godot Engine 4.0.stable's StandardMaterial3D.

shader_type spatial;
render_mode blend_mix,depth_draw_opaque,cull_back,diffuse_burley,specular_schlick_ggx,unshaded,shadows_disabled;
uniform float opacity;

void fragment() {
	ALBEDO = vec3(1., 1., 1.);
	ALPHA = opacity;
}