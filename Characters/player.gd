extends CharacterBody2D

@export var player_index = 1
@export var speed : float = 5
var input_velocity = Vector2.ZERO

@onready var _animated_sprite = $AnimatedSprite2D

var pressed_before = "down"

func _ready():
	for device_id in Input.get_connected_joypads():
		print("Connected device: ", Input.get_joy_name(device_id), " with ID: ", device_id)
		
func _input(event):
	if event is InputEventJoypadButton:
		print("Button pressed: ", event.button_index, " on device: ", event.device)
		

		

func _physics_process(_delta):
	input_velocity = Vector2.ZERO
	
	
	if Input.is_joy_button_pressed(player_index, 15) or Input.is_action_pressed("right", player_index):
		input_velocity.x=1
		_animated_sprite.play("MoveRight")
#		pressed_before = "right"
	elif Input.is_joy_button_pressed(player_index, 14) or Input.is_action_pressed("left", player_index):
		input_velocity.x= -1
		_animated_sprite.play("MoveLeft")
#		pressed_before = "left"
	elif Input.is_joy_button_pressed(player_index, 12) or Input.is_action_pressed("up", player_index):
		input_velocity.y= -1
		_animated_sprite.play("MoveUp")
#		pressed_before = "up"
	elif Input.is_joy_button_pressed(player_index, 13) or Input.is_action_pressed("down", player_index):
		input_velocity.y= 1
		_animated_sprite.play("MoveDown")
#		pressed_before = "down"
	elif input_velocity == Vector2.ZERO:
		_animated_sprite.play("IdleRight")
	"""elif pressed_before=="up":
		_animated_sprite.play("IdleUp")
	elif pressed_before=="left":
		_animated_sprite.play("IdleLeft")	
		print("aaa")
	elif pressed_before=="right":
		_animated_sprite.play("IdleRight")	
	else:
		_animated_sprite.play("IdleDown")"""
		
	velocity += input_velocity*speed 
	move_and_slide()
