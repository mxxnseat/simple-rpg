# signal interacted
extends Interactable
class_name Chest

signal inventory_updated(state: InventoryState)

@onready var view: ChestView = $view
@onready var inventory: Inventory = $Inventory

func _ready():
	super._ready()
	inventory.setup(10)
	interacted.connect(_on_interacted)
	inventory.model.inventory_updated.connect(_on_inventory_updated)
	
func _on_interacted(result: bool) -> void:
	if result:
		inventory.toggle_opened()
	else:
		close_inventory()

func _on_inventory_updated(state: InventoryState):
	view.toggle_visibility(state.is_opened)
	inventory_updated.emit(state)

func open_inventory():
	inventory.open()
	
func close_inventory():
	inventory.close()
