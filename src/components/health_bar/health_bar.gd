extends Control
class_name HealthBar

signal state_changed(state: HealthBarState)

@onready var state: HealthBarState = $State
@onready var view: HealthBarView = $ProgressBar
@onready var model: HealthBarModel = $Model
@onready var regeneration_timer: Timer = $RegenerationTimer

var stats: Stats

func setup(p_stats: Stats, combat_state: CombatState) -> void:
	stats = p_stats
	state.setup(
		stats
			.get_stat(Global.STATS_NAMES["MAX_HP"])
			.get_value()
	)
	model.setup(state)
	view.setup(state)
	
	state.state_changed.connect(func(): state_changed.emit(state))
	combat_state.state_changed.connect(_on_combat_state_state_changed)

func _on_combat_state_state_changed(state: ICombatState, previous_state: ICombatState) -> void:
	if state.is_in_combat:
		regeneration_timer.stop()
	else:
		regeneration_timer.start()
	

# Public interface
func take_damage(amount: int) -> void:
	var new_damage = max(
		amount - stats.get_stat(
			Global.STATS_NAMES["DEFENCE"]
		).get_value(),
		1.0
	)
	model.take_damage(new_damage)

func _on_regeneration_timer_timeout() -> void:
	model.regenerate(
		stats
			.get_stat(Global.STATS_NAMES["REGENERATION"])
			.get_value()
	)
