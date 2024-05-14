extends Node
class_name PlayerMovement






func _ready():
	pass


func reset_attack_cd():
	await get_tree().create_timer(0.10).timeout
	await get_tree().create_timer(0.25).timeout
	can_attack = true


