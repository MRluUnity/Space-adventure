extends PanelContainer

@onready var texture_rect: TextureRect = $MarginContainer/VBoxContainer/PanelContainer/TextureRect
@onready var name_label: Label = $MarginContainer/VBoxContainer/PanelContainer2/VBoxContainer/Label
@onready var desc_label: Label = $MarginContainer/VBoxContainer/PanelContainer2/VBoxContainer/Label2


func _on_props_button_group_update_codex_context(_texture: Texture, _name : String, _text: String) -> void:
	texture_rect.texture = _texture
	name_label.text = _name
	desc_label.text = _text
