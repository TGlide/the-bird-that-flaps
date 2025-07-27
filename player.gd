extends CharacterBody2D

const GRAVITY = Vector2(0, 1200)
const JUMP_IMPULSE = Vector2(0, -450)

@onready var animation_sprite: AnimatedSprite2D = $Sprite
@onready var audio_fly: AudioStreamPlayer2D = $AudioFly
@onready var audio_hit: AudioStreamPlayer2D = $AudioHit

var hit = false

func _physics_process(delta):
	if Input.is_action_just_pressed("fly"):
		hit = false
		animation_sprite.play("fly")
		velocity.y = JUMP_IMPULSE.y 
		audio_fly.play()

	velocity.y += GRAVITY.y * delta

	# Going up
	if velocity.y < 0:
		rotation -= deg_to_rad(5000 * delta)
	else:
		rotation += deg_to_rad(400 * delta)
	rotation = clamp(rotation, -0.75, 1.5)


	move_and_slide()

	# check collisions
	print(get_slide_collision_count())
	if get_slide_collision_count() > 0 and !hit:
		hit = true
		audio_hit.play()
