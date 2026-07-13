extends Node2D
class_name InventoryModel

signal inventory_updated(state: IInventoryState, previous_state: IInventoryState)

var state: InventoryState

func setup(i_state: InventoryState) -> void:
	state = i_state
	
	state.inventory_updated.connect(
		func(state: IInventoryState, previous_state: IInventoryState): 
			inventory_updated.emit(state, previous_state)
	)
	
func get_slots() -> Dictionary[int, InventorySlotData]:
	return state.slots
	
func get_items_count() -> int:
	return state.slots.size()
	
func toggle_opened() -> void:
	state.set_is_opened(!state.is_opened)
	
func open() -> void:
	state.set_is_opened(true)
	
func close() -> void:
	state.set_is_opened(false)

func clear():
	state.slots.clear()
	inventory_updated.emit(state)
	
func has_item(id: int) -> bool:
	return state.slots.has(id)
	
func has_item_at_position(position: int) -> bool:
	if get_item_at_position(position):
		return true
	return false
	
func get_item_at_position_from_slots(position:int, slots: Dictionary[int, InventorySlotData]) -> Item:
	var slot = get_slot_at_position_from_slots(position, slots)
	if slot:
		return slot.item
	return null
	
func get_item_at_position(position: int) -> Item:
	var slot = get_slot_at_position(position)
	if slot:
		return slot.item
	return null
	
func get_slot_at_position_from_slots(position:int, slots: Dictionary[int, InventorySlotData]) -> InventorySlotData:
	for id in slots:
		var state_slot = slots[id]
		if state_slot.position == position:
			return state_slot
	return null
	
func get_slot_at_position(position: int) -> InventorySlotData:
	for id in state.slots:
		var state_slot = state.slots[id]
		if state_slot.position == position:
			return state_slot
	return null
	
func add_item(item: Item, amount: int = 1, position: int = -1) -> void:
	if amount <= 0:
		return
	var slots = state.slots.duplicate(true)
	if not has_item(item.id):
		if get_items_count() >= state.capacity:
			return
		var data = InventorySlotData.new()
		data.item = item
		data.position = get_items_count() if position == -1 else position
		slots[item.id] = data
	slots[item.id].count += amount
	state.set_slots(slots)

func remove_item(position: int, amount: int = 1) -> void:
	var slots = state.slots.duplicate(true)
	
	for id in slots:
		var slot_item = slots[id]
		if slot_item.position == position:
			slot_item.count -= amount if amount != -1 else slot_item.count
			if slot_item.count <= 0:
				slots.erase(id)
			break
	state.set_slots(slots)

func transfer_item_from(source_data: InventorySlotData, source: InventoryModel, target_position = -1):
	source.remove_item(source_data.position, source_data.count)
	add_item(source_data.item, source_data.count, target_position)
