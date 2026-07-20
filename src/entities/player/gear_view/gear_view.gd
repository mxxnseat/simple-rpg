extends PanelContainer
class_name GearView

var gear: Gear
var gear_inventory_model: InventoryModel

@onready var weapon_slot: SlotItem = $HBoxContainer/SlotsWrapper/WeaponSlot
@onready var stats_text_wrapper: GearStatsTextWrapper = $HBoxContainer/StatsTextWrapper

func setup(p_gear: Gear):
	gear = p_gear
	gear_inventory_model = gear.inventory.model
	gear.inventory.model.inventory_updated.connect(_on_inventory_updated)
	
	weapon_slot.setup(gear.inventory.model)
	stats_text_wrapper.setup(gear.stats)
	
	refresh(gear.inventory.model.state.get_current_state())

func _on_inventory_updated(state: IInventoryState, previous_state: IInventoryState):
	refresh(state)
	
func refresh(state: IInventoryState):
	visible = state.is_opened
	
	for position in state.capacity:
		if position == 0:
			var slot_data: InventorySlotData = gear_inventory_model \
				.get_slot_at_position(position)
			weapon_slot.update_view(slot_data)
	
func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	var slot_data: InventorySlotData = data["data"]
	if slot_data.item.equipment_data:
		return true
	return false

func _drop_data(at_position: Vector2, data: Variant) -> void:
	var source_inventory: InventoryModel = data["inventory"]
	var slot_data: InventorySlotData = data["data"]

	if source_inventory == gear_inventory_model:
		return
		
	gear.equip_item_from("weapon", slot_data, source_inventory)
