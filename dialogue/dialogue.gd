class_name Dialogue
extends Control

@onready var content := get_node("Text") as RichTextLabel
@onready var type_timer := get_node("TypeTyper") as Timer
@onready var pause_timer := get_node("PauseTimer") as Timer
@onready var _calc := get_node("PauseCalculator") as PauseCalculator

#func _ready() -> void:
#	await get_tree().create_timer(1.0).timeout
#	update_message("[wave]Howdy![/wave]{p=0.5} I was generated for the dialogue system test...{p=0.5} for the godot game engine!")
  
# Update the message and starts typing
func update_message(message: String) -> void:
	content.bbcode_text = _calc.extract_pauses_from_string(message)
	content.visible_characters = 0
	type_timer.start()
	
func _on_type_typer_timeout() -> void:
	_calc.check_at_position(content.visible_characters)
	if content.visible_characters < content.text.length():
		content.visible_characters += 1
	else:
		type_timer.stop()

func _on_pause_calculator_pause_requested(duration: float) -> void:
	type_timer.stop()
	pause_timer.wait_time = duration
	pause_timer.start()
	
func _on_pause_timer_timeout() -> void:
	type_timer.start()

func message_is_fully_visible() -> bool:
	if content.visible_characters == content.text.length():
		return true
	return false
