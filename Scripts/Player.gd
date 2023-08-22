extends Node3D

var movement: Vector3 = Vector3.ZERO
var target: Vector3
var smoothness: float = 0.2
var speed: float = 20
# Called when the node enters the scene tree for the first time.
func _ready():
	target = position

func _process(delta):
	target += movement

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position = lerp(position, target, smoothness)*speed*delta
	
func _input(event):
	movement = Vector3(Input.get_axis("right", "left"), Input.get_axis("down", "up"), Input.get_axis("back", "forward")).normalized()	
