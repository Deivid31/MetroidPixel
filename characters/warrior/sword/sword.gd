extends AnimatedSprite2D

var can_attack = true


func _process(delta):
	
	
	if frame == 6:
		await get_tree().create_timer(0.15).timeout
		stop()
		visible = false
		get_parent().sprite.play("idle")
		
	elif flip_h == true:
		rotation += 0.6
	else:
		rotation -= 0.6


func attack(damage, flip):
	if !visible:
		if flip:
			flip_h = true
			%DamageBox.position.x = 10
			position = Vector2(10, 0)
			rotation = -64.5
		else:
			flip_h = false
			%DamageBox.position.x = -10
			position = Vector2(-4, 0)
			rotation = 64.5
		visible = true
		play("attack")
		
