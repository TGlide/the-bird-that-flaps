extends Node

@onready var timer: Timer = $SlowdownTimer
@onready var audio_slowdown: AudioStreamPlayer = $SlowdownAudio

var slowed_down: bool = false

func slowdown() -> void:
	audio_slowdown.play()
	slowed_down = true
	Engine.time_scale = 0.5
	timer.start()

func _on_slowdown_timer_timeout() -> void:
	GlobalState.slowed_down = false
	Engine.time_scale = 1
