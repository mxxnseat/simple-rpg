extends Node
class_name PlayerController

var player_pickup_items_model: PlayerPickupItemsModel
var combat_model: CombatModel
var model: PlayerModel
var body: Player

func setup(p_model: PlayerModel, c_model: CombatModel, ppi_model: PlayerPickupItemsModel):
	model = p_model
	combat_model = c_model
	player_pickup_items_model = ppi_model

func _ready():
	body = get_parent()
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("attack"):
		model.attack()
		combat_model.attack()
	if event.is_action_pressed("pickup"):
		player_pickup_items_model.pickup()
		
func _physics_process(delta) -> void:
	handle_movement()
		
func handle_movement()->void:
	if Input.is_action_pressed("ui_left"):
		model.move(Vector2(-1, 0))
	elif Input.is_action_pressed("ui_right"):
		model.move(Vector2(1, 0))
	elif Input.is_action_pressed("ui_up"):
		model.move(Vector2(0, -1))
	elif Input.is_action_pressed("ui_down"):
		model.move(Vector2(0, 1))
	else:
		model.idle()
		
	body.velocity = model.velocity()
	body.move_and_slide()
