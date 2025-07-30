extends Node2D
class_name Pipes

signal hit
signal score

@onready var pipe_up: Area2D = $PipeUp
@onready var pipe_up_col_shape: CollisionShape2D = $PipeUp/CollisionShape2D
@onready var pipe_down: Area2D = $PipeDown
@onready var pipe_down_col_shape: CollisionShape2D = $PipeDown/CollisionShape2D

const MIN_GAP: int = 80
const MAX_GAP: int = 160
const SPACING: int = 100

func _ready() -> void:
	# random y position
	const lb = SPACING
	var ub = get_viewport_rect().size.y - SPACING 
	position.y = randf_range(lb, ub)

	# random gap
	var gap = randi_range(MIN_GAP, MAX_GAP)
	pipe_up.position.y -= gap / 2.0
	pipe_down.position.y += gap / 2.0
	pass

func _process(_delta: float) -> void:
	if Global.state == Global.States.FLY:
		# enable collision
		pipe_up_col_shape.set_deferred("disabled", false)
		pipe_down_col_shape.set_deferred("disabled", false)
	else:
		# disable collision
		pipe_up_col_shape.set_deferred("disabled", true)
		pipe_down_col_shape.set_deferred("disabled", true)


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_score_area_body_entered(body: Node2D) -> void:
	if body is Player:
		score.emit()


func _on_pipe_body_entered(body: Node2D) -> void:
	if body is Player:
		hit.emit()
