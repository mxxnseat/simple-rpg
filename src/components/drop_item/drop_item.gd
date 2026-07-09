extends Node
class_name DropItem

var inventory_model: InventoryModel

func setup(p_inventory: InventoryModel):
	inventory_model = p_inventory
	
func drop(where: Vector2, position: int = -1, count: int = -1) -> Array[DropItemResource]:
	var items_to_drop: Array[DropItemResource] = []
	var slots: Dictionary[int, InventorySlotData] = inventory_model.get_slots()

	for id in slots:
		var slot_data: InventorySlotData = slots[id]

		if position != -1 and slot_data.position != position:
			continue

		var drop_count: int = count if count != -1 else slot_data.count

		for i in drop_count:
			var drop_item := DropItemResource.new()
			drop_item.item = slot_data.item
			drop_item.position = where
			items_to_drop.append(drop_item)

	if position == -1:
		inventory_model.clear()
	else:
		inventory_model.remove_item(position, -1) # yes that's not good because who fucking knows what -1 actually is(me)

	return items_to_drop
