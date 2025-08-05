extends CanvasLayer
class_name GameOver

@onready var go_text: TextureRect = $GOText
@onready var animation: AnimationPlayer = $Animation
@onready var score_label: Label = $Box/ScoreContainer/ScoreLabel

const SCORE_ANIMATION_DURATION = 0.5

var score: int

func show_gameover(final_score: int) -> void:
	await get_tree().create_timer(0.5).timeout
	animation.play("show")
	show()
	score = final_score

func _on_animation_animation_finished(anim_name: StringName) -> void:
	print("animation finished", anim_name)

	var s = 0
	var timeout = SCORE_ANIMATION_DURATION / (score + 500.0)
	print("timeout ", timeout)
	while s < score + 500:
		await get_tree().create_timer(timeout).timeout
		s += 1
		score_label.text = str(s)
