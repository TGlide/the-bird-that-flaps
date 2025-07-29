extends Node

@export var pipe_scene: PackedScene

@onready var camera: Camera2D = $Camera
@onready var player: Player = $Player

const SPEED = 75
const PIPE_COUNT = 10
const PIPE_SPACING = 100

func _process(delta):
	# Reload scene when pressing R
	if Input.is_action_just_pressed("reload"):
		get_tree().reload_current_scene()
		Global.state = Global.States.IDLE
		return

	if Input.is_action_just_pressed("fly") and Global.state == Global.States.IDLE:
		Global.state = Global.States.FLY

	if Global.state == Global.States.FLY:
		player.position.x += SPEED * delta
		camera.position.x +=  SPEED * delta


	# Pipe logic
	# Get all pipes from group 'pipes'
	var pipes: Array[Node] = get_tree().get_nodes_in_group("pipes") 
	if pipes.size() < PIPE_COUNT:
		var pipe = pipe_scene.instantiate()
		var last_pipe = pipes.get(pipes.size() - 1)
		if last_pipe:
			pipe.position.x = last_pipe.position.x + PIPE_SPACING
		else:
			pipe.position.x = 400
			
		add_child(pipe)
