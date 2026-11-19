extends Node

@onready var BombSpawnCooldown: Timer = $BombSwapCooldown
var BombTimerDone: bool = true
@onready var ExplosionCountdown: Timer = $ExplosionCountdown

@onready var P1: RigidBody2D = $"Players/1"
@onready var P2: RigidBody2D = $"Players/2"
@onready var P1Fire: CPUParticles2D = $"Players/1/Fire"
@onready var P2Fire: CPUParticles2D = $"Players/2/Fire"

@onready var P1Sprite: Sprite2D = $"Players/1/Skin"
@onready var P2Sprite: Sprite2D = $"Players/2/Skin"

@onready var BombTimerLabel: Label = $BombTimerLabel

#@onready var RoundManager: Node = $"../RoundManager"

@onready var ExplosionSFX = $ExplosionSFX

var BombHolder: int
var Exploded: bool = false

func AdjustBombSprite():
	
	if BombHolder == 1:
		P1Sprite.texture = load("res://Assets/Textures/P1Armed.png")
		P2Sprite.texture = load("res://Assets/Textures/P2.png")
		P2Fire.emitting = false
		P1Fire.emitting = true
	if BombHolder == 2:
		P2Sprite.texture = load("res://Assets/Textures/P2Armed.png")
		P1Sprite.texture = load("res://Assets/Textures/P1.png")
		P2Fire.emitting = true
		P1Fire.emitting = false

func _ready() -> void:
	
	ExplosionCountdown.start()
	
	BombHolder = randi_range(1,2)
	AdjustBombSprite()
	
func RegisterPlayerCollision():
	
	if BombTimerDone == false:
		return
	if Exploded == true:
		return

	if BombHolder == 1:
		print("switched bomb from 1 to 2")
		BombHolder = 2
	elif BombHolder == 2:
		print("switched bomb from 2 to 1")
		BombHolder = 1
		
	AdjustBombSprite()
		
	BombSpawnCooldown.start()
	BombTimerDone = false
	
func _physics_process(_delta: float) -> void:
	
	var PDistance = P1.global_position.distance_to(P2.global_position)
	
	if PDistance < 200:
		Engine.time_scale = 0.35
	else: Engine.time_scale = 1
	if PDistance < 50:
		RegisterPlayerCollision()
		
	BombTimerLabel.text = str((round(10*ExplosionCountdown.time_left))/10)

func _on_bomb_swap_cooldown_timeout() -> void:
	
	BombTimerDone = true

func _on_explosion_countdown_timeout() -> void:
	
	#print(RoundManager)
	#RoundManager = $"../RoundManager"
	
	if BombHolder == 1:
		P1.Explode()
		P1.hide()
		RoundManager.EndMatch(2)
	else: 
		P2.Explode()
		P2.hide()
		RoundManager.EndMatch(1)
		
	ExplosionSFX.play()
		
	Exploded = true
