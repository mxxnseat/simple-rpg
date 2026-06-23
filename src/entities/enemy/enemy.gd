extends CharacterBody2D
class_name Enemy

signal items_dropped(items: Array[DropItemResource])

@export var loot_table: LootTable

@onready var state: EnemyState = $State
@onready var model: EnemyModel = $Model
@onready var controller: EnemyController = $Controller
@onready var anim_manager: EnemyAnimationManager = $AnimationManager
@onready var health_bar: HealthBar = $health_bar
@onready var combat: Combat = $combat
@onready var drop_item: DropItem = $DropItem
@onready var inventory: Inventory = $Inventory

func _ready():
	health_bar.setup(state)
	model.setup(state)
	controller.setup(model, combat.model)
	anim_manager.setup(state)
	inventory.setup(12)
	
	drop_item.setup(inventory.model)
	
	combat.setup(10)
	
	health_bar.model.died.connect(_on_health_bar_died)
	combat.model.attack_sig.connect(_on_combat_attack_sig)
	fill_inventory()

func _on_health_bar_died():
	model.die()
	await anim_manager.on_death()
	drop_items()
	queue_free()
	
func take_damage(amount: int) -> void:
	health_bar.take_damage(amount)

func _on_combat_attack_sig() -> void:
	model.attack()
	
func drop_items() -> void:
	items_dropped.emit(drop_item.drop(global_position))

func fill_inventory() -> void:
	if not loot_table:
		return
	var loots = loot_table.roll()
	for item in loots:
		inventory.add_item(item)
