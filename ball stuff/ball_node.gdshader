shader_type spatial;
render_mode blend_mix,depth_draw_opaque,cull_back,diffuse_burley,specular_schlick_ggx,unshaded,shadows_disabled;
uniform vec3 colour;

float fresnel(float amount, vec3 normal, vec3 view)
{
	return pow((1.0 - clamp(dot(normalize(normal), normalize(view)), 0.0, 1.0 )), amount);
}

void fragment()
{
	float basic_fresnel = fresnel(3.0, NORMAL, VIEW);
	ALBEDO = colour + basic_fresnel;
}
