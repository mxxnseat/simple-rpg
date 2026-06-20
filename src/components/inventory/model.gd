extends Node2D
class_name InventoryModel

signal inventory_updated(slots: Dictionary)

var slots: Dictionary[int, InventorySlotData] = {}
var CAPACITY = 32

func setup(capacity: int) -> void:
	CAPACITY = capacity
	
func get_items_count() -> int:
	return slots.size()

func add_item(item: Item, amount: int = 1) -> void:
	if not slots.has(item.id):
		if slots.size() >= CAPACITY:
			return
		var data = InventorySlotData.new()
		data.item = item
		data.position = slots.size()
		slots[item.id] = data
	slots[item.id].count += amount
	inventory_updated.emit(slots)

func remove_item(position: int, amount: int = 1) -> void:
	for id in slots:
		var slot_item = slots[id]
		if slot_item.position == position:
			slot_item.count -= amount
			if slot_item.count <= 0:
				slots.erase(id)
			inventory_updated.emit(slots)
			return
			
