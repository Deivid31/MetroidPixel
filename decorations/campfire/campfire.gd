extends AnimatedSprite2D


func _ready():
	play("off")


func _process(delta):
	if Input.is_action_just_pressed("interact"):
		if %Exclamation.visible == true:
			if animation == "on":
				pass
			else:
				play("on")
				%Smoke.emitting = true


func _on_area_2d_body_entered(body):
	if body.has_node("Camera2D"):
		%Exclamation.visible = true
	


func _on_area_2d_body_exited(body):
	if body.has_node("Camera2D"):
		%Exclamation.visible = false
