extends Node
class_name PlayerSfxManager

var state: PlayerState
var sfx_player: AnimationPlayer
var footsteps_player: AudioStreamPlayer

func setup(p_state: PlayerState, p_sfx_player: AnimationPlayer, p_footsteps_player: AudioStreamPlayer) -> void:
	state = p_state
	sfx_player = p_sfx_player
	footsteps_player = p_footsteps_player

	footsteps_player.finished.connect(_on_footsteps_finished)
	state.state_changed.connect(_on_state_changed)

func _on_state_changed(action: PlayerState.STATES) -> void:
	match action:
		PlayerState.STATES.ATTACKING:
			sfx_player.play("attack_sfx")
			stop_footsteps()
		PlayerState.STATES.MOVING:
			play_footsteps()
		_:
			stop_footsteps()

func play_footsteps() -> void:
	if not footsteps_player.playing:
		footsteps_player.play()

func stop_footsteps() -> void:
	if footsteps_player.playing:
		footsteps_player.stop()

func _on_footsteps_finished() -> void:
	if state.current_state == PlayerState.STATES.MOVING:
		footsteps_player.play()
