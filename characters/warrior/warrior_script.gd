extends CharacterBody2D

@onready var sword = get_node("Sword")
@onready var sprite = get_node("Sprite")
@onready var pause_menu = $Menu
var paused = false

var movement = true
var gravity = 100
var speed = 800

var max_health = 3
var health = max_health


func _ready():
	sprite.play()


func _process(delta):
	velocity.y += gravity
	if Input.is_action_just_pressed("pause"):
		pauseMenu()
	
	if Input.is_action_pressed("move_left") and movement:
		velocity.x = -speed
		sprite.animation = "walk"
		sprite.flip_h = false
		sprite.offset = Vector2(0, 0)
		
	elif Input.is_action_pressed("move_right") and movement:
		velocity.x = speed
		sprite.animation = "walk"
		sprite.flip_h = true
		sprite.offset = Vector2(5, 0)
		
	elif sprite.animation != "attack":
		sprite.animation = "idle"
		velocity.x = 0
		
	else:
		velocity.x = 0
	
	
	if Input.is_action_pressed("jump") and is_on_floor() and movement:
		velocity.y = -1700
	
	
	if Input.is_action_just_pressed("attack") and movement:
		sword.attack(1, sprite.flip_h)
		sprite.play("attack")
	
	move_and_slide()
		
func pauseMenu():
	if paused:
		pause_menu.hide()
		get_tree().paused = false
	else:
		pause_menu.show()
		get_tree().paused = true
		
	paused = !paused
