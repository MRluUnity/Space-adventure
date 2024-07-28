extends Marker2D

signal some_tool_tip(reversal_count : int, tip : String, text : String)
signal boundary_rotate

const REVERSAL = preload("res://scenes/traps/reversal.tscn")
const TIME_CONFUSION_REGION = preload("res://scenes/traps/time_confusion_region.tscn")

@onready var timer: Timer = $Timer
@onready var player: Player = %Player
@onready var vhs: ColorRect = $"../UI/VHS"

@export var asteroids : Array[PackedScene]
@export var props : Array[PackedScene]

@export var min_time : float = 1.
@export var max_time : float = 4.5

@export var reversal_count : int = 20
@export var reversal_chance : int = 8

@export var prop_chance : int = 5

@export var time_confusion_count : int = 35
@export var time_confusion_chance : int = 3

@export var boundary_vortex_count : int = 100
@export var boundary_vortex_chance : int = 2

var min_offset_x : float = -200.
var max_offset_x : float = 200.
var min_offset_y : float = -550.
var max_offset_y : float = 550.

var reversal_is_enter : bool = false

var time_confusion_region_is_enter : bool = false

var boundary_vortex_is_enter : bool = false

var is_boundary_rotate : bool = false

func _ready() -> void:
	reset_time()
	if Game.difficulty_multiple == Game.DifficultyMultiple.EASY: return
	min_time /= Game.difficulty_multiple
	max_time /= Game.difficulty_multiple


func _on_timer_timeout() -> void:
	reset_time()

func reset_time() -> void:
	var time : float
	time = randf_range(min_time, max_time)
	timer.wait_time = time
	create_asteroid(randi_range(0, asteroids.size() - 1))

	var prop_index = randi() % 100
	if prop_index <= prop_chance:
		var prop : int = randi_range(0, props.size() - 1)
		if prop == 8 and Game.count < 80 * Game.difficulty_multiple:
			prop = randi_range(0, props.size() - 3)
		create_prop(prop)

	if Game.count >= reversal_count * Game.difficulty_multiple and not reversal_is_enter:
		some_tool_tip.emit(reversal_count, "反转线", "反转线会将重力反转，给与4秒双倍")
		reversal_is_enter = true

	var reversal_count_index = randi() % 100
	if reversal_count_index < reversal_chance and reversal_is_enter:
		var reversal : Reversal = REVERSAL.instantiate()
		reversal.global_position = global_position
		reversal.global_position.y = 540
		add_child(reversal)

	if Game.count >= time_confusion_count * Game.difficulty_multiple and not time_confusion_region_is_enter:
		some_tool_tip.emit(time_confusion_count, "时间混乱线", "时间混乱线会将时间流速打乱")
		time_confusion_region_is_enter = true

	var time_confusion_index = randi() % 100
	if time_confusion_index < time_confusion_chance and time_confusion_region_is_enter:
		var time_confusion_region : TimeConfusionRegion = TIME_CONFUSION_REGION.instantiate()
		time_confusion_region.global_position = global_position
		time_confusion_region.global_position.y = 540
		add_child(time_confusion_region)

	if Game.count >= boundary_vortex_count * Game.difficulty_multiple and not boundary_vortex_is_enter:
		some_tool_tip.emit(boundary_vortex_count, "边界漩涡", "边界漩涡会将边界旋转两周")
		boundary_vortex_is_enter = true

	var boundary_vortex_index = randi() % 100
	if boundary_vortex_index < boundary_vortex_chance and boundary_vortex_is_enter and not is_boundary_rotate:
		is_boundary_rotate = true
		boundary_rotate.emit()


func create_asteroid(index : int) -> void:
	var asteroid : Asteroid = asteroids[index].instantiate()

	var offset : Vector2 = Vector2(randf_range(min_offset_x, max_offset_x), randf_range(min_offset_y, max_offset_y))

	asteroid.global_position = global_position + offset

	asteroid.rotation = deg_to_rad(randi_range(0, 360))

	if Game.count > 450:
		var scale_numner : float = randf_range(2.0, 4.0)
		asteroid.scale = Vector2.ONE * scale_numner

	add_child(asteroid)

	if asteroid.speed > 1000:
		asteroid.global_position.y = player.global_position.y

func create_prop(index : int, _position : Vector2 = Vector2.ZERO) -> void:
	var prop : Prop = props[index].instantiate()

	if _position == Vector2.ZERO:
		var offset : Vector2 = Vector2(randf_range(min_offset_x, max_offset_x), randf_range(min_offset_y, max_offset_y))

		prop.global_position = global_position + offset
	else :
		prop.global_position = _position

	add_child(prop)


func _on_player_destory_is_not_rotate() -> void:
	await get_tree().create_timer(12).timeout
	is_boundary_rotate = false
	print("可以继续旋转")
