class_name FateDice extends Prop

@export var props : Array[PackedScene]

func create_prop() -> void:
	var index : int = randi_range(0, props.size() - 1)
	var prop : Prop = props[index].instantiate()
	prop.global_position = position
	get_parent().add_child(prop)
