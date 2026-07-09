extends Panel
class_name SlotItem

@onready var controller: SlotItemController = $Controller
@onready var view = $View

var inventory: InventoryModel
var slot_data: InventorySlotData

func _get_drag_data(at_position: Vector2) -> Variant:
	if slot_data == null:
		return null

	var preview := TextureRect.new()
	preview.texture = slot_data.item.icon
	preview.custom_minimum_size = Vector2(48, 48)
	preview.modulate.a = 1.0
	set_drag_preview(preview)
	
	var transfer_slot_data = InventorySlotData.new()
	transfer_slot_data.count = slot_data.count
	transfer_slot_data.position = slot_data.position
	transfer_slot_data.item = slot_data.item

	return {
		"inventory": inventory,
		"data": transfer_slot_data
	}

func setup(p_slot_data: InventorySlotData, p_inventory: InventoryModel):
	slot_data = p_slot_data
	inventory = p_inventory
	view.texture = slot_data.item.icon
