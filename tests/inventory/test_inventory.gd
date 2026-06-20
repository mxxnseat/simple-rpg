extends GutTest

var inventory_scene = preload("res://src/components/inventory/inventory.tscn")
var key_item: Item = load("res://src/items/key.tres")
var inventory: Inventory

func before_each():
	inventory = inventory_scene.instantiate()
	add_child_autofree(inventory)
	inventory.setup(32)
	
func after_each():
	inventory.free()
	
func test_add_item_to_the_inventory():
	inventory.add_item(key_item)
	
	assert_eq(
		inventory.model.get_items_count(), 
		1,
		"item should be added to the inventory"
	)

func test_remove_item_from_the_inventory():
	inventory.add_item(key_item)
	inventory.remove_item(0)
	
	assert_eq(
		inventory.model.get_items_count(), 
		0,
		"item should be removed from the inventory"
	)

func test_remove_non_existed_item_from_the_inventory():
	inventory.remove_item(0)
	
	assert_eq(
		inventory.model.get_items_count(), 
		0, 
		"size should be 0 when try to delete non existed item"
	)
