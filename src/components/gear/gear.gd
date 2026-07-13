extends Node
class_name Gear

var stats: Stats = null

@onready var inventory: Inventory = $Inventory
var parent_inventory: Inventory

static var SLOT_POSITION_MAPPING = {
	"weapon": 0
}

static var POSITION_SLOT_MAPPING = {
	0: "weapon"
}

func setup(p_stats: Stats, p_inventory: Inventory):
	stats = p_stats
	parent_inventory = p_inventory
	inventory.setup(1)
	
	inventory.model.inventory_updated.connect(_on_inventory_updated)

func open_inventory() -> void:
	inventory.open()
	
func close_inventory() -> void:
	inventory.close()
	
func _on_inventory_updated(state: IInventoryState, previous_state: IInventoryState):
	if state.slots == previous_state.slots:
		return
		
	var inventory_slots = state.slots
	var previous_inventory_slots = previous_state.slots
	var weapon_item = inventory.model.get_item_at_position_from_slots(SLOT_POSITION_MAPPING["weapon"], inventory_slots)
	var previous_weapon_item = inventory.model.get_item_at_position_from_slots(SLOT_POSITION_MAPPING["weapon"], previous_inventory_slots)
	
	_unequip_item_effects(previous_weapon_item)
	_equip_item_effects(weapon_item)
	
func equip_item_from(slot: String, slot_data: InventorySlotData, source: InventoryModel) -> void:
	var position = get_position_by_slot(slot)
	var slot_at_position = inventory.model.get_slot_at_position(position)

	if slot_at_position:
		unequip_slot(slot)
	inventory.model.transfer_item_from(slot_data, source, position)
	
func equip_item(slot: String, item: Item) -> void:
	var position = get_position_by_slot(slot)
	var slot_at_position = inventory.model.get_slot_at_position(position)

	if slot_at_position:
		unequip_slot(slot)

	inventory.add_item(item, 1, position)

func unequip_slot(slot: String) -> void:
	var position = get_position_by_slot(slot)
	var slot_at_position = inventory.model.get_slot_at_position(position)
	if slot_at_position:
		parent_inventory.model.transfer_item_from(slot_at_position, inventory.model)

func _equip_item_effects(item: Item) -> void:
	if item:
		item.equipment_data.equip(stats)

func _unequip_item_effects(item: Item) -> void:
	if item:
		item.equipment_data.unequip(stats)

# TODO: Use enum for the slot
static func get_position_by_slot(slot: String) -> int:
	return SLOT_POSITION_MAPPING[slot]
	
static func get_slot_by_position(position: int) -> String:
	return POSITION_SLOT_MAPPING[position]
	
