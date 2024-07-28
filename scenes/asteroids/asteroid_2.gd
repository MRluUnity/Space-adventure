extends Asteroid

@onready var noise_border: Sprite2D = $NoiseBorder

func asteroid_skill() -> void:
	var index = randi() % 100
	if index < 15 and not is_skill:
		is_skill = true
		noise_border.show()
		speed *= 2
		is_rotating = true


func _on_timer_timeout() -> void:
	asteroid_skill()
