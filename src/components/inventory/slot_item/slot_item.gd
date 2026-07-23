extends Panel
class_name SlotItem

signal dropped_data(at_position: Vector2, data: Variant)

var slot_background = preload("res://art/inventory/inventiory_slot.png")

@onready var controller: SlotItemController = $Controller
@onready var view = $View
@onready var background = $Background

@export var empty_slot_override: Texture2D

var inventory: InventoryModel
var slot_data: InventorySlotData

func create_preview() -> TextureRect:
	var preview := TextureRect.new()
	preview.texture = slot_data.item.icon
	preview.custom_minimum_size = Vector2(48, 48)
	preview.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	preview.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	preview.modulate.a = 1.0
	return preview

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return true
	
func _drop_data(at_position: Vector2, data: Variant) -> void:
	dropped_data.emit(at_position, data)

func _get_drag_data(at_position: Vector2) -> Variant:
	if slot_data == null:
		return null
	
	set_drag_preview(create_preview())
	
	var transfer_slot_data = InventorySlotData.new()
	transfer_slot_data.count = slot_data.count
	transfer_slot_data.position = slot_data.position
	transfer_slot_data.item = slot_data.item

	return {
		"inventory": inventory,
		"data": transfer_slot_data
	}

func setup(p_inventory: InventoryModel):
	inventory = p_inventory
	
func update_view(p_slot_data: InventorySlotData):
	slot_data = p_slot_data
	if not p_slot_data:
		view.texture = null
		background.texture = empty_slot_override if empty_slot_override else slot_background
	else:
		view.texture = slot_data.item.icon
		background.texture = slot_background
