extends Node
class_name PlayerState

signal state_changed(action: STATES)

enum STATES { IDLE, MOVING, ATTACKING, HURT, DEAD }

var current_state: STATES = STATES.IDLE
var facing_direction = Vector2.ZERO
var speed: float = 100.0
var velocity: Vector2 = Vector2.ZERO

func _ready() -> void:
	state_changed.emit(current_state)

func set_state(state: STATES) -> void:
	if state == current_state:
		return
	current_state = state
	state_changed.emit(current_state)
