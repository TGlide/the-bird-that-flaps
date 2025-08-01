extends CanvasLayer
class_name HUD

signal start_button_pressed

@onready var score: Label = $Score
@onready var flash_player: AnimationPlayer = $FlashPlayer
@onready var start_button: TextureButton = $Buttons/StartButton
@onready var title = $Title
@onready var title_fade_player: AnimationPlayer = $TitleFadePlayer

var initial_title_pos: Vector2

func _ready():
	initial_title_pos = title.position

func _process(_delta):
	score.text = str(Global.points)

func flash():
	flash_player.play("flash")


func _on_start_button_pressed() -> void:
	start_button_pressed.emit()
	start_button.disabled = true
	start_button.visible = false
	title_fade_player.play("fade-out")
