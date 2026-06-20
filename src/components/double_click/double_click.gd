extends Node

signal double_clicked

func _ready() -> void:
	get_parent().gui_input.connect(_on_gui_input)

func _on_gui_input(event: InputEvent) -> void:
	if (event is InputEventMouseButton 
		and event.button_index == MOUSE_BUTTON_LEFT
		and event.double_click
	):
		emit_signal("double_clicked")
