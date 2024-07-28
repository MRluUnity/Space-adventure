# TODO 设置的逻辑接口
extends Control

#region 初始化的变量
## 内容UI的父节点
@onready var context_margin_container: MarginContainer = %ContextMarginContainer

#region 侧边栏UI的按钮
@onready var screen: PanelContainer = %Screen
@onready var audio: PanelContainer = %Audio
@onready var graphics: PanelContainer = %Graphics
@onready var input: PanelContainer = %Input
@onready var language: PanelContainer = %Language
#endregion

#region 音量设置界面内容
@onready var main_volume: VolumeSLot = %MainVolume
@onready var sfx_volume: VolumeSLot = %SFXVolume
@onready var ambient_sfx_volume: VolumeSLot = %AmbientSFXVolume
@onready var bgm_volume: VolumeSLot = %BGMVolume
#endregion
#endregion

func _ready() -> void:
	LoadAndSave.load_config()
	main_volume.h_slider.value = Game.main_volume
	sfx_volume.h_slider.value = Game.sfx_volume
	bgm_volume.h_slider.value = Game.bgm_volume
	ambient_sfx_volume.h_slider.value = Game.ambient_volume

	main_volume.check_box.button_pressed = Game.is_main_volume
	sfx_volume.check_box.button_pressed = Game.is_sfx_volume
	bgm_volume.check_box.button_pressed = Game.is_bgm_volume
	ambient_sfx_volume.check_box.button_pressed = Game.is_ambient_volume

func _on_back_pressed() -> void:
	Game.main_volume = main_volume.h_slider.value
	Game.sfx_volume = sfx_volume.h_slider.value
	Game.bgm_volume = bgm_volume.h_slider.value
	Game.ambient_volume = ambient_sfx_volume.h_slider.value

	Game.is_ambient_volume = ambient_sfx_volume.check_box.button_pressed
	Game.is_bgm_volume = bgm_volume.check_box.button_pressed
	Game.is_main_volume = main_volume.check_box.button_pressed
	Game.is_sfx_volume = sfx_volume.check_box.button_pressed

	LoadAndSave.save_config()
	hide()

func _on_screen_button_pressed() -> void:
	Utils.hide_all_ui(context_margin_container)
	screen.show()


func _on_audio_button_pressed() -> void:
	Utils.hide_all_ui(context_margin_container)
	audio.show()


func _on_graphics_button_pressed() -> void:
	Utils.hide_all_ui(context_margin_container)
	graphics.show()


func _on_input_button_pressed() -> void:
	Utils.hide_all_ui(context_margin_container)
	input.show()


func _on_language_button_pressed() -> void:
	Utils.hide_all_ui(context_margin_container)
	language.show()


func _on_chinese_pressed() -> void:
	TranslationServer.set_locale("zh-CN")


func _on_english_pressed() -> void:
	TranslationServer.set_locale("en")


func _on_japanese_pressed() -> void:
	TranslationServer.set_locale("ja")


func _on_chinese_2_pressed() -> void:
	TranslationServer.set_locale("zh-TW")
