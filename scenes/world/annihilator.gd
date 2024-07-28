extends Area2D

signal count_update
signal line_minification(minification : int)
signal some_tool_tip(reversal_count : int, tip : String, text : String)

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var color_rect: ColorRect = $ColorRect

var count_multiple : int = 1
var count : int = 0
var is_minification_tip : bool = false

@export var down_1000_asteroid : int = 1
@export var up_1000_asteroid : int = 2
@export var up_2000_asteroid : int = 5

func _ready() -> void:
	collision_shape_2d.shape.size = Vector2(200, 3000)
	Game.count = 0
	count_update.emit()

func _process(delta: float) -> void:
	color_rect.size = collision_shape_2d.shape.size

func _on_body_entered(body: Node2D) -> void:
	if body is Asteroid:
		if body.speed > 1000:
			Game.count += (up_1000_asteroid * count_multiple * Game.difficulty_multiple)
			count += (up_1000_asteroid * count_multiple * Game.difficulty_multiple)
		elif body.speed > 2000 :
			Game.count += (up_2000_asteroid * count_multiple * Game.difficulty_multiple)
			count += (up_2000_asteroid * count_multiple * Game.difficulty_multiple)
		else :
			Game.count += (down_1000_asteroid * count_multiple * Game.difficulty_multiple)
			count += (down_1000_asteroid * count_multiple * Game.difficulty_multiple)

		if Game.count > 80 * Game.difficulty_multiple and not is_minification_tip:
			is_minification_tip = true
			some_tool_tip.emit(80, "边界坍塌")

		if count > 80 * Game.difficulty_multiple:
			count = 0
			line_minification.emit(-50)

		count_update.emit()
		body.destory()

	if body is Prop:
		body.queue_free()


func _on_player_black_hole_is_enable() -> void:
	count_multiple *= 2
	print("当前%s倍计分" % count_multiple)
	var tween : Tween = create_tween()
	tween.tween_property(collision_shape_2d.shape, "size", Vector2(6000, 3000), .5)
	tween.tween_property(collision_shape_2d.shape, "size", Vector2(200, 3000), .5)
	if tween.finished:
		count_multiple /= 2
	print("黑洞开始")


func _on_player_reversal_is_update() -> void:
	count_multiple = 2
	get_tree().create_timer(4).timeout.connect(func(): count_multiple = 1)
