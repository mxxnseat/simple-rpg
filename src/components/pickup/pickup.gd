extends Node
class_name Pickup

@onready var model: PickupModel = $Model
@onready var state: PickupState = $State
@onready var view: TextureRect = $ViewWrapper/Icon
@export var item: Item

func _ready():
	view.texture = item.icon
	model.setup(state)

func pickup() -> Item:
	model.pickup()
	queue_free()
	return item
