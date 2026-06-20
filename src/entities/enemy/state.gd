extends Node
class_name EnemyState

signal state_changed(action: STATES)

enum STATES { IDLE, ATTACKING, MOVING, HURT, DEAD }

var current_state: STATES = STATES.IDLE
var facing_direction = Vector2.ZERO
var max_hp: int = 100
var speed: float = 50.0
var damage: int = 10
var velocity: Vector2 = Vector2.ZERO

var target_player: Player = null

func _ready() -> void:
	set_state(STATES.IDLE)
	
func set_player(new_player):
	target_player = new_player
	
func move(direction: Vector2) -> void:
	velocity = direction * speed
	facing_direction = direction
	set_state(STATES.MOVING)
	
func set_state(state: STATES) -> void:
	current_state = state
	emit_signal("state_changed", current_state)
