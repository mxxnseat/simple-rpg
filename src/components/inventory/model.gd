extends Node2D
class_name InventoryModel

signal inventory_updated(state: InventoryState)

var state: InventoryState

func setup(i_state: InventoryState) -> void:
	state = i_state
	
	state.inventory_updated.connect(
		func(state: InventoryState): 
			inventory_updated.emit(state)
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

func add_item(item: Item, amount: int = 1) -> void:
	if amount <= 0:
		return
		
	var slots = state.slots
	if not has_item(item.id):
		if get_items_count() >= state.capacity:
			return
		var data = InventorySlotData.new()
		data.item = item
		data.position = get_items_count()
		slots[item.id] = data
	slots[item.id].count += amount
	state.set_slots(slots)

func remove_item(position: int, amount: int = 1) -> void:
	var slots = state.slots
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
	add_item(source_data.item, source_data.count)
