extends CanvasLayer
class_name TitleScreen

signal start_button_pressed

@onready var start_button: TextureButton = $Buttons/StartButton
@onready var title = $Title
@onready var title_fade_player: AnimationPlayer = $TitleFadePlayer
@onready var fade_player: AnimationPlayer = $FadePlayer

var initial_title_pos: Vector2

func _ready():
	initial_title_pos = title.position

func _on_start_button_pressed() -> void:
	fade_player.play("fade-and-back")

	await get_tree().create_timer(0.3).timeout

	start_button.disabled = true
	start_button.visible = false

	title.visible = false
	start_button_pressed.emit()
