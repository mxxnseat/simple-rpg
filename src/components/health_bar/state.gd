extends Node2D
class_name HealthBarState

signal state_changed()

var max_hp: int
var current_hp: int
var is_dead = false

func setup(_max_hp: int):
	max_hp = _max_hp
	current_hp = _max_hp
	
func increment_current_hp(amount: int) -> void:
	var new_value = current_hp + amount
	if new_value > max_hp:
		update_current_hp(max_hp)
	elif new_value < 0:
		update_current_hp(0)
	else:
		update_current_hp(new_value)
		
func update_current_hp(amount: int):
	current_hp = amount
	state_changed.emit()

func set_is_dead(value: bool) -> void:
	is_dead = value
	state_changed.emit()
