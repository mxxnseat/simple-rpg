extends Resource
class_name IInventoryState

@export var is_opened = false
@export var slots: Dictionary[int, InventorySlotData] = {}
@export var capacity: int = 0
