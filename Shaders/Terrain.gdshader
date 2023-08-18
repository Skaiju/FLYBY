shader_type spatial;

uniform sampler2D sand : source_color;
uniform sampler2D grass : source_color;
uniform sampler2D snow : source_color;

uniform float min_sand_height = 5;
uniform float max_grass_height = 13;

varying float vertex_y;
uniform vec2 uv_scale = vec2(5);

void fragment() {
	float vert_height = vertex_y;
	//albedo vals
	vec3 sand_albedo = texture(sand,UV*uv_scale).rgb;	
	vec3 grass_albedo = texture(grass,UV*uv_scale).rgb;
	vec3 snow_albedo = texture(snow,UV*uv_scale).rgb;	
	
	float weight_1 = smoothstep(min_sand_height, max_grass_height,vertex_y);
	vec3 final_color = mix(sand_albedo, grass_albedo, weight_1 + 0.1);
	
	ALBEDO = final_color.rgb;

}

void vertex(){
	vertex_y = VERTEX.y;
}
