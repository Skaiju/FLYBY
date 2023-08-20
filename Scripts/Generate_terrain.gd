@tool
extends StaticBody3D

@export var update = false

var terrain: MeshInstance3D
var terrain_collider: CollisionShape3D
var water: PackedScene = preload("res://Scenes/Water.tscn")
var cam: PackedScene = preload("res://Scenes/Cam.tscn")

var noise_amplitude: int = 260
var noise_scale: float = 0.3
var terrain_res: int = 1
var size: int = 20
var water_height: int = 8

func _ready():
	terrain = $"Terrain Mesh"
	terrain_collider = $"Terrain Collider"
	gen_terrain()
	gen_water()

func gen_water():
	var this_water = water.instantiate()
	add_child(this_water)
	this_water.scale = Vector3(size,1,size)
	this_water.position = Vector3(position.x + size/2,water_height,position.z + size/2)
	
func _process(_delta):
	if update:
		gen_terrain()
		update = false
	for i in terrain.get_children():
		i.free()

func exp_height(x: float, scale: float = 1.2):
	x = clampf(x, -1, 1)
	return 2.71828 ** (x * scale - scale) - 0.22

func gen_terrain():
	var p_noise = FastNoiseLite.new()
	var offset_noise = position
	var surf_tool = SurfaceTool.new()
	
	surf_tool.begin(Mesh.PRIMITIVE_TRIANGLES)
	size = size/terrain_res
	noise_scale = noise_scale*terrain_res
	
	for z in size:
		for x in size:
			var height_point = exp_height(p_noise.get_noise_2d(x*noise_scale+offset_noise,z*noise_scale+offset_noise))*noise_amplitude
			
			var uv = Vector2(inverse_lerp(0,size,x),inverse_lerp(0,size,z))
			surf_tool.set_uv(uv)
			surf_tool.add_vertex(Vector3(x*terrain_res,height_point,z*terrain_res))
			if x == size-1 or z == size-1: continue			
			
			surf_tool.add_index(x+(z*size))
			surf_tool.add_index(1+x+(z*size))
			surf_tool.add_index(size+x+(z*size))
			
			surf_tool.add_index(size+x+(z*size))
			surf_tool.add_index(1+x+(z*size))	
			surf_tool.add_index(size+1+x+(z*size))
			
	surf_tool.generate_tangents()
	surf_tool.generate_normals()
	terrain.mesh = surf_tool.commit()
	terrain_collider.shape = terrain.mesh.create_trimesh_shape()
