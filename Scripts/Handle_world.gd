@tool
extends Node3D

var chunk: PackedScene = preload("res://Scenes/Terrain_chunk.tscn")

var chunk_size: float = 20
var render_distance: float = 2
func _ready():
	handle_chunks()

func handle_chunks():
	
	for z in 1 + render_distance*2:	
		for x in 1 + render_distance*2:
			var this_chunk = chunk.instantiate()
			this_chunk.position = Vector3(x,0,z) * (chunk_size - 1)
			add_child(this_chunk)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
