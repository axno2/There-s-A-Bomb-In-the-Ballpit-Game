extends Node

var P1Score = 0
var P2Score = 0

@onready var Root = $".."

#@onready var P1ScoreLabel: Label = $"../GameWorld/Camera2D/P1ScoreCounter"
#@onready var P2ScoreLabel: Label = $"../GameWorld/Camera2D/P2ScoreCounter"

@onready var GameWorldSaved = preload("res://Scenes/GameWorld.tscn")
#@onready var CurrentWorld = $"../GameWorld"

@onready var Map1 = preload("res://Scenes/Maps/Map1.tscn")
@onready var Map2 = preload("res://Scenes/Maps/Map2.tscn")
@onready var Map3 = preload("res://Scenes/Maps/Map3.tscn")
@onready var Map4 = preload("res://Scenes/Maps/Map4.tscn")
@onready var Map5 = preload("res://Scenes/Maps/Map5.tscn")
@onready var Map6 = preload("res://Scenes/Maps/Map6.tscn")
@onready var Map7 = preload("res://Scenes/Maps/Map7.tscn")
@onready var Map8 = preload("res://Scenes/Maps/Map8.tscn")

@onready var Maps = [Map1, Map2, Map3, Map4, Map5, Map6, Map7, Map8]
#@onready var Maps = [Map7]

#@onready var CollisionSound = $AudioStreamPlayer2D

var P1ScoreLabel
var P2ScoreLabel
var CurrentWorld: Node

func NewMatch():
	
	get_tree().change_scene_to_packed(GameWorldSaved)
	await get_tree().scene_changed
	var NewGameWorld = get_tree().current_scene
	
	P1ScoreLabel = NewGameWorld.find_child("P1ScoreCounter", true, false)
	P2ScoreLabel = NewGameWorld.find_child("P2ScoreCounter", true, false)
	P1ScoreLabel.text = str(P1Score)
	P2ScoreLabel.text = str(P2Score)
	
	var SelectedMap = Maps.pick_random()
	var WorldMap = NewGameWorld.find_child("Map")
	var MapInstance = SelectedMap.instantiate()
	WorldMap.add_child(MapInstance)
	
	print("Created new world.")
	
func _ready() -> void:
	#REMOVE
	#NewMatch()
	pass

func EndMatch(Winner):
	
	if Winner == 1:
		P1Score += 1
		print("P1 WON")
	else:
		P2Score += 1
		print("P2 WON")
	
	var RoundIntermission = Timer.new()
	RoundIntermission.timeout.connect(_on_round_intermission_timeout)
	RoundIntermission.wait_time = 3
	RoundIntermission.one_shot = true
	add_child(RoundIntermission)
	RoundIntermission.start()
	
func _physics_process(_delta: float) -> void:
	
	if is_instance_valid(P1ScoreLabel) and is_instance_valid(P2ScoreLabel):
		P1ScoreLabel.text = str(P1Score)
		P2ScoreLabel.text = str(P2Score)

func _on_round_intermission_timeout() -> void:
	NewMatch()
	
func StartNewMatch():
			
	NewMatch()
	
	
