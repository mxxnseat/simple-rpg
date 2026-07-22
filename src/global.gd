extends Node

var collision_layer: int = 1 << 2 # Cooked
var interact_radius: int = 15
var slot_size: int = 64

var STATS_NAMES: Dictionary[String, String] = {
	"MAX_HP": "max_hp",
	"DAMAGE": "damage",
	"REGENERATION": "regeneration"
}

enum PLAYER_ACTION_TYPES { INTERACT, PICKUP, ATTACK, INVENTORY, MOVE, CLOSE_DIALOG }

func player_action_to_string(action: PLAYER_ACTION_TYPES) -> String:
	if action == PLAYER_ACTION_TYPES.INTERACT:
		return "interact"
	if action == PLAYER_ACTION_TYPES.PICKUP:
		return "pickup"
	if action == PLAYER_ACTION_TYPES.ATTACK:
		return "attack"
	if action == PLAYER_ACTION_TYPES.INVENTORY:
		return "inventory"
	if action == PLAYER_ACTION_TYPES.MOVE:
		return "move"
	return "unknown"

func is_player(body: Node) -> bool:
	return body.is_in_group("player")
	
func is_enemy(body: Node) -> bool:
	return body.is_in_group("enemy")
	
func is_pickuable_item(body: Node) -> bool:
	return body.is_in_group("pickupable_item")

func is_interactable(body: Node) -> bool:
	return body.is_in_group("interactable")
	
