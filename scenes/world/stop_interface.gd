extends PanelContainer

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var setting_interface: PanelContainer = $"../SettingInterface"


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("esc"):
		if visible:
				animation_player.play("stop_exit")
				get_tree().paused = false
				return

		animation_player.play("stop_enter")
		get_tree().paused = true


func _on_continue_button_pressed() -> void:
	animation_player.play("stop_exit")
	get_tree().paused = false


func _on_setting_button_pressed() -> void:
	setting_interface.show()


func _on_back_button_pressed() -> void:
	get_tree().paused = false
	Game.count = 0
	SceneManager.scene_switch(SceneManager.SCENE_INDEX.MAIN, Game.SHADER_INDEX.RIGHT_TO_LEFT)


func _on_stop_button_pressed():
	animation_player.play("stop_enter")
	get_tree().paused = true


func _on_reset_button_pressed() -> void:
	get_tree().reload_current_scene()
