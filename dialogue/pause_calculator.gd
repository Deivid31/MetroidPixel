class_name pause_calculator
extends Node

var _pauses := []
const PAUSE_PATTERN := "({p=\\d([.]\\d+)?[}])"
var _pause_regex := RegEx.new()
signal pause_requested(duration)

func _ready() -> void:
	_pause_regex.compile(PAUSE_PATTERN)

func extract_pauses_from_string(source_string: String) -> String: 
	_pauses = [] 
	_find_pauses(source_string)
	return _extract_tags(source_string)
	
func _find_pauses(from_string: String) -> void:
	var _found_pauses := _pause_regex.search_all(from_string)
	for _result in _found_pauses:
  
		var _tag_string := _result.get_string() as String
		var _tag_position := _result.get_start() as int
		var _pause = check_Pause.new(_tag_position, _tag_string)
		_pauses.append(_pause)
	
func _extract_tags(from_string: String) -> String:
	var _custom_regex = RegEx.new()
	_custom_regex.compile("({(.*?)})")
	return _custom_regex.sub(from_string, "", true)

func check_at_position(from_int: int) -> String:
	for _pause in _pauses:
		if _pause.pause_pos == pos:
			emit_signal("pause_requested", _pause.duration)
