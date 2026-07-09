extends Panel
class_name InventoryView

@onready var grid: GridContainer = $GridContainer
@onready var text: Label = $text

var model: InventoryModel
var slot_item_scene = preload("res://src/components/inventory/slot_item/slot_item.tscn")
var slot_data = preload("res://src/resources/inventory_slot_data.gd")

func setup(inventory_model: InventoryModel):
	model = inventory_model
	model.inventory_updated.connect(_on_inventory_updated)
	refresh(model.state)
	
func set_label_text(value: String = ""):
	if not value:
		value = "Inventory"
	text.text = value
	
func _on_inventory_updated(state: InventoryState):
	refresh(state)
	
func refresh(state: InventoryState):
	visible = state.is_opened
	
	var grid_childrens = grid.get_children()
	for grid_child in grid_childrens:
		grid_child.queue_free()
		
	for item_id in state.slots:
		var slot_data: InventorySlotData = state.slots[item_id]
		var slot: SlotItem = slot_item_scene.instantiate()
		grid.add_child(slot)
		slot.setup(slot_data, model)

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return true

func _drop_data(at_position: Vector2, data: Variant) -> void:
	var source_inventory: InventoryModel = data["inventory"]
	var slot_data: InventorySlotData = data["data"]

	if source_inventory == model:
		return

	model.transfer_item_from(slot_data, source_inventory)
