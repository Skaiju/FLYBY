
extends Node3D

var chunk: PackedScene = preload("res://Scenes/Terrain_chunk.tscn")
var player: Node3D
var chunk_size: float = 20
var render_distance: float = 2
var chunks:= {}
var current_chunk: Vector2 = Vector2(200,200)
var updated_chunk = current_chunk
var grid_size = (1 + render_distance*2)
var offset = int(-grid_size/2)


func _ready():
	player = $Player
	updated_chunk = Vector2(int(player.position.x/chunk_size),int(player.position.z/chunk_size))	
	initialize_chunks()
	

func check_current_chunk():
	updated_chunk = Vector2(int(player.position.x/chunk_size),int(player.position.z/chunk_size))
	if current_chunk != updated_chunk:
		handle_chunks()
		print(chunks.size())
		current_chunk = updated_chunk
	
func initialize_chunks():
	for z in grid_size:
		for x in grid_size:
			
			var this_chunk = chunk.instantiate()
			var chunk_pos = updated_chunk + Vector2(x + offset,z + offset)
			
			this_chunk.position = Vector3(chunk_pos.x, 0, chunk_pos.y) * (chunk_size - 1)
			add_child(this_chunk)
			chunks[chunk_pos] = this_chunk


func handle_chunks():
	for z in grid_size:
		for x in grid_size:
			
			var chunk_pos = updated_chunk + Vector2(x + offset,z + offset)
				
			if !chunks.has(chunk_pos):
				var this_chunk = chunk.instantiate()
				this_chunk.position = Vector3(chunk_pos.x, 0, chunk_pos.y) * (chunk_size - 1)
				add_child(this_chunk)
				chunks[chunk_pos] = this_chunk


func _process(delta):
	check_current_chunk()
	await get_tree().create_timer(1.0).timeout
