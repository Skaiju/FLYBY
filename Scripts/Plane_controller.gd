extends CharacterBody3D

const SENSITIVITY: float = 1
const SPEED: float = 15

@export var roll: float = 0
@export var pitch: float = 0
var roll_strength: float = 0
var pitch_strength: float = 0
var roll_angle: float = 80
@onready var plane = $plane


