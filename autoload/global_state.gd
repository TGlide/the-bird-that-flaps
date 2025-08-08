extends Node

signal slowdown
signal speedup
signal reset_speed

@onready var timer: Timer = $PowerupTimer
@onready var initial_time: float = timer.wait_time
@onready var audio_slowdown: AudioStreamPlayer = $SlowdownAudio
@onready var audio_speedup: AudioStreamPlayer = $SpeedupAudio

const SLOWDOWN_SCALE: float = 0.5
const SPEEDUP_SCALE: float = 1.35

var num_pipes: int = 0

func _on_slowdown() -> void:
	reset_speed.emit()
	audio_speedup.stop()

	audio_slowdown.play()
	Engine.time_scale = SLOWDOWN_SCALE
	timer.wait_time =  initial_time * SLOWDOWN_SCALE
	timer.start()
	slowdown.emit()


func _on_speedup() -> void:
	reset_speed.emit()

	if !audio_speedup.playing:
		audio_speedup.play()
	Engine.time_scale = SPEEDUP_SCALE
	timer.wait_time = initial_time * SPEEDUP_SCALE
	timer.start()
	speedup.emit()


func _on_powerup_timer_timeout() -> void:
	audio_speedup.stop()
	Engine.time_scale = 1
	reset_speed.emit()
