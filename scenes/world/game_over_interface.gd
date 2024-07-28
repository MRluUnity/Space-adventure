extends PanelContainer
@onready var count: Label = $VBoxContainer/Count
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var back_button: Button = $VBoxContainer/BackButton
@onready var reset_button: Button = $VBoxContainer/ResetButton
@onready var line_edit: LineEdit = $VBoxContainer/LineEdit
@onready var label: Label = $VBoxContainer/Label

func _process(delta: float) -> void:
	match Game.difficulty_multiple:
		Game.DifficultyMultiple.EASY:
			label.text = "游戏结束！！！"
		Game.DifficultyMultiple.NORMAL:
			label.text = "菜就多练！！！"
		Game.DifficultyMultiple.HARD:
			label.text = "你只会说大话。"

func _on_player_player_is_dead() -> void:
	animation_player.play("game_over_enter")
	count.text = "得分：%s" % Game.count
	get_tree().paused = true


func _on_back_button_pressed() -> void:
	animation_player.play("game_over_exit")
	LoadAndSave.save_game()
	Game.count = 0
	SceneManager.scene_switch(SceneManager.SCENE_INDEX.MAIN, Game.SHADER_INDEX.RIGHT_TO_LEFT)


func _on_line_edit_text_changed(new_text: String) -> void:
	Game._name = new_text
	if new_text == "":
		back_button.disabled = true
		reset_button.disabled = true
	else :
		back_button.disabled = false
		reset_button.disabled = false


func _on_visibility_changed() -> void:
	if visible:
		if Game._name != "":
			line_edit.text = Game._name
			back_button.disabled = false
			reset_button.disabled = false
	else :
		line_edit.text = ""


func _on_reset_button_pressed() -> void:
	animation_player.play("game_over_exit")
	LoadAndSave.save_game()
	Game.count = 0
	get_tree().reload_current_scene()
