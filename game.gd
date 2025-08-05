extends Node
class_name Game

@export var pipe_scene: PackedScene

@onready var camera: Camera2D = $Camera
@onready var player: Player = $Player
@onready var hud: HUD = $HUD
@onready var audio_hit: AudioStreamPlayer = $AudioHit
@onready var audio_die: AudioStreamPlayer = $AudioDie
@onready var audio_score: AudioStreamPlayer = $AudioScore
@onready var gameover: GameOver = $GameOver

const SPEED = 75
const PIPE_COUNT = 10
const PIPE_SPACING = 100

enum States { TITLE, IDLE, FLY, DEAD }
var state = States.TITLE
var points = 0

func start() -> void:
	state = States.IDLE
	player.show()
	hud.score.show()

func _process(delta):
	# Reload scene when pressing R
	if Input.is_action_just_pressed("reload"):
		get_tree().reload_current_scene()
		state = States.TITLE
		update_score(0)
		return

	if state == States.IDLE and Input.is_action_just_pressed("fly"):
		state = States.FLY
		player.start()
		return

	if state == States.FLY:
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
			pipe.position.x = get_viewport().get_visible_rect().size.x + 20
			
		pipe.hit.connect(_on_hit)
		pipe.score.connect(_on_score)
		add_child(pipe)


func _on_hit() -> void:
	if state == States.DEAD: return
	state = States.DEAD
	audio_hit.play()
	audio_die.play()
	hud.flash()
	hud.score.hide()
	player.on_hit()
	gameover.show_gameover(points)

func _on_score() -> void:
	points += 1
	audio_score.play()
	update_score(points)

func update_score(n: int) -> void:
	points = n
	hud.update_score(points)

func _on_title_screen_start_button_pressed() -> void:
	player.show()
	hud.score.show()
	state = States.IDLE
