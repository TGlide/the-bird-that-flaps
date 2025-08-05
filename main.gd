extends Node
class_name Main

@onready var game: Game = $Game

func _on_title_screen_start_button_pressed() -> void:
	game.start()


