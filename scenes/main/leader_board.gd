extends PanelContainer

#region 初始化的变量
## 动画器，用来播放排行榜进入和退出动画
@onready var animation_player: AnimationPlayer = $AnimationPlayer

## 排行榜中排行格子的父容器
@onready var v_box_container: VBoxContainer = $ScrollContainer/VBoxContainer
#endregion

#region 加载排行榜并排序
## 这个方法用来加载排行榜并进行排序
func load_leader() -> void:
	for i in v_box_container.get_children():
		i.queue_free()

	var count_slots : Array[CountSlot]
	for i in Game.leader_board_dic:
		for m in Game.leader_board_dic[i]:
			var count_slot : CountSlot = Game.COUNT_SLOT.instantiate()
			count_slot.set_count_slot(i, m)
			count_slots.append(count_slot)

	for i in count_slots.size():
		for m in count_slots.size():
			if count_slots[i].count > count_slots[m].count:
				var slot : CountSlot = count_slots[i]
				count_slots[i] = count_slots[m]
				count_slots[m] = slot

	for i in count_slots.size():
		v_box_container.add_child(count_slots[i])
#endregion

#region 信号链接
#region 排行榜返回按钮的pressed信号
# 排行榜界面的返回键
func _on_back_button_pressed() -> void:
	animation_player.play("leader_board_exit")
#endregion

#region 排行榜的visibility_changed信号
# 当排行榜界面被显示就执行存档加载
func _on_visibility_changed() -> void:
	if visible:
		load_leader()
#endregion
#endregion
