extends CharacterBody3D

const SENSITIVITY: float = 1
const SPEED: float = 1000

@export var roll: float = 0
@export var pitch: float = 0
var roll_dir: float = 0
var pitch_dir: float = 0
var roll_angle: float = 80
var roll_vel: float = 8
var pitch_vel: float = 3
var smooth:float = 0.05
var omega_roll:float = deg_to_rad(120)
var omega_pitch:float = deg_to_rad(80)
var roll_str = 0
var pitch_str = 0

@onready var plane = $plane
	
func smooth_acc(strength:float, delta:float, omega:float):
	return sin(strength * PI/2) * delta * omega

func increment_vel(strength:float,dir:float):
	strength += smooth if dir > 0 else -smooth if dir < 0 else -sign(strength)*min(smooth,abs(strength))
	return clampf(strength,-1.0,1.0)
	
func _physics_process(delta):
	roll_dir = Input.get_axis("roll_left", "roll_right")
	pitch_dir = Input.get_axis("pitch_up", "pitch_down")
	
	
	pitch_str = increment_vel(pitch_str,pitch_dir)
	roll_str = increment_vel(roll_str,roll_dir)
	
	var roll = smooth_acc(roll_str,delta,omega_roll)
	var pitch = smooth_acc(pitch_str,delta,omega_pitch)
	
	rotate_object_local(Vector3.FORWARD,-roll)
	rotate_object_local(Vector3.RIGHT, pitch)
	#rotate_object_local(Vector3.RIGHT,pitch)
#	rotate_object_local(Vector3.RIGHT,lerpf(rotation.z, -pitch, smooth))
	
#	local_rotation.z = lerpf(local_rotation.z, roll, smooth)
#	local_rotation.x = lerpf(local_rotation.x, pitch, smooth)
	velocity = transform.basis.z  * SPEED * delta
	move_and_slide()
