extends CharacterBody2D
class_name Player

signal hit

const GRAVITY = Vector2(0, 750)
const JUMP_IMPULSE = Vector2(0, -235)

@onready var animation_sprite: AnimatedSprite2D = $Sprite
@onready var audio_fly: AudioStreamPlayer2D = $AudioFly

var is_dead = false
var started = false

func start() -> void:
	started = true

func _physics_process(delta):
	if not started: return
	if Input.is_action_just_pressed("fly") and not is_dead:
		velocity.y = JUMP_IMPULSE.y 
		audio_fly.play()


	velocity.y += GRAVITY.y * delta

	# Going up
	var threshold = 0 if is_dead else 100
	if velocity.y < threshold:
		rotation -= deg_to_rad(5000 * delta)
	else:
		rotation += deg_to_rad(450 * delta)
	rotation = clamp(rotation, deg_to_rad(-25), deg_to_rad(90))

	move_and_slide()

	# check collisions
	if get_slide_collision_count() > 0 and !is_dead:
		print("hit collision")
		hit.emit()
		is_dead = true
		animation_sprite.pause()
