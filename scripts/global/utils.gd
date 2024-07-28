# TODO 工具方法
extends Node

# TODO 工具方法：获得输入向量
## 获取玩家输入的方向
func get_dir() -> Vector2:
	return Input.get_vector("action_left", "action_right", "action_up", "action_down")


# TODO 工具方法：隐藏子UI
## 隐藏当前UI的所有子UI
func hide_all_ui(parent_ui : Node) -> void:
	for i in parent_ui.get_children():
		if i is Control:
			i.hide()
