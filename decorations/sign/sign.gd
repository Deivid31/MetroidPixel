extends Sprite2D

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("interact"):
		match get_tree().get_current_scene():
			"test_map":
				pass 

func _on_area_2d_body_entered(body):
	if body.has_node("Camera2D"):
		%Exclamation.visible = true
	

func _on_area_2d_body_exited(body):
	if body.has_node("Camera2D"):
		%Exclamation.visible = false
