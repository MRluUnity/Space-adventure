extends Label

func _ready() -> void:
	count_update()

func _on_annihilator_count_update() -> void:
	count_update()


func _on_player_count_update() -> void:
	count_update()

func count_update() -> void:
	var tween : Tween = create_tween()
	tween.tween_property(self, "text", "当前分数：%s" % Game.count, .5)
