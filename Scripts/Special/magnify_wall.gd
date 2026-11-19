extends RigidBody2D
@export var bounce_intensity = 1.3
@onready var timer_1: Timer = $"Timer 1"
@onready var timer_2: Timer = $Timer2
var is_timer_1_on = false
var is_timer_2_on = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	contact_monitor = true
	max_contacts_reported = 50
	freeze = true
	freeze_mode = FreezeMode.FREEZE_MODE_KINEMATIC
	lock_rotation = true
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: RigidBody2D) -> void:
	if body.name == "1" and not is_timer_1_on:
		body.linear_velocity*= bounce_intensity
		timer_1.start()
	if body.name == "2" and not is_timer_2_on:
		timer_2.start()
		body.linear_velocity*= bounce_intensity
	#var direction = (body.global_position-global_position).normalized()
	#body.apply_central_impulse(Bounce_intesity*direction)
	#body.linear_velocity*= bounce_intensity
	#print("Collision with: ", body.name)


func _on_timer_1_timeout() -> void:
	is_timer_1_on = false


func _on_timer_2_timeout() -> void:
	is_timer_2_on = false
