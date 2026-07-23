extends Node2D
class_name EnemyAnimationManager

signal attack_finished

var state: EnemyState
@onready var animation_sprite = $AnimatedSprite2D

func setup(e_state: EnemyState):
	state = e_state

	state.state_changed.connect(_on_state_changed)
	on_idle()

func _on_state_changed(action: EnemyState.STATES):
	match action:
		EnemyState.STATES.ATTACKING:
			on_attacking()
		EnemyState.STATES.IDLE:
			on_idle()
		EnemyState.STATES.MOVING:
			on_moving()
		
func flip_h()->void:
	animation_sprite.flip_h = state.facing_direction.x < 0 \
		if abs(state.facing_direction.x) > abs(state.facing_direction.y) else false

func on_idle():
	if state.facing_direction.y > 0:
		animation_sprite.play("front_idle")
	elif state.facing_direction.y < 0:
		animation_sprite.play("back_idle")
	else:
		animation_sprite.play("side_idle")
	flip_h()
		
func on_moving():
	if state.facing_direction.y > 0:
		animation_sprite.play("front_walk")
	elif state.facing_direction.y < 0:
		animation_sprite.play("back_walk")
	else:
		animation_sprite.play("side_walk")
	flip_h()
		
func on_death():
	animation_sprite.play("death")
	await animation_sprite.animation_finished

func on_attacking():
	if state.facing_direction.y > 0:
		animation_sprite.play("front_attack")
	elif state.facing_direction.y < 0:
		animation_sprite.play("back_attack")
	else:
		animation_sprite.play("side_attack")
	flip_h()
	await animation_sprite.animation_finished
	attack_finished.emit()
