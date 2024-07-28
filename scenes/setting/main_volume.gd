@tool
class_name VolumeSLot extends HBoxContainer
@onready var label: Label = $Label
@onready var volume_number: Label = $VolumeNumber
@onready var h_slider: HSlider = $HSlider
@onready var check_box: CheckButton = $CheckBox

@export var volume_name : String:
	set(v):
		volume_name = v
		if label:
			if volume_name != "":
				label.text = volume_name
@export var max_volume : float = 1.0
@export var current_bus : int = 0

func _ready() -> void:
	label.text = volume_name
	h_slider.max_value = max_volume
	volume_number.text = "%s%%" % ((h_slider.value / h_slider.max_value) * 100)


func _on_h_slider_value_changed(value: float) -> void:
	var db : float = linear_to_db(value)
	AudioServer.set_bus_volume_db(current_bus, db)
	volume_number.text = "%s%%" % ((h_slider.value / h_slider.max_value) * 100)


func _on_check_box_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(current_bus, toggled_on)
