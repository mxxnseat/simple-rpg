extends Node

var collision_layer: int = 1 << 2 # Cooked
var interact_radius: int = 15
var slot_size: int = 64

func is_player(body: Node) -> bool:
	return body.is_in_group("player")
	
func is_enemy(body: Node) -> bool:
	return body.is_in_group("enemy")
	
func is_pickuable_item(body: Node) -> bool:
	return body.is_in_group("pickupable_item")

func is_interactable(body: Node) -> bool:
	return body.is_in_group("interactable")
