extends Label

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var timer: Timer = $Timer
@onready var reversal_label: Label = $Label

func _on_timer_timeout() -> void:
	reversal_label.hide()
	animation_player.play("label_exit")


func _on_asteroid_generator_some_tool_tip(count: int, tip: String, _text: String = "") -> void:
	if _text != "":
		text = "%s分以后将会出现%s" % [(count * Game.difficulty_multiple), tip]
		reversal_label.text = _text
		reversal_label.show()
	else :
		text = "每获得%s分将出现%s" % [(count * Game.difficulty_multiple), tip]
	animation_player.play("label_enter")
	timer.start(4)


func _on_start_time_start_game() -> void:
	animation_player.play("label_enter")
	reversal_label.show()
