extends CharacterBody2D
class_name Player

signal hit

const GRAVITY = Vector2(0, 1000)
const JUMP_IMPULSE = Vector2(0, -350)

@onready var animation_sprite: AnimatedSprite2D = $Sprite
@onready var audio_fly: AudioStreamPlayer2D = $AudioFly
@onready var audio_hit: AudioStreamPlayer2D = $AudioHit

func _physics_process(delta):
	if Global.state != Global.States.DEAD:
		animation_sprite.play("fly")
	else:
		animation_sprite.pause()

	if Input.is_action_just_pressed("fly") and Global.state != Global.States.DEAD:
		velocity.y = JUMP_IMPULSE.y 
		audio_fly.play()

	if Global.state == Global.States.IDLE:
		return

	velocity.y += GRAVITY.y * delta

	# Going up
	if velocity.y < 0:
		rotation -= deg_to_rad(5000 * delta)
	else:
		rotation += deg_to_rad(400 * delta)
	rotation = clamp(rotation, deg_to_rad(-45), deg_to_rad(90))

	move_and_slide()

	# check collisions
	if get_slide_collision_count() > 0 and Global.state == Global.States.FLY:
		emit_signal("hit")
		audio_hit.play()
		if velocity.y < 0:
			velocity.y = 0
