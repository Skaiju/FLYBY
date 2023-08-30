extends Camera3D

@onready var camera_points: Array[Node3D] = [$"../plane/FirstPerson", $"../ThirdPerson"]

var active_camera_mount: Node3D
var active_camera_index: int = 1

func _ready():
	active_camera_mount = camera_points[active_camera_index]

func _physics_process(delta):
	global_position = lerp(global_position, active_camera_mount.global_position, 0.15)
	global_rotation = lerp(global_rotation, active_camera_mount.global_rotation, 0.15)

func _input(event):
	if Input.is_action_just_pressed("change_camera"):
		active_camera_index = (active_camera_index + 1) % camera_points.size()
		active_camera_mount = camera_points[active_camera_index]
