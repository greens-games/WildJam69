extends Area2D
class_name Hitbox

#Will detect getting hit by bullets etc..


func _on_area_entered(area):
	if area.get_parent() is Player:
		print("Hitting player")
	pass # Replace with function body.
