extends Node
class_name DropItem

var inventory_model: InventoryModel

func setup(p_inventory: InventoryModel):
	inventory_model = p_inventory

func drop(position: Vector2) -> Array[DropItemResource]:
	var items_to_drop: Array[DropItemResource] = []
	var slots: Dictionary[int, InventorySlotData] = inventory_model.get_slots()
	for id in slots:
		var count = slots[id].count
		var inventory_item = slots[id].item
		for i in count:
			var drop_item = DropItemResource.new()
			drop_item.item = inventory_item
			drop_item.position = position
			items_to_drop.append(drop_item)
	inventory_model.clear()
	return items_to_drop
