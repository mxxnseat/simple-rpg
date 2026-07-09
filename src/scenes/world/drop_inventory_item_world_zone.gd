extends Control
class_name WorldDropZone

var player: Player = null

func setup(p: Player):
	player = p

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return true
	
func _drop_data(at_position: Vector2, data: Variant) -> void:
	player.drop_item(data["data"])
