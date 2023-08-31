extends Camera3D

@onready var camera_points: Array[Node3D] = [$"../ThirdPerson", $"../plane/FirstPerson", $"../plane/FirstPerson2"]

var active_camera_mount: Node3D
var active_camera_index: int = 0
var smooth:float = 0.7
func _ready():
	active_camera_mount = camera_points[active_camera_index]

func _physics_process(delta):
	global_position = lerp(global_position, active_camera_mount.global_position, 0.15)
	global_rotation.x = lerp_angle(global_rotation.x, active_camera_mount.global_rotation.x, smooth)
	global_rotation.y = lerp_angle(global_rotation.y, active_camera_mount.global_rotation.y, smooth)
	global_rotation.z = lerp_angle(global_rotation.z, active_camera_mount.global_rotation.z, smooth)

func _input(event):
	if Input.is_action_just_pressed("change_camera"):
		active_camera_index = (active_camera_index + 1) % camera_points.size()
		active_camera_mount = camera_points[active_camera_index]
