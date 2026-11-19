extends Node2D

@onready var Menu = preload("res://Scenes/MainMenu.tscn")

func _ready() -> void:
	
	BackgroundMusic.playing = true
	
	var MenuInstance = Menu.instantiate()
	add_child(MenuInstance)
