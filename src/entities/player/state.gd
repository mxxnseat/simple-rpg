extends Node
class_name PlayerState

signal state_changed(action: STATES)

enum STATES { IDLE, MOVING, ATTACKING, HURT, DEAD }

var current_state: STATES = STATES.IDLE
var facing_direction = Vector2.ZERO
var max_hp: int = 300
var speed: float = 100.0
var damage: int = 10
var velocity: Vector2 = Vector2.ZERO

func _ready() -> void:
	set_state(STATES.IDLE)

func set_state(state: STATES) -> void:
	current_state = state
	emit_signal("state_changed", current_state)
