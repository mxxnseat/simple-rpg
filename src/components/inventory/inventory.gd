extends Control
class_name Inventory

@onready var model: InventoryModel = $Model
@onready var state: InventoryState = $State

func setup(capacity: int = 32):
	state.setup(capacity)
	model.setup(state)

func has_item(id: int) -> bool:
	return model.has_item(id)
	
func has_item_at_position(position: int) -> bool:
	return model.has_item_at_position(position)
	
func get_item_at_position(position: int) -> Item:
	return model.get_item_at_position(position)

func add_item(item: Item, amount: int = 1, position: int = -1):
	model.add_item(item, amount, position)

func remove_item(position: int, amount: int = 1):
	model.remove_item(position, amount)

func toggle_opened():
	model.toggle_opened()

func open():
	model.open()
	
func close():
	model.close()
