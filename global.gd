extends Node

enum States { IDLE, FLY, DEAD }
var state: States 
var points: int 

func reset() -> void:
	state = States.IDLE
	points = 0

func _ready() -> void:
	reset()

func _on_player_hit() -> void:
	Global.state = States.DEAD

