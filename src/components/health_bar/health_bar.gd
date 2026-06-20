extends Control
class_name HealthBar

@onready var state: HealthBarState = $State
@onready var view: HealthBarView = $ProgressBar
@onready var model: HealthBarModel = $Model

func setup(passed_state):
	assert(passed_state.get("max_hp") != null, "Passed state doesn't have max_hp property")
	
	state.setup(passed_state.max_hp)
	model.setup(state)
	view.setup(state)
	
# Public interface
func take_damage(amount: int):
	model.take_damage(amount)
