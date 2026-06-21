extends Panel
class_name SlotItem

signal double_clicked(item_id: int)

@onready var controller: SlotItemController = $Controller
@onready var view = $View

var slot_data: InventorySlotData

func setup(p_slot_data: InventorySlotData):
	slot_data = p_slot_data
	
	view.texture = slot_data.item.icon

func _on_double_clicked():
	double_clicked.emit(slot_data.item.id)
