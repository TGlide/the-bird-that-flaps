extends Node2D
class_name Pipes

signal hit
signal score

const powerup_scene: PackedScene = preload("res://objects/power_up.tscn")

@onready var pipe_up: Area2D = $PipeUp
@onready var pipe_up_col_shape: CollisionShape2D = $PipeUp/CollisionShape2D
@onready var pipe_down: Area2D = $PipeDown
@onready var pipe_down_col_shape: CollisionShape2D = $PipeDown/CollisionShape2D

const MIN_GAP: int = 60
const MAX_GAP: int = 100
const SPACING: int = 100

enum Variants { MOVING }
var variant_probabilities = {
	Variants.MOVING: 0.2
}
var variants: Array[Variants] = []

const powerup_probability: float = 0.3

# MOVING variant
const MIN_OFFSET_RANGE: int = 60
const MAX_OFFSET_RANGE: int = 100 
const MIN_SPEED: float = 20.0
const MAX_SPEED: float = 40.0

var direction: int = 1 # 1 = up, -1 = down
var offset: float = 0.0
var offset_range: int = 0
var initial_y: float = 0.0
var speed: float = 0.0

func _ready() -> void:
	# random y position
	const lb = SPACING
	var ub = get_viewport_rect().size.y - SPACING 
	position.y = randf_range(lb, ub)

	# setup variant data
	initial_y = position.y
	offset_range = randi_range(MIN_OFFSET_RANGE, MAX_OFFSET_RANGE)
	speed = randf_range(MIN_SPEED, MAX_SPEED)

	# random gap
	var gap = randi_range(MIN_GAP, MAX_GAP)
	pipe_up.position.y -= gap / 2.0
	pipe_down.position.y += gap / 2.0

	# for each variant, roll a dice
	for variant in variant_probabilities.keys():
		var probability = variant_probabilities[variant]
		if randf() < probability:
			variants.append(variant)

	# maybe add a powerup
	if randf() < powerup_probability:
		var powerup = powerup_scene.instantiate()

		var p_lb = pipe_up.position.y + 8
		var p_ub = pipe_down.position.y - 8

		powerup.position = Vector2(0, 0)
		powerup.position.y = randf_range(p_lb, p_ub)
		print(powerup.position)
		add_child(powerup)


func _process(delta: float) -> void:
	if variants.size() == 0: return
	for variant in variants:
		match variant:
			Variants.MOVING:
				process_variant_moving(delta)


func process_variant_moving(delta: float) -> void:
	# move pipe
	offset += speed * direction * delta
	position.y = initial_y + offset
	if absf(offset) > offset_range / 2.0:
		direction *= -1


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_score_area_body_entered(body: Node2D) -> void:
	if body is Player:
		score.emit()


func _on_pipe_body_entered(body: Node2D) -> void:
	if body is Player:
		hit.emit()
