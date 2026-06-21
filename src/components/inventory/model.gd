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
	
func get_items_count() -> int:
	return state.slots.size()
	
func toggle_opened() -> void:
	state.set_is_opened(!state.is_opened)

func add_item(item: Item, amount: int = 1) -> void:
	if not state.slots.has(item.id):
		if get_items_count() >= state.capacity:
			return
		var data = InventorySlotData.new()
		data.item = item
		data.position = get_items_count()
		state.slots[item.id] = data
	state.slots[item.id].count += amount
	# actually not very good to publish the same signal
	# from different sources, rethink it in future please
	inventory_updated.emit(state)

func remove_item(position: int, amount: int = 1) -> void:
	for id in state.slots:
		var slot_item = state.slots[id]
		if slot_item.position == position:
			slot_item.count -= amount
			if slot_item.count <= 0:
				state.slots.erase(id)
				inventory_updated.emit(state)
			return
			
