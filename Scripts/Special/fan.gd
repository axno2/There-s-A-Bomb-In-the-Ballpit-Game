extends Area2D
@export var Push_intensity = 2500
var bodies_inside: Array[RigidBody2D]=[]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	
	for body in bodies_inside:
		body.apply_central_force(Vector2.UP*Push_intensity)
	#print(bodies_inside)




func _on_body_entered(body: Node) -> void:
	print(body.name)
	bodies_inside.append(body)
	print(body)



func _on_body_exited(body: Node) -> void:
	bodies_inside.erase(body)
