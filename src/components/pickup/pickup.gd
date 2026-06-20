extends Node


@export var item: Item
var can_be_picked_up = false
var picked_up = false

func _ready():
	$Sprite2D.texture = item.icon
	
func pickup() -> bool:
	if not allow_to_pickup():
		return false
	picked_up = true
	can_be_picked_up = false
	queue_free()
	return true

func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player"):
		return
	can_be_picked_up = true

func _on_body_exited(body: Node2D) -> void:
	if not body.is_in_group("player"):
		return
	can_be_picked_up = false
	
func allow_to_pickup():
	return not picked_up and can_be_picked_up;
