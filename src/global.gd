extends Node

func is_player(body: Node) -> bool:
	return body.is_in_group("player")
	
func is_enemy(body: Node) -> bool:
	return body.is_in_group("enemy")
	
func is_pickuable_item(body: Node) -> bool:
	return body.is_in_group("pickupable_item")
