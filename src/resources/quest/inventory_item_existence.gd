extends QuestCondition
class_name InventoryItemExistenceQuestCondition

@export var expected_item: Item
@export var count: int = 1

func _init():
	type = QuestType.ItemExistInInventory

func evaluate(slots: Dictionary[int, InventorySlotData]) -> bool:
	var current_count: int = 0
	for slot_id in slots:
		if slot_id != expected_item.id:
			continue
		current_count += slots[slot_id].count
	
	return current_count >= count
