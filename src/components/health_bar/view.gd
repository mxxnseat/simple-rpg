extends ProgressBar
class_name HealthBarView

var state: HealthBarState

func setup(h_state: HealthBarState) -> void:
	state = h_state
	
	state.state_changed.connect(_on_state_changed)
	
	value = state.current_hp
	center_under_body()

func _on_state_changed() -> void:
	value = state.current_hp

func center_under_body():
	var rect = get_rect()
	var width = rect.position.x+rect.end.x
	position.x = -width / 2
	position.y = 2
