extends RigidBody2D

func _ready() -> void:
	contact_monitor = true
	max_contacts_reported = 8

#REFERENCES
@onready var ArrowGuide = $AimGuide
@onready var ParticleHandler = $"../../ParticleHandler"
@onready var ArrowGuideSprite = $AimGuide/Sprite2D

#AIM VARIABLES
@onready var AimDir: float = ArrowGuide.global_rotation_degrees
var TurnVel: float = 0
var TurnAccel: float = 3
var MaxTurnVel: float = 5
var TurnFriction: float = 0.85

#BOOST VARIABLES
var MaxBoostStrength: float = 1000
var BoostGain: float = 60
var CurBoostStrength: float = 0

var Alive: bool = true

func Explode():
	Alive = false
	ParticleHandler.call_deferred("SpawnParticles", name, linear_velocity, 75, 5)

func Impulse():
	var Vector: Vector2
	Vector = Vector2.from_angle(deg_to_rad(AimDir))
	Vector *= CurBoostStrength
	
	apply_central_impulse(Vector)

func PlaySound():
	var Audio = AudioStreamPlayer2D.new()
	Audio.stream = preload("res://Assets/Sounds/Boing.mp3")
	Audio.finished.connect(Audio.queue_free)
	
	get_tree().current_scene.add_child(Audio)
	Audio.global_position = global_position
	Audio.play()

func _physics_process(_delta: float) -> void:
	
	if Alive == false: return
	
	if Input.is_action_pressed("P"+name+"L"):
		TurnVel -= TurnAccel 
	if Input.is_action_pressed("P"+name+"R"):
		TurnVel += TurnAccel
	if TurnVel > MaxTurnVel:
		TurnVel = MaxTurnVel
	if TurnVel < -MaxTurnVel:
		TurnVel = -MaxTurnVel
	AimDir += TurnVel 
	TurnVel *= TurnFriction 
	ArrowGuide.global_rotation_degrees = AimDir
	ArrowGuideSprite.position.x = 29 + 10*(CurBoostStrength/MaxBoostStrength)
	
	if Input.is_action_pressed("P"+name+"I"):
		CurBoostStrength += BoostGain
		if CurBoostStrength > MaxBoostStrength:
			CurBoostStrength = MaxBoostStrength
	if Input.is_action_just_released("P"+name+"I"):
		Impulse()
		CurBoostStrength = 0
		
func _integrate_forces(State: PhysicsDirectBodyState2D) -> void:
	
	if Alive == false: return
	
	if State.get_contact_count() == 0:
		return
	
	var Velocity = State.linear_velocity
	var Speed = Velocity.length()

	if Speed < 750:
		return

	for i in State.get_contact_count():

		var Normal = State.get_contact_local_normal(i)

		var ImpactAngle = rad_to_deg(acos(clamp(abs(Velocity.normalized().dot(Normal)), 0.0, 1.0)))

		if ImpactAngle <= 45:
			PlaySound()
			ParticleHandler.call_deferred("SpawnParticles", name, linear_velocity, 7, 1)
			break
			

	
	
