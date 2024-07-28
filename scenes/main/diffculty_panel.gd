extends PanelContainer

#region 信号链接
#region 简单难度按钮的pressed信号
func _on_easy_button_pressed():
	Game.difficulty_multiple = Game.DifficultyMultiple.EASY
	Game.health = 7 - Game.difficulty_multiple * 2
	SceneManager.scene_switch(SceneManager.SCENE_INDEX.WORLD, Game.SHADER_INDEX.LEFT_TO_RIGHT)
#endregion

#region 普通难度按钮的pressed信号
func _on_same_button_pressed():
	Game.difficulty_multiple = Game.DifficultyMultiple.NORMAL
	Game.health = 7 - Game.difficulty_multiple * 2
	SceneManager.scene_switch(SceneManager.SCENE_INDEX.WORLD, Game.SHADER_INDEX.LEFT_TO_RIGHT)
#endregion

#region 困难难度按钮的pressed信号
func _on_hard_button_pressed():
	Game.difficulty_multiple = Game.DifficultyMultiple.HARD
	Game.health = 7 - Game.difficulty_multiple * 2
	SceneManager.scene_switch(SceneManager.SCENE_INDEX.WORLD, Game.SHADER_INDEX.LEFT_TO_RIGHT)
#endregion

#region 难度选择的返回按钮的pressed信号
func _on_back_button_pressed():
	hide()
#endregion
#endregion
