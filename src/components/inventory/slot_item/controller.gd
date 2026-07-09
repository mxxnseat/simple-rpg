extends Node2D
class_name SlotItemController

signal double_clicked

var parent: SlotItem = null

func _ready() -> void:
	parent = get_parent()

func _input(event: InputEvent)-> void:
	double_click(event)
	
func is_clicked_inside(click_position: Vector2) -> bool:
	return parent.get_global_rect().has_point(click_position)

func double_click(event: InputEvent) -> void:
	if event is InputEventMouseButton \
		and event.button_index == MOUSE_BUTTON_LEFT \
		and event.double_click:
		if is_clicked_inside(event.position):
			double_clicked.emit()
