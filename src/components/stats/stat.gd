class_name Stat
extends RefCounted

signal changed(new_value: float)

var base_value: float
var _modifiers: Array[StatModifier] = []
var _cached_value: float
var _dirty := true

func _init(p_base: float) -> void:
	base_value = p_base

func add_modifier(mod: StatModifier) -> void:
	_modifiers.append(mod)
	_dirty = true
	changed.emit(get_value())

func remove_modifiers_from_source(source: Object) -> void:
	_modifiers = _modifiers.filter(func(modifier): return modifier.source != source)
	_dirty = true
	changed.emit(get_value())

func get_value() -> float:
	if _dirty:
		_recalculate()
	return _cached_value

func _recalculate() -> void:
	var flat := 0.0
	var override_value = null

	for m in _modifiers:
		match m.type:
			StatModifier.Type.FLAT: flat += m.value

	var result = base_value + flat
	_cached_value = override_value if override_value != null else result
	_dirty = false
