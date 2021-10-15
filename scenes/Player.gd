extends KinematicBody2D

export var limit_bottom = 10000000

var speed = Vector2()
var frozen = false

const MAX_WALK_SPEED = 200
const WALK_ACCELERATION = 5

export var jump_height = 250
const GRAVITY = 5

func _ready():
	$Camera2D.limit_bottom = limit_bottom

func _physics_process(delta):
	if is_on_ceiling():
		speed.y = 0
	if !is_on_floor():
		speed.y += GRAVITY
	else:
		speed.y = 0
	if Input.is_action_pressed("ui_up") and is_on_floor() and !frozen:
		speed.y -= jump_height
	
	if is_on_wall():
		speed.x = 0
	if Input.is_action_pressed("ui_right") and !frozen:
		if speed.x < MAX_WALK_SPEED:
			speed.x += WALK_ACCELERATION
		$Sprite.flip_h = false
	elif Input.is_action_pressed("ui_left") and !frozen:
		if speed.x > -MAX_WALK_SPEED:
			speed.x -= WALK_ACCELERATION
		$Sprite.flip_h = true
	else:
		if speed.x > 0:
			speed.x -= WALK_ACCELERATION
		elif speed.x < 0:
			speed.x += WALK_ACCELERATION
	
	move_and_slide(speed, Vector2(0, -1.570796))
	
	if position.y > limit_bottom:
		die()

func die():
	if !frozen:
		frozen = true
		$FailedSound.play()

func _on_FailedSound_finished():
	yield(get_tree().create_timer(1), "timeout")
	LevelSwitcher.restart_level()
