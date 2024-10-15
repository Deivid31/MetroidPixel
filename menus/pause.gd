extends Control

@onready var main = $"../"

func _on_start_button_pressed():
	main.pauseMenu()


func _on_quit_button_pressed():
	get_tree().quit()
