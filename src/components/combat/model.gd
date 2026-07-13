extends Node2D
class_name CombatModel

signal attack_sig()

var state: CombatState
var stats: Stats
@onready var cooldown_timer: Timer = $"../attack_cooldown"

func setup(c_state: CombatState, p_stats: Stats):
	state = c_state
	stats = p_stats
	
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
	
	attack_sig.emit()
	var targets = get_targets()
	print(stats.get_stat("damage").get_value())
	for target in targets:
		var damage = stats.get_stat("damage").get_value()
		target.take_damage(damage)
		
func _on_attack_cooldown_timeout() -> void:
	state.is_attack_cooldown = false
