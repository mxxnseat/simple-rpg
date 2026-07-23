extends Node2D
class_name PlayerAnimationManager

signal attack_finished

var state: PlayerState

@onready var animation_sprite = $AnimatedSprite2D

func setup(p_state: PlayerState):
	state = p_state

	state.state_changed.connect(_on_state_changed)
	play_animation(p_state.current_state)

func _on_state_changed(action: PlayerState.STATES):
	play_animation(action)
			
func play_animation(action: PlayerState.STATES):
	match action:
		PlayerState.STATES.ATTACKING:
			on_attacking()
		PlayerState.STATES.IDLE:
			on_idle()
		PlayerState.STATES.MOVING:
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
