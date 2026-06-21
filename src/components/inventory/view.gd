extends Panel
class_name InventoryView

var state: InventoryState

func setup(i_state: InventoryState):
	state = i_state
	visible = true
	state.inventory_updated.connect(_on_inventory_updated)

func _on_inventory_updated(state: InventoryState):
	visible = state.is_opened
	print("updated")
