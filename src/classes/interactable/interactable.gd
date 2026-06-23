extends StaticBody2D
class_name Interactable

signal interacted

func _ready():
	add_to_group("interactable")
	var area: InteractableArea = InteractableArea.new()
	area.interacted.connect(interact)
	add_child(area)
	
	
func interact():
	interacted.emit()
