extends Node

enum States { IDLE, FLY, DEAD }
var state: States = States.IDLE

func _on_player_hit() -> void:
	Global.state = States.DEAD

