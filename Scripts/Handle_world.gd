@tool
extends Node3D

var chunk: PackedScene = preload("res://Scenes/Terrain_chunk.tscn")

var chunk_size: float = 20
var render_distance: float = 10
func _ready():
	handle_chunks()

func handle_chunks():
	
	for z in render_distance:	
		for x in render_distance:
			var this_chunk = chunk.instantiate()
			this_chunk.position = Vector3(x,0,z) * (chunk_size - 1)
			add_child(this_chunk)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
