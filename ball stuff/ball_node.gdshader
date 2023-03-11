shader_type spatial;

uniform vec3 colour;


void fragment(){
	ALBEDO = colour;
}