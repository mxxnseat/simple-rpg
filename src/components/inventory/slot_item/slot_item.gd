extends Control
class_name SlotItem

signal double_clicked(item_id: int)

#@onready var controller: SlotItemController = $Controller
#@onready var view: SlotItemView = $View

var slot_data: InventorySlotData

func setup(p_slot_data: InventorySlotData):
	slot_data = p_slot_data
	#view.setup(slot_data)
	#controller.setup(self)

func _on_double_clicked():
	double_clicked.emit(slot_data.item.id)
