extends Node
class_name Pickup

@onready var model: PickupModel = $Model
@onready var state: PickupState = $State
@onready var view: Sprite2D = $Sprite2D
@export var item: Item

func _ready():
	view.texture = item.icon
	model.setup(state)

func pickup() -> Item:
	model.pickup()
	queue_free()
	return item
