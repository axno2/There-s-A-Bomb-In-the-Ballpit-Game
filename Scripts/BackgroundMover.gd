extends Sprite2D

@export var FollowSpeed: float = 5.0
@export var ZoomPadding: float = 1.5

@onready var P1: RigidBody2D = $"../Players/1"
@onready var P2: RigidBody2D = $"../Players/2"

func _physics_process(Delta: float) -> void:
	
	var Midpoint: Vector2 = (P1.global_position + P2.global_position) / 2.0
	global_position = global_position.lerp(-(Midpoint*0.05), FollowSpeed * Delta)
	
