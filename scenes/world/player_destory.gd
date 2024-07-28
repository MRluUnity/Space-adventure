extends Area2D

signal is_not_rotate

@onready var destructor_1: CollisionShape2D = $Destructor1
@onready var destructor_2: CollisionShape2D = $Destructor2


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.health_module.health = 0
	if body is Asteroid:
		body.destory()


func _on_annihilator_line_minification(minification : int) -> void:
	# FIXME 到时候修改为渐变的
	#var tween : Tween = create_tween()
	#tween.tween_property(collision_shape_2d, "global_position", collision_shape_2d.global_position + Vector2(0, 50), .5)
	#tween.tween_property(collision_shape_2d_2, "global_position", collision_shape_2d.global_position + Vector2(0, -50), .5)
	destructor_1.global_position.y -= minification
	destructor_2.global_position.y += minification


func _on_asteroid_generator_boundary_rotate() -> void:
	var tween : Tween = create_tween()
	tween.tween_property(self, "rotation_degrees", 180, 6.)
	tween.tween_property(self, "rotation_degrees", 0, 6.)
	is_not_rotate.emit()
