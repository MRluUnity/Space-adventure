extends Asteroid

@onready var noise_border: Sprite2D = $NoiseBorder
const ASTEROID_1 = preload("res://scenes/asteroids/asteroid_1.tscn")

func asteroid_skill() -> void:
	var index = randi() % 100
	if is_skill:
		for i in 2:
			var asteroid : Asteroid = ASTEROID_1.instantiate()
			asteroid.global_position.y = global_position.y + randf_range(-35, 35)
			asteroid.global_position.x = position.x
			get_parent().add_child(asteroid)
		queue_free()
	if index < 10 and not is_skill:
		is_skill = true
		noise_border.show()


func _on_timer_timeout() -> void:
	asteroid_skill()
