extends Node

@onready var camera: Camera2D = $Camera
@onready var player: Player = $Player

const SPEED = 75

func _process(delta):
	# Reload scene when pressing R
	if Input.is_action_just_pressed("reload"):
		get_tree().reload_current_scene()
		Global.state = Global.States.IDLE

	if Input.is_action_just_pressed("fly") and Global.state == Global.States.IDLE:
		Global.state = Global.States.FLY

	if Global.state == Global.States.FLY:
		player.position.x += SPEED * delta
		camera.position.x +=  SPEED * delta

