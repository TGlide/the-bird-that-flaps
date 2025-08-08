extends ParallaxBackground
class_name BG

@onready var slow_shader = $SlowdownShader
@onready var speed_shader = $SpeedupShader

func _ready() -> void:
	GlobalState.slowdown.connect(_on_slowdown)
	GlobalState.speedup.connect(_on_speedup)
	GlobalState.reset_speed.connect(_on_reset_speed)

func _on_slowdown() -> void:
	slow_shader.show()

func _on_speedup() -> void:
	speed_shader.show()

func _on_reset_speed() -> void:
	slow_shader.hide()
	speed_shader.hide()
