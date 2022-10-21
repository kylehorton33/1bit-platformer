extends KinematicBody2D

const GRAVITY = 500
const JUMP_SPEED = 400
const MAX_H_SPEED = 125
const H_ACCELERATION = 2000
const JUMP_MULTIPLIER = 3
const AIR_RESISTANCE = 0.5

var velocity = Vector2.ZERO
var movement = Vector2.ZERO

onready var coyote_timer = $CoyoteTimer
onready var animated_sprite = $AnimatedSprite

func _process(delta):

	var was_on_floor = is_on_floor()

	# HORIZONTAL MOVEMENT
	movement.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.x += movement.x * H_ACCELERATION * delta
	if (movement.x == 0):
		velocity.x = lerp(0, velocity.x, pow(2, -50 * delta))
	velocity.x = clamp(velocity.x, -MAX_H_SPEED, MAX_H_SPEED)

	# VERTICAL MOVEMENT
	movement.y = -1 if Input.is_action_just_pressed("jump") else 0
	if (movement.y < 0 && (is_on_floor() || !coyote_timer.is_stopped() )):
		velocity.y = movement.y * JUMP_SPEED
	if (velocity.y < 0 && !Input.is_action_just_pressed("jump")):
		velocity.y += GRAVITY * JUMP_MULTIPLIER * delta
	else:
		velocity.y += GRAVITY * delta * AIR_RESISTANCE

	# MOVE PLAYER
	velocity = move_and_slide(velocity, Vector2.UP)
	update_animation()

	# START COYOTE TIMER IF JUST LEFT FLOOR
	if (was_on_floor && !is_on_floor()):
		coyote_timer.start()

func update_animation():
	if (!is_on_floor()):
		if (velocity.y < 0):
			animated_sprite.play("jump")
		else:
			animated_sprite.play("fall")
	else:
		animated_sprite.play("idle")

	if (movement.x != 0):
		flip_sprite()


func flip_sprite():
	animated_sprite.flip_h = true if movement.x < 0  else false
