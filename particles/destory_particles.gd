class_name DestoryParticles extends CPUParticles2D

@export var _texture : Texture


func set_destory_particles(position : Vector2, _emitting : bool, _texture : Texture = null) -> void:
	if _texture:
		texture = _texture
	else :
		texture = Game.SPRITE_0002
	global_position = position
	emitting = _emitting
	finished.connect(func(): queue_free())
