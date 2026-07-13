extends StaticBody2D
class_name Interactable

signal interacted(result: bool)

@export var open_with_item_id: int = -1

func _ready():
	add_to_group("interactable")
	var area: InteractableArea = InteractableArea.new()
	area.interacted.connect(interact)
	add_child(area)

func interact(inventory: InventoryModel):
	if not _can_be_interacted(inventory):
		interacted.emit(false)
	else:
		interacted.emit(true)
	
func _can_be_interacted(inventory: InventoryModel) -> bool:
	print(inventory.has_item(open_with_item_id))
	if open_with_item_id == -1:
		return true
	return inventory.has_item(open_with_item_id)
