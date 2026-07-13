extends Node2D
class_name Combat

@onready var model: CombatModel = $Model
@onready var state: CombatState = $State

@export var target_group: String

func setup(stats: Stats):
	model.setup(state, stats)

func _on_attack_range_body_entered(body: Node2D) -> void:
	if body.is_in_group(target_group):
		model.add_target(body)

func _on_attack_range_body_exited(body: Node2D) -> void:
	if body.is_in_group(target_group):
		model.remove_target(body)
