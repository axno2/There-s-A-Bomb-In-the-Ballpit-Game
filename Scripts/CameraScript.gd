extends Camera2D

@export var ZoomSpeed: float = 3.0
@export var FollowSpeed: float = 5.0
@export var ZoomPadding: float = 1.5

@onready var P1: RigidBody2D = $"../Players/1"
@onready var P2: RigidBody2D = $"../Players/2"

func _physics_process(Delta: float) -> void:
	
	var Midpoint: Vector2 = (P1.global_position + P2.global_position) / 2.0
	global_position = global_position.lerp(Midpoint*0.5, FollowSpeed * Delta)
	
	var Distance: float = P1.global_position.distance_to(P2.global_position)
	
	var ViewportSize: Vector2 = get_viewport_rect().size
	var TargetZoom: float = min(
		ViewportSize.x / (Distance * ZoomPadding),
		ViewportSize.y / (Distance * ZoomPadding)
	)
	TargetZoom = clamp(TargetZoom, 1, 1.2)
	
	zoom = zoom.lerp(Vector2.ONE * TargetZoom, ZoomSpeed * Delta)
