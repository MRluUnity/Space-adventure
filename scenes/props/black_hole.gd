class_name BlackHole extends Prop


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Asteroid:
		body.destory()
