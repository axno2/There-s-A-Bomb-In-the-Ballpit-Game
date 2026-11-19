extends TextureRect

func _ready() -> void:
	pass # Replace with function body.

#var OriginalPosY = self.global_position.y
var Tick = 0

func _process(delta: float) -> void:
	
	Tick += 1
	
	#global_position.y = sin(Tick*0.1)*15+OriginalPosY
	offset_transform_rotation = 0 + sin(Tick*0.1)*0.2
