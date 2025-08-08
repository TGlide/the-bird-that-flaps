extends Area2D
class_name SpeedUp

var triggered: bool = false

func _on_body_entered(body:Node2D) -> void:
	if triggered: return
	if body is Player:
		GlobalState._on_speedup()
		triggered = true
		hide()
