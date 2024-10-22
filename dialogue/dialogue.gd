extends Control

@onready var content := get_node("Text") as RichTextLabel
@onready var type_timer := get_node("Timer") as Timer
@onready var pause_timer := get_node("PauseTimer") as Timer
@onready var _calc := get_node("PauseCalculator") as Node

# We are going to use this logic to test, will be removed later
func _ready() -> void:
	await get_tree().create_timer(1.0).timeout
	update_message("Hi I was generated for the dialogue system test for the godot game engine")
  
# Update the message and starts typing
func update_message(message: String) -> void:
	content.bbcode_text = _calc.extract_pauses_from_string(message)
	content.visible_characters = 0
	type_timer.start()
	
func _on_timer_timeout() -> void:
	pause_calculator.check_at_position(content.visible_characters)
	if content.visible_characters < content.text.length():
		content.visible_characters += 1
	else:
		type_timer.stop()

func _on_PauseCalculator_pause_requested(duration: float) -> void:
	type_timer.stop()
	pause_timer.wait_time = duration
	pause_timer.start()
	
func _on_PauseTimer_timeout() -> void:
	type_timer.start()
