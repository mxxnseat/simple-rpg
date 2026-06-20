extends Control

var slot_item_component = preload("./slot_item.tscn")
var inventory = null
var INVENTORY_CAPACITY = 0

func _ready() -> void:
	visible = false
	inventory = get_parent()
	
	inventory.inventory_updated.connect(_on_inventory_updated)
	
	$ItemGrid.columns = 8
	INVENTORY_CAPACITY = inventory.INVENTORY_CAPACITY
	
	for i in INVENTORY_CAPACITY:
		var slot = create_slot(i)
		$ItemGrid.add_child(slot)
	
func _input(event):
	if event.is_action_pressed("inventory"):
		visible = !visible
		
func refresh(inventory: Dictionary):
	var slots = $ItemGrid.get_children()
	
	for i in INVENTORY_CAPACITY:
		var slot = slots[i]
		var slot_item = slot.get_node("SlotItem")
		slot_item.texture = null
		
	for item_id in inventory:
		var item = inventory[item_id]
		
		var slot = slots[item.position]
		var slot_item = slot.get_node("SlotItem")
		slot_item.texture = item.item.icon
		
func create_slot(index: int) -> Panel:
	var panel_rect = get_size()
	var slot = Panel.new()
	var slot_size = (panel_rect.x)/8
	slot.custom_minimum_size = Vector2(slot_size, slot_size)
	
	var style = StyleBoxFlat.new()
	style.bg_color = Color(0.2, 0.2, 0.2)
	style.border_color = Color(0.4, 0.4, 0.4)
	style.set_border_width_all(slot_size/16)
	style.set_corner_radius_all(slot_size/16)
	slot.add_theme_stylebox_override("panel", style)
	
	var slot_item = create_slot_item(index)
	slot.add_child(slot_item)
	
	return slot
	
func create_slot_item(position: int) -> TextureRect:
	var panel_rect = get_size()
	var slot = slot_item_component.instantiate()
	slot.item_position = position
	slot.double_clicked.connect(_on_slot_double_clicked)
	slot.name = "SlotItem"
	var slot_size = (panel_rect.x)/8
	slot.set_anchors_preset(Control.PRESET_FULL_RECT)
	return slot
	
func _on_inventory_updated(inventory: Dictionary):
	refresh(inventory)
	
func _on_slot_double_clicked(position:int):
	inventory.drop(position)
