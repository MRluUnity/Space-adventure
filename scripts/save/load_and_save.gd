extends Node

# TODO 存档系统

# TODO 存档系统:补充玩家类，完善存档系统

## 这个方法用来保存游戏数据
func save_game() -> void:
	var new_save : Save = Save.new()
	if load("user://save_game_1.tres"):
		var old_save : Save = load("user://save_game_1.tres") as Save
		new_save.leader_board_dic = old_save.leader_board_dic

	if new_save.leader_board_dic.keys().has(Game._name):
		new_save.leader_board_dic[Game._name].append(Game.count)
		var arr : Array = new_save.leader_board_dic[Game._name]
		new_save.leader_board_dic[Game._name] = arr
	else :
		new_save.leader_board_dic[Game._name] = Array([Game.count])

	new_save.user_name = Game._name

	ResourceSaver.save(new_save, "user://save_game_1.tres")

## 这个方法用来加载游戏数据
func load_game() -> void:
	if load("user://save_game_1.tres"):
		var old_save : Save = load("user://save_game_1.tres") as Save
		Game._name = old_save.user_name
		Game.leader_board_dic = old_save.leader_board_dic

func save_config() -> void:
	var new_config : Config = Config.new()

	new_config.ambient_volume = Game.ambient_volume
	new_config.bgm_volume = Game.bgm_volume
	new_config.main_volume = Game.main_volume
	new_config.sfx_volume = Game.sfx_volume

	new_config.is_ambient_volume = Game.is_ambient_volume
	new_config.is_bgm_volume = Game.is_bgm_volume
	new_config.is_main_volume = Game.is_main_volume
	new_config.is_sfx_volume = Game.is_sfx_volume

	ResourceSaver.save(new_config, "user://config.tres")

func load_config() -> void:
	if load("user://config.tres"):
		var old_config : Config = load("user://config.tres") as Config

		Game.ambient_volume = old_config.ambient_volume
		Game.bgm_volume = old_config.bgm_volume
		Game.main_volume = old_config.main_volume
		Game.sfx_volume = old_config.sfx_volume

		Game.is_ambient_volume = old_config.is_ambient_volume
		Game.is_bgm_volume = old_config.is_bgm_volume
		Game.is_main_volume = old_config.is_main_volume
		Game.is_sfx_volume = old_config.is_sfx_volume
