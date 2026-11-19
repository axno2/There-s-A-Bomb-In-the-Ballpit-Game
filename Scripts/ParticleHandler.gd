extends Node

@onready var P1: RigidBody2D = $"../Players/1"
@onready var P2: RigidBody2D = $"../Players/2"

@onready var RedParticle = load("res://Assets/Textures/RedParticle.png")
@onready var BlueParticle = load("res://Assets/Textures/BlueParticle.png")

@onready var Particle: PackedScene = load("res://Scenes/CollisionParticle.tscn")

func SpawnParticles(PlayerNumber: String, LinearVel: Vector2, Amt: int, Strength: int) -> void:
	
	var Target = P2
	if PlayerNumber == "1":
		Target = P1
	
	for i in Amt:
		
		var NewParticle = Particle.instantiate()
		add_child(NewParticle)
		NewParticle.global_position = Target.global_position
		var RandomVelocity = Vector2.RIGHT.rotated(randf_range(0, TAU)) * randf_range(100*Strength, 400*Strength)
		NewParticle.linear_velocity = LinearVel*0.4 + RandomVelocity
		
		var ParticleSprite: Sprite2D = NewParticle.get_node("Sprite2D")
		if PlayerNumber == "1":
			ParticleSprite.texture = BlueParticle
		else: ParticleSprite.texture = RedParticle
