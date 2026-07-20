extends Panel


func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	var slot_data: InventorySlotData = data["data"]
	if slot_data.item.equipment_data:
		print("bere")
		return true
	return false
