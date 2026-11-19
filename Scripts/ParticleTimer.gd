extends RigidBody2D

@onready var ParticleTimer: Timer = $Timer
@onready var ParticleSprite: Sprite2D = $Sprite2D

func _ready() -> void:
	
	var RandomSize = randf_range(0.7, 1.3)
	ParticleSprite.scale = Vector2(RandomSize, RandomSize)
	
	ParticleTimer.start()
	var FadeTween = create_tween()
	FadeTween.tween_property(ParticleSprite, "modulate:a", 0.0, 3)
	FadeTween.tween_callback(queue_free)

func _on_timer_timeout() -> void:
	queue_free()
