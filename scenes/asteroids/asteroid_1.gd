extends Asteroid

@onready var noise_border: Sprite2D = $NoiseBorder
@onready var area_2d: Area2D = $Area2D

func asteroid_skill() -> void:
	var index = randi() % 100
	if index < 20 and not is_skill:
		is_skill = true
		noise_border.show()
		is_coll = true
		area_2d.monitoring = true


func _on_timer_timeout() -> void:
	asteroid_skill()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Asteroid:
		if is_coll and body != self:
			body.destory()
