extends Node2D
class_name BulletManager

#We might need the timer here instead of the factory
@onready var all_points:Node = $Points

@export var bullet_wave_cd:float 

#Probably need more timers for the following:
#Timer for when to start the bullet wave (maybe some other condition)
#Timer for variable delays or when to stop a wave (maybe some other condition)
var curr_timer:Timer
var point_positions:Array

func _ready():
	assert(bullet_wave_cd > 0, "Bullet Wave CD must be greater than 0")
	curr_timer = Timer.new()
	curr_timer.wait_time = bullet_wave_cd
	curr_timer.timeout.connect(_on_Timer_timeout)
	add_child(curr_timer)
	#	curr_timer.start()
	_on_Timer_timeout_test()
	for point in all_points.get_children():
		point_positions.append(point.position)

func _process(delta):
	pass


func _on_Timer_timeout_test():	
	#We are going to switch to using some maths to determine the directions and positions
	#We can say the x and y positions are:
	# x = cos((2*pi/n) *k)
	# y = sin((2*pi/n) *k)
	#Gives position
	var radius:float = 16.0
	print(global_position)
	for k in range(8):
		var theta = (2 * PI / 8) * k
		var x = cos(theta) + position.x * radius
		var y = sin(theta) + position.y * radius
		var pos_vector = Vector2(x,y) + global_position 

		var distance_mod:Vector2 = Vector2(16.0, 16.0)
		var look_vector = pos_vector

		if pos_vector.x < global_position.x:
			distance_mod.x *= -1.0
		if pos_vector.y < global_position.y:
			distance_mod.y *= -1.0
		if pos_vector.x == global_position.x:
			distance_mod.x = 0.0
		if pos_vector.y == global_position.y:
			distance_mod.y = 0.0

		look_vector += distance_mod
		print("Pos: ", pos_vector, "Look: ", look_vector)
		BulletFactory._spawn_bullet(pos_vector, look_vector, look_vector)
	#to get rotation and direction vector take position vector * 2

#UNUSED
func _unused():
	for point in all_points.get_children():
		#how to get direction
		#take position of point
		#check if x and or y is 0
		#if x is 0 point.x = 0, if y is 0 point.y = 0
		#if x != 0 the bullet_dir.x = point.x/abs(point.x)
		#if y != 0 the bullet_dir.y = point.y/abs(point.y)
		var point_pos = point.position
		var point_g_pos = point.global_position
		var dir_x = 0.0
		var dir_y = 0.0
		if point_pos.x != 0:
			dir_x = point_pos.x/abs(point_pos.x)
		if point_pos.y != 0:
			dir_y = point_pos.y/abs(point_pos.y)
		var bullet_dir = Vector2(dir_x,dir_y)
		print("Point: ", point, "Dir: ", bullet_dir)
		#BulletFactory._spawn_bullet(point_g_pos, 90.0, bullet_dir)
	pass
