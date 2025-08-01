extends CanvasLayer
class_name HUD

signal start_button_pressed

@onready var score: Label = $Score
@onready var flash_player: AnimationPlayer = $FlashPlayer
@onready var start_button: TextureButton = $Buttons/StartButton
@onready var title = $Title
@onready var title_fade_player: AnimationPlayer = $TitleFadePlayer
@onready var fade_player: AnimationPlayer = $FadePlayer

var initial_title_pos: Vector2

func _ready():
	initial_title_pos = title.position

func flash():
	flash_player.play("flash")

func _on_start_button_pressed() -> void:
	fade_player.play("fade-and-back")

	await get_tree().create_timer(0.3).timeout

	start_button.disabled = true
	start_button.visible = false
	title.visible = false
	score.visible = true
	start_button_pressed.emit()

func update_score(n: int) -> void:
	self.score.text = str(n)
