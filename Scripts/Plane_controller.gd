extends CharacterBody3D

const SENSITIVITY: float = 0.001
const SPEED: float = 25

@export var yaw: float = 0
@export var pitch: float = 0


@onready var plane = $plane


func _ready(): 
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
#	var anim: Animation = $plane/AnimationPlayer.get_animation("Circle_004Action")
#	anim.loop_mode = Animation.LOOP_LINEAR
#	$plane/AnimationPlayer.speed_scale = 5
#	$plane/AnimationPlayer.play("Circle_004Action")

func _input(event):
	if event is InputEventMouseMotion:
		var delta = event.relative
		pitch -= delta.y * SENSITIVITY
		yaw -= delta.x * SENSITIVITY

func _physics_process(delta):
	# Lerp to direction
	rotation.y = lerp_angle(rotation.y, yaw, 0.05)
	rotation.x = lerp_angle(rotation.x, pitch, 0.05)
	
	# Fake plane movement
	var yaw_strength = clamp(
		lerp_angle(rotation.y, yaw, 1) - rotation.y,
		-1, 1
	)
	plane.rotation.x = lerp_angle(
		plane.rotation.x,
		yaw_strength * PI, 
		0.05
	)

	var pitch_strength = clamp(
		lerp_angle(rotation.x, pitch, 1) - rotation.x, 
		-1, 1
	)
	plane.rotation.z = lerp_angle(
		plane.rotation.z, 
		pitch_strength * PI/5, 
		0.05
	)
	
	
	# Move forward
	velocity = basis.z * SPEED
	move_and_slide()

func lerp_angle(from, to, weight):
	return from + short_angle_dist(from, to) * weight

func short_angle_dist(from, to):
	var max_angle = PI * 2
	var difference = fmod(to - from, max_angle)
	return fmod(2 * difference, max_angle) - difference
