
extends Node3D

var chunk: PackedScene = preload("res://Scenes/Terrain_chunk.tscn")
var player: Node3D
var chunk_size: float = 20
var render_distance: float = 2
var chunk_list: Array = []
var chunk_pos_list: Array = []
var current_chunk: Vector2 = Vector2(200,200)
var updated_chunk = current_chunk
func _ready():
	player = $Player
	#handle_chunks(current_chunk)

func check_current_chunk():
	updated_chunk = Vector2(int(player.position.x/chunk_size),int(player.position.z/chunk_size))
	if current_chunk != updated_chunk:
		print("new chunk")
		print(chunk_list.size())
		handle_chunks(updated_chunk)
		current_chunk = updated_chunk
	

func handle_chunks(updated_center: Vector2):
	var temp_chunk_pos_list = []
	var temp_chunk_list = []
	var grid_size = (1 + render_distance*2)
	var offset = int(-grid_size/2)
	for z in grid_size:
		for x in grid_size:
			var this_cell = Vector2(x + offset + updated_center.x,z + offset + updated_center.y)
			var this_chunk = chunk.instantiate()
			this_chunk.position = Vector3(this_cell.x, 0, this_cell.y) * (chunk_size - 1)
			add_child(this_chunk)
			temp_chunk_pos_list.append(this_cell)
			temp_chunk_list.append(this_chunk)
	
	var chunk_list_size = chunk_pos_list.size()		
	var temp_list_size = temp_chunk_pos_list.size()
	
	if chunk_list_size > 0:
		#first add new chunks
		for i in temp_list_size:
			var this_temp_chunk_pos = temp_chunk_pos_list[i]
			if this_temp_chunk_pos not in chunk_pos_list:
				var this_temp_chunk = temp_chunk_list[i]
				chunk_pos_list.append(this_temp_chunk_pos)
				chunk_list.append(this_temp_chunk)
		
		#then remove unwanted chunks	
		for i in 25:
			var this_chunk_pos = chunk_pos_list[i]
			var this_chunk = chunk_list[i] as StaticBody3D
			if this_chunk_pos not in temp_chunk_pos_list:
				chunk_pos_list.erase(this_chunk_pos)
				chunk_list.erase(this_chunk)
				this_chunk.queue_free()
								
	else:
		for i in temp_list_size:
			chunk_pos_list.append(temp_chunk_pos_list[i])
			chunk_list.append(temp_chunk_list[i])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	check_current_chunk()
