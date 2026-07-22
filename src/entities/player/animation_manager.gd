extends Node2D
class_name PlayerAnimationManager

var state: PlayerState
var sfx_player: AnimationPlayer

@onready var animation_sprite = $AnimatedSprite2D
@onready var footsteps_player: AudioStreamPlayer = $FootStepsPlayer
var is_attacking = false

func setup(p_state: PlayerState, sfx_player: AnimationPlayer):
	state = p_state
	self.sfx_player = sfx_player
	
	state.state_changed.connect(_on_state_changed)
	
func is_not_attacking_with(condition: bool) -> bool:
	return not is_attacking and condition
	
func _on_state_changed(action: PlayerState.STATES):
	if action == PlayerState.STATES.ATTACKING:
		is_attacking = true
		on_attacking()
	elif is_not_attacking_with(action == PlayerState.STATES.IDLE):
		on_idle()
	elif is_not_attacking_with(action == PlayerState.STATES.MOVING):
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
	if not footsteps_player.playing:
		footsteps_player.play()
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
	sfx_player.play("attack_sfx")
	if state.facing_direction.y > 0:
		animation_sprite.play("front_attack")
	elif state.facing_direction.y < 0:
		animation_sprite.play("back_attack")
	else:
		animation_sprite.play("side_attack")
	flip_h()
	await animation_sprite.animation_finished
	is_attacking = false
