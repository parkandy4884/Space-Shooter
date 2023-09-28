extends Area2D


func _on_body_entered(body):
	if body.name == "Player":
		body.weapon += 1
		queue_free()



func _on_timer_timeout():
	queue_free()
