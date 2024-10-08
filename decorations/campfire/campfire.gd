extends AnimatedSprite2D



func _ready():
	play("off")


func _on_area_2d_body_entered(body):
	if body.has_node("Camera2D"):
		%exclamation.visible = true
	


func _on_area_2d_body_exited(body):
	if body.has_node("Camera2D"):
		%exclamation.visible = false
