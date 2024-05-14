extends CharacterBody2D
class_name Bullet

var direction:Vector2

func _ready():
	pass

func _process(delta):
	velocity = direction * 300
	move_and_slide()
	pass
