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
@onready var gear: Gear = $Gear
@onready var stats: Stats = $Stats

var quest_log: QuestLog
var enemy_id: int = -1

func setup(p_quest_log: QuestLog):
	quest_log = p_quest_log
	
	combat.setup(stats)
	health_bar.setup(stats, combat.state)
	model.setup(state)
	controller.setup(model, combat.model)
	anim_manager.setup(state)
	inventory.setup(12)
	
	drop_item.setup(inventory.model)
	
	gear.setup(stats, inventory)
	health_bar.state_changed.connect(_on_health_bar_state_changed)
	anim_manager.attack_finished.connect(model.finish_attack)
	fill_inventory()

func _on_health_bar_state_changed(state: HealthBarState) -> void:
	if state.is_dead:
		_on_health_bar_died()

func _on_health_bar_died():
	quest_log.notify_enemy_died(self)
	model.die()
	await anim_manager.on_death()
	drop_items()
	queue_free()

func take_damage(amount: int) -> void:
	health_bar.take_damage(amount)
	combat.took_damage()

func drop_items() -> void:
	items_dropped.emit(drop_item.drop(global_position))

func fill_inventory() -> void:
	if not loot_table:
		return
	var loots = loot_table.roll()
	for item in loots:
		inventory.add_item(item)
