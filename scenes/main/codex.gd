extends PanelContainer

@onready var scroll_container: ScrollContainer = $HBoxContainer/TabContainer/Props/MarginContainer/HBoxContainer/PanelContainer/MarginContainer/ScrollContainer

func _on_back_button_pressed() -> void:
	hide()
