extends CanvasLayer

@onready var score: Label = $Score

func _process(_delta):
	score.text = str(Global.points)
