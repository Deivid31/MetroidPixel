class_name DialogueManager
extends Node
	
const DIALOGUE_SCENE := preload("dialogue.tscn")
@onready var opacity_tween := get_node("OpacityTween") as Node
	
signal message_requested()
signal message_completed()
signal finished()
	
var _messages := []
var _active_dialogue_offset := 0
var _is_active := false
var cur_dialogue_instance: Dialogue
	
func show_messages(message_list: Array, position: Vector2) -> void:
		# Only allow triggering if its not currently showing something
	if _is_active:
		return
	_is_active = true
	
	_messages = message_list
	_active_dialogue_offset = 0
	
	var _dialogue = DIALOGUE_SCENE.instantiate()
	_dialogue.connect("message_completed", _on_message_completed)
	get_tree().get_root().add_child(_dialogue)
	cur_dialogue_instance = _dialogue
	_show_current()
	
func _show_current() -> void:
	message_requested.emit()
	var _msg := _messages[_active_dialogue_offset] as String
	cur_dialogue_instance.update_message(_msg)

func _input(event: InputEvent) -> void:
	if (
		event.is_pressed() and
		!event.is_echo() and
		event is InputEventKey and
		event.keycode == KEY_ENTER and
		_is_active and
		cur_dialogue_instance.message_is_fully_visible()
		):
		if _active_dialogue_offset < _messages.size() - 1:
			_active_dialogue_offset += 1
			_show_current()
		else:
			_hide()

func _hide() -> void:
	cur_dialogue_instance.disconnect("message_completed", _on_message_completed)
	cur_dialogue_instance.queue_free()
	cur_dialogue_instance = null
	_is_active = false
	finished.emit()

func _on_message_completed() -> void:
	message_completed.emit()
