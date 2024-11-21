extends CharacterBody2D
@export var player_index: int = 1  # Default to player 1
var connected_devices = []
@export var speed : float = 5
var input_velocity = Vector2.ZERO

@onready var player1 = $Player1
@onready var player2 = $Player2

@onready var _animated_sprite = $AnimatedSprite2D

var pressed_before = "down"
func _ready():
	# Get the list of connected gamepads
	connected_devices = Input.get_connected_joypads()
	
	# Print the connected devices and their indices
	for device_id in connected_devices:
		print("Connected device: ", Input.get_joy_name(device_id), " with ID: ", device_id)

	# Assign players based on the connected devices
	if connected_devices.size() >= 2:
		if player1 and player2:
			# Assuming the first two devices are for player 1 and player 2
			print("Assigning Player 1 to controller: ", connected_devices[1])
			print("Assigning Player 2 to controller: ", connected_devices[2])
			$Player1.player_index = connected_devices[1]  # Player 1 gets the first controller
			$Player2.player_index = connected_devices[2]  # Player 2 gets the second controller
	else:
		print("Not enough controllers connected.")

func _input(event):
	if event is InputEventJoypadButton:
		print("Button pressed: ", event.button_index, " on device: ", event.device)
		

		

func _physics_process(_delta):
	input_velocity = Vector2.ZERO

	var joystick_x = Input.get_joy_axis(player_index, 0)  # Left joystick X (Horizontal)
	var joystick_y = Input.get_joy_axis(player_index, 1)  # Left joystick Y (Vertical)

	# Check joystick axis for movement
	if joystick_x > 0.2:  # Deadzone threshold for joystick
		input_velocity.x = 1
		_animated_sprite.play("MoveRight")
	elif joystick_x < -0.2:
		input_velocity.x = -1
		_animated_sprite.play("MoveLeft")

	if joystick_y > 0.2:
		input_velocity.y = 1
		_animated_sprite.play("MoveDown")
	elif joystick_y < -0.2:
		input_velocity.y = -1
		_animated_sprite.play("MoveUp")

	# If no movement, set to idle
	if input_velocity == Vector2.ZERO:
		_animated_sprite.play("IdleRight")
	
	velocity += input_velocity * speed 
	move_and_slide()
	"""if Input.is_joy_button_pressed(player_index, 15) or Input.is_action_pressed("right", player_index):
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
	elif pressed_before=="up":
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
