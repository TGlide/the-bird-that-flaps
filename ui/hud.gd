extends CanvasLayer
class_name HUD

@onready var score: Label = $Score
@onready var flash_player: AnimationPlayer = $FlashPlayer

var initial_title_pos: Vector2

func flash():
	flash_player.play("flash")

func update_score(n: int) -> void:
	self.score.text = str(n)

func reset() -> void:
	score.hide()
	score.text = "0"
