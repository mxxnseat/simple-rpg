extends Node2D
class_name CombatState

signal state_changed(state: ICombatState, previous_state: ICombatState)

var is_attack_cooldown = false
var is_attacking = false
var is_in_combat = false
var targets: Dictionary[Node2D, bool] = {}

func get_current_state() -> ICombatState:
	var state = ICombatState.new()
	
	state.is_attack_cooldown = is_attack_cooldown
	state.is_attacking = is_attacking
	state.is_in_combat = is_in_combat
	
	return state

func set_is_in_combat(value: bool) -> void:
	if is_in_combat == value:
		return
	var previous_state = get_current_state()
	is_in_combat = value
	state_changed.emit(get_current_state(), previous_state)
	
func set_is_attack_cooldown(value: bool) -> void:
	if is_attack_cooldown == value:
		return
	var previous_state = get_current_state()
	is_attack_cooldown = value
	state_changed.emit(get_current_state(), previous_state)
	
func set_is_attacking(value: bool) -> void:
	if is_attacking == value:
		return
	var previous_state = get_current_state()
	is_attacking = value
	state_changed.emit(get_current_state(), previous_state)
