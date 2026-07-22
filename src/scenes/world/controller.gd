extends Node
class_name WorldController

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("close_dialog"):
		print("close")
