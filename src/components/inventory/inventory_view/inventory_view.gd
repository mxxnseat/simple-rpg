extends Panel
class_name InventoryView

@onready var grid: GridContainer = $GridContainer
@onready var text: Label = $text

var model: InventoryModel
var slot_item_scene = preload("res://src/components/inventory/slot_item/slot_item.tscn")
var slot_data = preload("res://src/resources/inventory_slot_data.gd")

var slots: Array[SlotItem] = []

func setup(inventory_model: InventoryModel):
	model = inventory_model
	model.inventory_updated.connect(_on_inventory_updated)
	_instantiate_slots()
	refresh(model.state.get_current_state())
	
func set_label_text(value: String = ""):
	if not value:
		value = "Inventory"
	text.text = value
	
func _on_inventory_updated(state: IInventoryState, previous_state: IInventoryState):
	refresh(state)
	
func _instantiate_slots() -> void:
	for i in model.state.capacity:
		var slot: SlotItem = slot_item_scene.instantiate()
		slots.append(slot)
		grid.add_child(slot)
		slot.setup(model)
	
func refresh(state: IInventoryState):
	visible = state.is_opened
	
	for position in state.capacity:
		var item = model.get_slot_at_position(position)
		slots[position].update_view(item)

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return true

func _drop_data(at_position: Vector2, data: Variant) -> void:
	var source_inventory: InventoryModel = data["inventory"]
	var slot_data: InventorySlotData = data["data"]

	if source_inventory == model:
		return

	model.transfer_item_from(slot_data, source_inventory)
