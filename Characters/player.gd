extends CharacterBody2D

@export var speed : float = 100

@onready var _animated_sprite = $AnimatedSprite2D

var pressed_before = "down"

func _physics_process(_delta):
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	velocity = input_direction * speed
	if Input.is_action_pressed("right"):
		_animated_sprite.play("MoveRight")
		pressed_before = "right"
	elif Input.is_action_pressed("left"):
		_animated_sprite.play("MoveLeft")
		pressed_before = "left"
	elif Input.is_action_pressed("up"):
		_animated_sprite.play("MoveUp")
		pressed_before = "up"
	elif Input.is_action_pressed("down"):
		_animated_sprite.play("MoveDown")
		pressed_before = "down"
	elif pressed_before=="up":
		_animated_sprite.play("IdleUp")
	elif pressed_before=="left":
		_animated_sprite.play("IdleLeft")	
		print("aaa")
	elif pressed_before=="right":
		_animated_sprite.play("IdleRight")	
	else:
		_animated_sprite.play("IdleDown")
	
	print(pressed_before)
	move_and_slide()
