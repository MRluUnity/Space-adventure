class_name Prop extends CharacterBody2D

@export var texture : Texture
@export var texture_mutiple : int
@export var min_speed : float = 100.
@export var max_speed : float = 350.

var speed : float:
	set(v):
		speed = v

func _ready() -> void:
	speed = randf_range(min_speed, max_speed)

func _physics_process(delta: float) -> void:
	velocity = speed * Vector2.LEFT
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Asteroid:
		body.destory()
		destory()

func destory() -> void:
	var destory_particles : DestoryParticles = Game.DESTORY_PARTICLES.instantiate()
	destory_particles.set_destory_particles(position, true)
	get_parent().add_child(destory_particles)
	queue_free()
