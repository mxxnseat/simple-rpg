extends Node2D
class_name CombatModel

signal attack_sig()

var state: CombatState
var stats: Stats

@onready var cooldown_timer: Timer = $"../attack_cooldown"
@onready var in_combat_release_timer: Timer = $"../in_combat_release"

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

func took_damage() -> void:
	state.set_is_in_combat(true)
	in_combat_release_timer.start()
	
func attack():
	if not can_attack():
		return
	state.set_is_in_combat(true)
	state.set_is_attack_cooldown(true)
	state.set_is_attacking(true)
	cooldown_timer.start()
	in_combat_release_timer.start()
	
	var targets = get_targets()
	
	for target in targets:
		var damage = stats.get_stat("damage").get_value()
		target.take_damage(damage)
	state.set_is_attacking(false)
		
func _on_attack_cooldown_timeout() -> void:
	state.set_is_attack_cooldown(false)

func _on_in_combat_release_timeout() -> void:
	state.set_is_in_combat(false)
