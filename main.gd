extends Node

@onready var camera: Camera2D = $Camera
@onready var player: Player = $Player

const SPEED = 75

func _process(delta):
	player.position.x += SPEED * delta
	camera.position.x +=  SPEED * delta

