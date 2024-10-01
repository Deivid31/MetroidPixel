extends CharacterBody2D

var movement = true
var gravity = 125
var speed = 800

func _ready():
	%Sprite.play()


func _process(delta):
	
	velocity.y += gravity
	
	if Input.is_action_pressed("move_left"):
		velocity.x = -speed
		%Sprite.animation = "walk"
		%Sprite.flip_h = false
		%Sprite.offset = Vector2(0, 0)
		
	elif Input.is_action_pressed("move_right"):
		velocity.x = speed
		%Sprite.animation = "walk"
		%Sprite.flip_h = true
		%Sprite.offset = Vector2(5, 0)
		
	else:
		%Sprite.animation = "idle"
		velocity.x = 0
	
	
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = -2000
	
	
	if Input.is_action_just_pressed("menu"):
		get_tree().quit()
	
	move_and_slide()
		
