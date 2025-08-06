extends CharacterBody2D
class_name Player

signal hit

const GRAVITY = Vector2(0, 750)
const JUMP_IMPULSE = Vector2(0, -235)

@onready var animation_sprite: AnimatedSprite2D = $Sprite
@onready var audio_fly: AudioStreamPlayer2D = $AudioFly
@onready var initial_position: Vector2 = position

var is_dead = false
var started = false

func start() -> void:
	started = true
	fly()

func fly() -> void:
	velocity.y = JUMP_IMPULSE.y 
	audio_fly.play()

func reset() -> void:
	is_dead = false
	started = false
	position = initial_position
	rotation = 0
	animation_sprite.play("fly")
	hide()

func on_hit() -> void:
	is_dead = true
	animation_sprite.pause()
	if velocity.y < 0:
		velocity.y = 0

func _physics_process(delta):
	if not started: return
	if Input.is_action_just_pressed("fly") and !is_dead:
		fly()

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
		hit.emit()
		on_hit()
