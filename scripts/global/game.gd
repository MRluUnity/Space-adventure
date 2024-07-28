extends Node

const DESTORY_PARTICLES = preload("res://particles/destory_particles.tscn")
const SPRITE_0002 = preload("res://assets/Sprite-0002.png")

## 着色器效果的索引
const GAME_1 = preload("res://assets/Game_1.ogg")
const GAME_2 = preload("res://assets/Game_2.ogg")

## 排行格子的预加载
const COUNT_SLOT = preload("res://scenes/main/count_slot.tscn")

enum SHADER_INDEX{
	UP_TO_DOWN,
	LEFT_TO_RIGHT,
	LUP_TO_RDOWN,
	DOWN_TO_UP,
	RIGHT_TO_LEFT,
	LDOWN_TO_RUP,
}

var count : int = 0:
	set(v):
		count = v
		#print("当前分数：%s" % count)

var _name : String = ""

var health : int = 5

enum DifficultyMultiple{
	NULL,
	EASY,
	NORMAL,
	HARD
}

var difficulty_multiple : DifficultyMultiple

var leader_board_dic : Dictionary

var main_volume : float = .6
var bgm_volume : float = 1
var sfx_volume : float = 1
var ambient_volume : float = 1

var is_main_volume : bool = false
var is_bgm_volume : bool = false
var is_sfx_volume : bool = false
var is_ambient_volume : bool = false
