extends VBoxContainer

@onready var energy_bar: ProgressBar = $EnergyContainer/EnergyBar
@onready var energy_label: Label = $EnergyContainer/EnergyLabel
@onready var energy_container: HBoxContainer = $EnergyContainer

@onready var deceleration_bar: ProgressBar = $DecelerationContainer/DecelerationBar
@onready var deceleration_label: Label = $DecelerationContainer/DecelerationLabel
@onready var deceleration_container: HBoxContainer = $DecelerationContainer

@onready var agavity_bar: ProgressBar = $AgavityContainer/AgavityBar
@onready var agavity_label: Label = $AgavityContainer/AgavityLabel
@onready var agavity_container: HBoxContainer = $AgavityContainer

@onready var damaged_armour_bar: ProgressBar = $DamagedArmourContainer/DamagedArmourBar
@onready var damaged_armour_label: Label = $DamagedArmourContainer/DamagedArmourLabel
@onready var damaged_armour_container: HBoxContainer = $DamagedArmourContainer


func _on_energy_bar_value_changed(value: float) -> void:
	energy_label.text = "护盾余剩时间：%s/%s" % [int(value + 1), energy_bar.max_value]
	if value == 0:
		energy_container.hide()

func _on_deceleration_bar_value_changed(value: float) -> void:
	deceleration_label.text = "减速带余剩时间：%s/%s" % [int(value + 1), deceleration_bar.max_value]
	if value == 0:
		deceleration_container.hide()


func _on_player_energy_time_update(time: float) -> void:
	energy_container.show()
	energy_bar.max_value = time
	energy_bar.value = time
	var tween : Tween = create_tween()
	tween.tween_property(energy_bar, "value", 0, time)


func _on_player_deceleration_time_update(time: float) -> void:
	deceleration_container.show()
	deceleration_bar.max_value = time
	deceleration_bar.value = time
	var tween : Tween = create_tween()
	tween.tween_property(deceleration_bar, "value", 0, time)
	


func _on_player_agravity_time_update(time: float) -> void:
	agavity_container.show()
	agavity_bar.max_value = time
	agavity_bar.value = time
	var tween : Tween = create_tween()
	tween.tween_property(agavity_bar, "value", 0, time)


func _on_agavity_bar_value_changed(value: float) -> void:
	agavity_label.text = "无重力余剩时间：%s/%s" % [int(value + 1), agavity_bar.max_value]
	if value == 0:
		agavity_container.hide()


func _on_damaged_armour_bar_value_changed(value: float) -> void:
	damaged_armour_label.text = "破损装甲余剩时间：%s/%s" % [int(value + 1), damaged_armour_bar.max_value]
	if value == 0:
		damaged_armour_container.hide()


func _on_player_damaged_armour_time_update(time: float) -> void:
	damaged_armour_container.show()
	damaged_armour_bar.max_value = time
	damaged_armour_bar.value = time
	var tween : Tween = create_tween()
	tween.tween_property(damaged_armour_bar, "value", 0, time)
