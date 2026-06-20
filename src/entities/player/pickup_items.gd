extends Area2D
class_name PlayerPickupItems

var items_in_range: Array[Pickup] = []

func add_item(item: Pickup):
	items_in_range.append(item)
	
func remove_item():
	items_in_range.pop_front()


func _on_body_entered(body: Node2D) -> void:
	if Global.is_pickuable_item(body):
		pass # Replace with function body.


func _on_body_exited(body: Node2D) -> void:
	if Global.is_pickuable_item(body):
		pass # Replace with function body.
