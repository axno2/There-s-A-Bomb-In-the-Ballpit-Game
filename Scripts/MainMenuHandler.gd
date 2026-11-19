extends Node

func _on_play_button_pressed() -> void:
	queue_free()
	RoundManager.NewMatch()
	
