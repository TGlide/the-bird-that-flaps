extends Node2D
class_name Pipes

@onready var pipe_up: Area2D = $PipeUp
@onready var pipe_down: Area2D = $PipeDown

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
	pipe_up.position.y -= gap / 2
	pipe_down.position.y += gap / 2



	pass


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
	pass # Replace with function body.

