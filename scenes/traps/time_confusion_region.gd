class_name TimeConfusionRegion extends Area2D


@export var min_time_scale : float = .3
@export var max_time_scale : float = 1.5
var time_scale : float


func _ready() -> void:
	time_scale = randf_range(min_time_scale, max_time_scale)


func _on_body_entered(body: Node2D) -> void:
	Engine.time_scale = time_scale
	body.is_vhs = true


func _on_body_exited(body: Node2D) -> void:
	Engine.time_scale = 1
	body.is_vhs = false
	get_tree().create_timer(2).timeout.connect(func():queue_free())


func _process(delta: float) -> void:
	global_position.x -= delta * 400
