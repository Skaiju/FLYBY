
extends Node3D

var chunk: PackedScene = preload("res://Scenes/Terrain_chunk.tscn")
var player: Node3D
var chunk_size: float = 40
var render_distance: float = 5
var chunks:= {}
var current_chunk: Vector2 = Vector2(200,200)
var updated_chunk = current_chunk
var grid_size = (1 + render_distance*2)
var offset = int(-grid_size/2)


func _ready():
	player = $Plane
	await get_tree().create_timer(1.0).timeout		
	updated_chunk = Vector2(int(player.position.x/chunk_size),int(player.position.z/chunk_size))
	initialize_chunks()
	print(chunks.size())
	current_chunk = updated_chunk	
	check_current_chunk()


func initialize_chunks():
	for z in grid_size:
		for x in grid_size:
			
			var chunk_pos = updated_chunk + Vector2(x + offset,z + offset)
			
			var this_chunk = chunk.instantiate()
			this_chunk.position = Vector3(chunk_pos.x, 0, chunk_pos.y) * (chunk_size - 1)
			add_child(this_chunk)
			chunks[chunk_pos] = this_chunk
			
			
func check_current_chunk():
	while true:
		updated_chunk = Vector2(int(player.position.x/chunk_size),int(player.position.z/chunk_size))

		if current_chunk != updated_chunk:
			handle_chunks()
			current_chunk = updated_chunk
			
		await get_tree().create_timer(0.1).timeout
		
	


func handle_chunks():
	var old_chunks = []
	var old_chunks_pos = []
	var count = 0
	for chunk_pos in chunks:
		var distance = Vector2(abs(chunk_pos.x - updated_chunk.x), abs(chunk_pos.y - updated_chunk.y))
#		print("dist: ", distance)
		if distance.x > render_distance or distance.y > render_distance:
			old_chunks.append(chunks[chunk_pos])
			old_chunks_pos.append(chunk_pos)
			count+=1
	for chunk_pos in old_chunks_pos:
		chunks.erase(chunk_pos)
	
	for z in grid_size:
		for x in grid_size:
			
			var chunk_pos = updated_chunk + Vector2(x + offset,z + offset)
			if !chunks.has(chunk_pos):
				if old_chunks.is_empty(): break
				chunks[chunk_pos] = old_chunks[0] 	
				old_chunks.remove_at(0)	
				chunks[chunk_pos].position = Vector3(chunk_pos.x, 0, chunk_pos.y) * (chunk_size - 1)
				chunks[chunk_pos]._ready()
				await get_tree().create_timer(0.1).timeout		
				
			



