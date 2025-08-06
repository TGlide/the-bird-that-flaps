extends CanvasLayer
class_name GameOver

@onready var go_text: TextureRect = $GOText
@onready var animation: AnimationPlayer = $Animation
@onready var retry_animation: AnimationPlayer = $RetryAnimation
@onready var score_label: Label = $Box/ScoreContainer/ScoreLabel
@onready var best_label: Label = $Box/BestContainer/BestLabel

const SCORE_ANIMATION_DURATION = 0.5

var score: int
var best: int

var save_path = "user://score.save"

func _ready():
	load_score()

func save_score():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(best)

func load_score():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		best = file.get_var()
	else:
		best = 0

func show_gameover(final_score: int) -> void:
	animation.play("show")
	show()
	score = final_score
	best_label.text = str(best)

func _on_animation_animation_finished(_anim_name: String) -> void:
	retry_animation.play("show")
	var s = 0
	var timeout = SCORE_ANIMATION_DURATION / (score)
	while s < score:
		await get_tree().create_timer(timeout).timeout
		s += 1
		score_label.text = str(s)

	if score > best:
		best = score
		save_score()
