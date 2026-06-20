extends Node

@export var item: Item

var pickup_scene = preload("res://src/components/pickup/pickup.tscn")
var parent = null

func _ready() -> void:
	parent = get_parent()
	parent.request_drop.connect(_on_request_drop)

func drop(position: Vector2):
	var pickup = pickup_scene.instantiate()
	pickup.item = item
	pickup.position = position
	get_tree().current_scene.add_child(pickup)
	queue_free()
	
func _on_request_drop(position: Vector2):
	drop(position)
