class_name Reversal extends Area2D

func _on_body_entered(body: Node2D) -> void:
	body.up_or_down = !body.up_or_down

func _process(delta: float) -> void:
	global_position.x -= delta * 300


func _on_body_exited(body: Node2D) -> void:
	get_tree().create_timer(2).timeout.connect(func():queue_free())
