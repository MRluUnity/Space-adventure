extends HBoxContainer

@onready var progress_bar: ProgressBar = $ProgressBar
@onready var label: Label = $Label

func _on_player_player_health_update(health: int, max_health : int) -> void:
	progress_bar.max_value = max_health
	var tween : Tween = create_tween()
	tween.tween_property(progress_bar, "value", health, .4)
	#progress_bar.value = health
	label.text = "当前血量：%s/%s" % [health, max_health]
