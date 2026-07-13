class_name StatModifier
extends RefCounted

enum Type { FLAT }

var type: Type
var value: float
var source: Object

func _init(p_type: Type, p_value: float, p_source: Object = null) -> void:
	type = p_type
	value = p_value
	source = p_source
