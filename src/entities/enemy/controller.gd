extends Node2D
class_name EnemyController

var combat_model: CombatModel
var model: EnemyModel
var body: Enemy

func _ready():
	body = get_parent()
	
func setup(e_model: EnemyModel, c_model: CombatModel) -> void:
	model = e_model
	combat_model = c_model

func _physics_process(delta: float) -> void:
	if combat_model.get_targets_number() and combat_model.can_attack():
		model.attack()
		
	if model.state.current_state == EnemyState.STATES.ATTACKING:
		handle_attack()
	elif model.state.target_player:
		handle_movement()
	else:
		model.idle()

func handle_movement():
	model.move(body.global_position)
	body.velocity = model.velocity()
	body.move_and_slide()
	
func handle_attack():
	combat_model.attack()

func _on_detection_area_body_entered(body: Node2D) -> void:
	if Global.is_player(body):
		model.chase(body)

func _on_detection_area_body_exited(body: Node2D) -> void:
	if Global.is_player(body):
		model.release_chase()
