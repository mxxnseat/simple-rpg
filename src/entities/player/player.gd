extends CharacterBody2D
class_name Player

@onready var state: PlayerState = $State
@onready var model: PlayerModel = $Model
@onready var controller: PlayerController = $Controller
@onready var anim_manager: PlayerAnimationManager = $AnimationManager
@onready var health_bar: HealthBar = $health_bar
@onready var combat: Combat = $combat
@onready var inventory: Inventory = $Inventory
@onready var pickup_items: PlayerPickupItems = $PickupItems


func _ready():
	pickup_items.setup(20)
	health_bar.setup(state)
	model.setup(state)
	controller.setup(model, combat.model, pickup_items.model)
	anim_manager.setup(state)
	combat.setup(100)
	inventory.setup(32)
	
	health_bar.model.died.connect(_on_health_bar_died)
	pickup_items.model.picked_up.connect(_on_item_picked_up)

func _on_health_bar_died():
	model.die()
	await anim_manager.on_death()
	queue_free()

func take_damage(amount: int):
	health_bar.take_damage(amount)
	
func _on_item_picked_up(item: Item) -> void:
	inventory.add_item(item, 1)
