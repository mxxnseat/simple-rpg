extends Panel
class_name InventoryView

@onready var grid: GridContainer = $GridContainer

var model: InventoryModel
var slot_item_scene = preload("res://src/components/inventory/slot_item/slot_item.tscn")
var slot_data = preload("res://src/resources/inventory_slot_data.gd")

func setup(inventory_model: InventoryModel):
	model = inventory_model
	model.inventory_updated.connect(_on_inventory_updated)
	refresh(model.state)
	
func _on_inventory_updated(state: InventoryState):
	refresh(state)
	
func refresh(state: InventoryState):
	visible = state.is_opened
	
	# i really fucked up with inventory i wanna move forward
	# so i keep this not optimized, but actually maybe it's okay
	var grid_childrens = grid.get_children()
	for grid_child in grid_childrens:
		grid_child.queue_free()
		
	for item_id in state.slots:
		var slot_data: InventorySlotData = state.slots[item_id]
		var slot: SlotItem = slot_item_scene.instantiate()
		grid.add_child(slot)
		slot.setup(slot_data)
