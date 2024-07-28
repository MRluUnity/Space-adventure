## 排行榜上的分数格子
class_name CountSlot extends HBoxContainer

var count : int

func set_count_slot(_name : String, _count : int) -> void:
	$NameLabel.text = " 玩家： %s" % _name
	count = _count
	$CountLabel.text = "分数：%s" % _count
