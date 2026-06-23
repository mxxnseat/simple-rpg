extends CharacterBody2D
class_name Player

signal inventory_updated(state: InventoryState)

@onready var state: PlayerState = $State
@onready var model: PlayerModel = $Model
@onready var controller: PlayerController = $Controller
@onready var anim_manager: PlayerAnimationManager = $AnimationManager
@onready var health_bar: HealthBar = $health_bar
@onready var combat: Combat = $combat
@onready var inventory: Inventory = $Inventory
@onready var pickup_items: PlayerPickupItems = $PickupItems
@onready var interactable: PlayerInteractable = $Interactable

func _ready():
	setup()
	
func setup():
	pickup_items.setup(20)
	health_bar.setup(state)
	model.setup(state)
	controller.setup(
		model,
		combat.model,
		pickup_items.model,
		inventory.model,
		interactable.model
	)
	anim_manager.setup(state)
	combat.setup(100)
	inventory.setup(32)
	
	health_bar.model.died.connect(_on_health_bar_died)
	pickup_items.model.picked_up.connect(_on_item_picked_up)
	inventory.model.inventory_updated.connect(_on_inventory_updated)

func _on_health_bar_died():
	model.die()
	await anim_manager.on_death()
	queue_free()

func take_damage(amount: int):
	health_bar.take_damage(amount)
	
func _on_item_picked_up(item: Item) -> void:
	inventory.add_item(item, 1)
	
func open_inventory():
	inventory.open()
	
func close_inventory():
	inventory.close()
	
func _on_inventory_updated(state: InventoryState) -> void:
	inventory_updated.emit(state)
