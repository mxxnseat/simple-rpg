extends Area2D
class_name PlayerPickupItems

@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var model: PlayerPickupItemsModel = $Model
@onready var state: PlayerPickupItemsState = $State

func setup(radius: int = 10):
	var circle = CircleShape2D.new()
	circle.radius = radius
	collision_shape.shape = circle
	
	model.setup(state)

func _on_area_entered(area: Pickup) -> void:
	if Global.is_pickuable_item(area):
		model.add_item_in_range(area)

func _on_area_exited(area: Pickup) -> void:
	if Global.is_pickuable_item(area):
		model.remove_item_from_range(area)
