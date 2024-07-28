extends Node

func _ready() -> void:
	AudioManager.bgm_play(Game.GAME_2)
	get_tree().paused = true
