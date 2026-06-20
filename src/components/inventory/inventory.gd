extends Control
class_name Inventory

@onready var model: InventoryModel = $Model
#@onready var view: InventoryView = $View

func setup(capacity: int = 32):
	model.setup(capacity)
	#view.setup(model)

func add_item(item: Item, amount: int = 1):
	model.add_item(item, amount)

func remove_item(position: int, amount: int = 1):
	model.remove_item(position, amount)
