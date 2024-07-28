class_name HealthModule extends Node

signal health_update(health : int, max_health : int)
signal is_dead

@export var max_health : int = 5
var health : int:
	set(v):
		health = v
		
		if health <= 0:
			health = 0
			is_dead.emit()
		if health >= max_health:
			health = max_health
		
		health_update.emit(health, max_health)
		

func reset_health() -> void:
	health = max_health
