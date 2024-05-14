extends CharacterBody2D
class_name Player

@onready var my_collider:CollisionShape2D = $Collider

#Signals
signal player_dash()

#FOR TESTING
var god_mode = true

#Constants
const SPEED = 300.0

#Properties
var starting_spot:Vector2
var dash_direction:Vector2
var can_dash:bool
var can_attack:bool
var dashing:bool

func _ready():
	can_dash = true
	pass

func _process(delta):
	pass

func _physics_process(delta):

	#THIS MAY GET REFACTIRED LATER FOR STATE MACHINE OR SOMETHING
	#DON"T FOCUS TOO MUCH ON IT NOW

	# Logic for moving player
	if !dashing:
		var direction_x = Input.get_axis("move_left", "move_right")
		var direction_y = Input.get_axis("move_up", "move_down")
		if direction_x:
			velocity.x = direction_x * SPEED

		if direction_y:
			velocity.y = direction_y * SPEED

		if !direction_y and !direction_x:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.y = move_toward(velocity.y, 0, SPEED)

		if Input.is_action_just_pressed("dash") and (direction_x or direction_y) and can_dash:
			dashing = true
			starting_spot = global_position
			dash_direction = Vector2(direction_x, direction_y)
			can_dash = false
			pass

	if dashing:
		my_collider.disabled = true
		velocity = PlayerStats.dash_speed * dash_direction
		var distance_travelled_x = global_position.x - starting_spot.x
		var distance_travelled_y = global_position.y - starting_spot.y
		if (abs(distance_travelled_x) + abs(distance_travelled_y)) >= PlayerStats.dash_distance:
			dashing = false
			my_collider.disabled = false
			reset_dash_cd()
		player_dash.emit()
	#Do move and slide after setting all velocities
	move_and_slide()

func reset_dash_cd():
	await get_tree().create_timer(PlayerStats.dash_cd).timeout
	print("resetting cd")
	can_dash = true
