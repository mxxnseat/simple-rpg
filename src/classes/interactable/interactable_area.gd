extends Area2D
class_name InteractableArea

signal interacted

func _ready() -> void:
	add_to_group("interactable")
	monitorable = true
	collision_layer = Global.collision_layer
	collision_mask = Global.collision_layer
	
	var collision_shape = CollisionShape2D.new()
	var collision_circle = CircleShape2D.new()
	collision_circle.radius = Global.interact_radius
	
	collision_shape.shape = collision_circle
	add_child(collision_shape)
	
func interact():
	interacted.emit()
