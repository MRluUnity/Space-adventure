## 陨石类
class_name Asteroid extends CharacterBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D

@export var min_speed : float = 100.
@export var max_speed : float = 350.

var is_rotating : bool = false
var is_skill : bool = false
var is_coll : bool = false
var is_move : bool = false

var speed : float:
	set(v):
		speed = v

@export var mutiple : float = 1.0

func _ready() -> void:
	speed = randf_range(min_speed, max_speed)

func _physics_process(delta: float) -> void:
	velocity = speed * Vector2.LEFT * mutiple
	if is_move:
		rotate(delta / 2)
		velocity.y = rotation * speed / 20

	if is_rotating:
		rotate(delta)
	move_and_slide()

func asteroid_skill() -> void:
	pass

func destory() -> void:
	var destory_particles : DestoryParticles = Game.DESTORY_PARTICLES.instantiate()
	destory_particles.set_destory_particles(position, true, sprite_2d.texture)
	get_parent().add_child(destory_particles)
	queue_free()
