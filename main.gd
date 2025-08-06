extends Node
class_name Main

@export var pipe_scene: PackedScene

@onready var camera: Camera2D = $Camera
@onready var player: Player = $Player
@onready var hud: HUD = $HUD
@onready var audio_hit: AudioStreamPlayer = $AudioHit
@onready var audio_die: AudioStreamPlayer = $AudioDie
@onready var audio_score: AudioStreamPlayer = $AudioScore
@onready var gameover: GameOver = $GameOver
@onready var title_screen: TitleScreen = $TitleScreen

var SPEED = 75
const PIPE_COUNT = 10
const PIPE_SPACING = 100

enum States { TITLE, IDLE, FLY, DEAD }
var state = States.TITLE
var points = 0

func _input(event: InputEvent) -> void:
	var mouse_click = event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT
	if mouse_click and state == States.IDLE:
		state = States.FLY
		player.start()

func _process(delta):
	if Input.is_action_just_pressed("reload"):
		get_tree().reload_current_scene()
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
		var last_pipe = pipes.get(pipes.size() - 1) if pipes.size() > 0 else null
		if last_pipe:
			pipe.position.x = last_pipe.position.x + PIPE_SPACING
		else:
			pipe.position.x = get_viewport().get_visible_rect().size.x + 20
			
		pipe.hit.connect(_on_hit)
		pipe.score.connect(_on_score)
		add_child(pipe)

func _on_retry() -> void:
	await title_screen.show_title()
	state = States.TITLE
	get_tree().call_group("pipes", "queue_free")
	player.reset()
	hud.reset()
	update_score(0)
	camera.position.x = 0

func _on_hit() -> void:
	if state != States.FLY: return
	state = States.DEAD
	audio_hit.play()
	audio_die.play()
	hud.flash()
	hud.score.hide()
	player.on_hit()
	gameover.show_gameover(points)
	GlobalState._on_slowdown_timer_timeout()

func _on_score() -> void:
	if state != States.FLY: return
	points += 1
	audio_score.play()
	update_score(points)

func _on_title_screen_start_button_pressed() -> void:
	player.show()
	hud.score.show()
	state = States.IDLE

func update_score(n: int) -> void:
	points = n
	hud.update_score(points)
