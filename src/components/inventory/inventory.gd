extends Node

signal inventory_updated(inventory: Dictionary)
signal request_drop(position: Vector2)

var drop_item_component = preload("../drop_item/drop_item.tscn")
var inventory: Dictionary = {}

const INVENTORY_CAPACITY = 32

func drop(position: int):
	var item = get_item_by_position(position)
	if not item:
		return
	var owner_position = get_parent().global_position
	
	remove_item(item.id)
	
	var drop_item = drop_item_component.instantiate()
	drop_item.item = item
	add_child(drop_item)
	emit_signal("request_drop", owner_position)
	
func add_item(item: Item, amount: int = 1):
	if inventory.size() == INVENTORY_CAPACITY:
		return
	if not has_item(item.id):
		inventory[item.id] = {
			"count": 0,
			"item": item,
			"position": inventory.size(),
		}
	inventory[item.id]["count"] += amount
	emit_signal("inventory_updated", inventory)
	
func remove_item_by_position(position: int):
	var item = get_item_by_position(position)
	if not item:
		return
	remove_item(item.item.id)
	
func get_item_by_position(position: int) -> Item:
	for id in inventory:
		var item = inventory[id]
		if item["position"] == position:
			return item.item
	return null
	
func remove_item(id: int, amount: int = 1):
	if not has_item(id):
		return
	inventory[id] = {
		"count": inventory[id]["count"]-amount,
		"item": inventory[id]["item"],
		"position": inventory.size()
	}
	
	if inventory[id]["count"] <= 0:
		inventory.erase(id)
		
	emit_signal("inventory_updated", inventory)

func has_item(id: int) -> bool:
	return inventory.has(id)
