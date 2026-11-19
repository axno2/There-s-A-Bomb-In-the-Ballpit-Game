extends Area2D

@export var exit_portal: Marker2D
@onready var timer_1: Timer = $"Timer 1"
@onready var timer_2: Timer = $"Timer 2"

@onready var Whoosh: AudioStreamPlayer2D = $Whoosh

static var can_teleport_1 = true
static var can_teleport_2 = true
func _on_body_entered(body: Node2D) -> void:
	
	if body is RigidBody2D == false:
		return
	
	if body.name == "1" and can_teleport_1:
		timer_1.start()
		can_teleport_1 = false
		Whoosh.play()
		body.set_deferred("global_position", exit_portal.global_position)
		body.linear_velocity = Vector2.UP.rotated(exit_portal.global_rotation) * 500

	elif body.name == "2" and can_teleport_2:
		timer_2.start()
		can_teleport_2 = false
		Whoosh.play()
		body.set_deferred("global_position", exit_portal.global_position)
		body.linear_velocity = Vector2.UP.rotated(exit_portal.global_rotation) * 500


func _on_timer_1_timeout() -> void:
	can_teleport_1 =true

func _on_timer_2_timeout() -> void:
	can_teleport_2 = true
