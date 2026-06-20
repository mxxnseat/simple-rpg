extends Node2D
class_name HealthBarState

signal state_changed()

var max_hp: int
var current_hp: int

func setup(_max_hp: int):
	max_hp = _max_hp
	current_hp = _max_hp
	
func update_current_hp(amount: int):
	current_hp = amount
	emit_signal("state_changed")
	
