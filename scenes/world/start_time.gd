extends Label

signal start_game
@onready var timer: Timer = $Timer

func _process(delta: float) -> void:
	text = "%s" % (int(timer.time_left) + 1)

func _on_timer_timeout() -> void:
	get_tree().paused = false
	start_game.emit()
	queue_free()
