extends ProgressBar
class_name HealthBarView

var state: HealthBarState

func setup(h_state: HealthBarState) -> void:
	state = h_state
	
	state.state_changed.connect(_on_state_changed)
	
	min_value = 0
	max_value = state.max_hp
	value = state.current_hp
	center_under_body()
	invisible_if_hit()

func _on_state_changed() -> void:
	value = state.current_hp
	invisible_if_hit()

func center_under_body():
	var rect = get_rect()
	var width = rect.position.x+rect.end.x
	position.x = -width / 2
	position.y = 2

func invisible_if_hit():
	visible = state.current_hp != state.max_hp
