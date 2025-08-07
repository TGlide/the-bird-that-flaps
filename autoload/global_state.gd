extends Node

signal slowdown
signal reset_speed

@onready var timer: Timer = $SlowdownTimer
@onready var audio_slowdown: AudioStreamPlayer = $SlowdownAudio

var slowed_down: bool = false

func _on_slowdown() -> void:
	audio_slowdown.play()
	slowed_down = true
	Engine.time_scale = 0.5
	timer.start()
	slowdown.emit()

func _on_slowdown_timer_timeout() -> void:
	GlobalState.slowed_down = false
	Engine.time_scale = 1
	reset_speed.emit()
