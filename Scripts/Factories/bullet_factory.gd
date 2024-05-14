extends Node
#This script will:
#Store bullet types in ConfigFiles
#Instantiate a bullet
#Add the bullet to the scene

var bullet_scene = preload("res://Prefabs/Bullets/Bullet.tscn")


func _ready():
	print("Bullet Factory Ready")
	pass

func _process(delta):
	pass

func _spawn_bullet(bullet_position:Vector2, bullet_rotation:Vector2, bullet_direction:Vector2):
	var bullet:Bullet = bullet_scene.instantiate()
	bullet.look_at(bullet_rotation)
	bullet.direction = bullet_position.direction_to(bullet_direction)
	bullet.position = bullet_position
	add_child(bullet)
