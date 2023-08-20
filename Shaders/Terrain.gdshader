shader_type spatial;

uniform sampler2D pebbles : source_color;
uniform sampler2D sand : source_color;
uniform sampler2D grass : source_color;
uniform sampler2D rock : source_color;
uniform sampler2D snow : source_color;

const float pebble_sand_height = 9.0;
const float pebble_sand_transition = 3.0;

const float sand_grass_height = 14.0;
const float sand_grass_transition = 8.0;

const float grass_rock_height = 40.0;
const float grass_rock_transition = 20.0;

const float rock_snow_height = 80.0;
const float rock_snow_transition = 10.0;

varying float vertex_y;
uniform vec2 uv_scale = vec2(5);

void fragment() {
	float vert_height = vertex_y;
	//albedo vals
	vec3 pebbles_albedo = texture(pebbles,UV*uv_scale).rgb;	
	vec3 sand_albedo = texture(sand,UV*uv_scale).rgb;
	vec3 grass_albedo = texture(grass,UV*uv_scale).rgb;	
	vec3 rock_albedo = texture(rock,UV*uv_scale).rgb;		
	vec3 snow_albedo = texture(snow,UV*uv_scale).rgb;	
	
	float weight_1 = smoothstep(pebble_sand_height - pebble_sand_transition/2.0, pebble_sand_height + pebble_sand_transition/2.0,vertex_y);
	float weight_2 = smoothstep(sand_grass_height - sand_grass_transition/2.0, sand_grass_height + sand_grass_transition/2.0,vertex_y);
	float weight_3 = smoothstep(grass_rock_height - grass_rock_transition/2.0, grass_rock_height + grass_rock_transition/2.0,vertex_y);
	float weight_4 = smoothstep(rock_snow_height - rock_snow_transition/2.0, rock_snow_height + rock_snow_transition/2.0,vertex_y);
		
	vec3 final_color;
	if (vertex_y < pebble_sand_height + pebble_sand_transition/2.0)
	{
		final_color = mix(pebbles_albedo, sand_albedo, weight_1);
	}
	else if (vertex_y > pebble_sand_height + pebble_sand_transition/2.0 && vertex_y < sand_grass_height + sand_grass_transition/2.0)
	{
		 final_color = mix(sand_albedo, grass_albedo, weight_2);
	}
	else if (vertex_y > sand_grass_height + sand_grass_transition/2.0 && vertex_y < grass_rock_height + grass_rock_transition/2.0)
	{
		final_color = mix(grass_albedo, rock_albedo, weight_3);
	}
	else
	{
		final_color = mix(rock_albedo, snow_albedo, weight_4);
	}
	
	
	ALBEDO = final_color.rgb;

}

void vertex(){
	vertex_y = VERTEX.y;
}
