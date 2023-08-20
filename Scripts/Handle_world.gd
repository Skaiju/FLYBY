@tool
extends Node3D

var chunk: PackedScene = preload("res://Scenes/Terrain_chunk.tscn")

var chunk_size: int = 20
var random_start:Vector3 = Vector3(randi_range(0,999),0,randi_range(0,999))

var current_cell: Vector3 = Vector3(random_start.x/chunk_size - (random_start.x % chunk_size), 0, random_start.z / chunk_size - (random_start.z % chunk_size))

func _ready():
	handle_chunks()

func handle_chunks():
	var this_chunk = chunk.instantiate()
	this_chunk.position = current_cell*chunk_size
	add_child(this_chunk)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
