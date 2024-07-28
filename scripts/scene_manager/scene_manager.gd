# TODO 场景管理器
extends CanvasLayer

## 动画器获取
@onready var animation_player: AnimationPlayer = $AnimationPlayer
## 颜色遮罩获取
@onready var color_rect: ColorRect = $ColorRect

## 场景集合
@export var scenes : Array[PackedScene]

## 场景的索引
enum SCENE_INDEX{
	MAIN,
	WORLD
}

## 场景切换的方法
func scene_switch(scene_index, shader_index) -> void:
	color_rect.material.set_shader_parameter("mode", shader_index)
	animation_player.play("tran_in")
	await animation_player.animation_finished
	get_tree().change_scene_to_packed(scenes[scene_index])
	animation_player.play("tran_out")
