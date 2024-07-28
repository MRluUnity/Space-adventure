extends Node2D

#region 初始化
func _ready() -> void:
	LoadAndSave.load_game()
	AudioManager.bgm_play(Game.GAME_1)
	get_tree().paused = false
	TranslationServer.set_locale("zh-CN")
#endregion
