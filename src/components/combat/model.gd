extends Node2D
class_name CombatModel

signal attack_sig()

var state: CombatState
@onready var cooldown_timer: Timer = $"../attack_cooldown"

func setup(c_state: CombatState):
	state = c_state
	
func add_target(target: Node2D):
	state.targets[target] = true
	
func remove_target(target: Node2D):
	state.targets.erase(target)
	
func get_targets() -> Dictionary:
	return state.targets
	
func get_targets_number() -> int:
	return state.targets.size()
	
func can_attack():
	return not state.is_attack_cooldown
	
func attack():
	if not can_attack():
		return
	state.is_attack_cooldown = true
	cooldown_timer.start()
	
	# here in future have to decide who should be attacked
	emit_signal("attack_sig")
	var targets = get_targets()
	for target in targets:
		target.take_damage(state.damage)
		
func _on_attack_cooldown_timeout() -> void:
	state.is_attack_cooldown = false
