extends VBoxContainer

#region 初始化的变量
# 所有UI界面的父节点
@onready var context_control: Control = $"../ContextControl"
# 排行榜的UI界面
@onready var leader_board: PanelContainer = $"../ContextControl/LeaderBoard"
# 动画器
@onready var animation_player: AnimationPlayer = $"../ContextControl/LeaderBoard/AnimationPlayer"
# 难度选择的UI界面
@onready var difficulty_panel: PanelContainer = $"../ContextControl/DifficultyPanel"
# 图鉴的UI界面
@onready var codex: PanelContainer = $"../ContextControl/Codex"
# 设置的UI界面
@onready var setting_interface: PanelContainer = $"../ContextControl/SettingInterface"
#endregion

#region 信号链接
#region 开始游戏按钮的pressed信号
func _on_start_button_pressed() -> void:
	Utils.hide_all_ui(context_control)
	difficulty_panel.show()
#endregion

#region 排行榜按钮的pressed信号
func _on_leaderboard_button_pressed() -> void:
	Utils.hide_all_ui(context_control)
	animation_player.play("leader_board_enter")
#endregion

#region 游戏设置按钮的pressed信号
func _on_setting_button_pressed() -> void:
	Utils.hide_all_ui(context_control)
	setting_interface.show()
#endregion

#region 图鉴按钮的pressed信号
func _on_codex_button_pressed() -> void:
	Utils.hide_all_ui(context_control)
	codex.show()
#endregion

#region 退出游戏按钮的pressed信号
func _on_exit_button_pressed() -> void:
	get_tree().quit()
#endregion
#endregion
