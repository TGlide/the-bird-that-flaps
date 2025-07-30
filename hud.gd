extends CanvasLayer
class_name HUD

@onready var score: Label = $Score
@onready var flash_player: AnimationPlayer = $FlashPlayer

func _process(_delta):
	score.text = str(Global.points)

func flash():
	flash_player.play("flash")
