extends ParallaxBackground
class_name BG

@onready var shader = $SlowdownShader

func _ready() -> void:
	GlobalState.slowdown.connect(_on_slowdown)
	GlobalState.reset_speed.connect(_on_reset_speed)

func _on_slowdown() -> void:
	shader.show()

func _on_reset_speed() -> void:
	shader.hide()
