extends Area2D
class_name PlayerInteractable

@onready var state: PlayerInteractableState = $state
@onready var model: PlayerInteractableModel = $model

func _ready() -> void:
	model.setup(state)

func _on_area_entered(area: Area2D) -> void:
	if Global.is_interactable(area):
		model.set_target(area)


func _on_area_exited(area: Area2D) -> void:
	if Global.is_interactable(area):
		model.set_target(null)
