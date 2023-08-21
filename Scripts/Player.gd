extends Node3D

var movement: Vector3 = Vector3.ZERO
var speed: float = 10
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position += movement*speed*delta
	
func _input(event):
	movement = Vector3(Input.get_axis("right", "left"), Input.get_axis("down", "up"), Input.get_axis("back", "forward"))	
