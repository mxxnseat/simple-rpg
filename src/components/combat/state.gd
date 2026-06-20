extends Node2D
class_name CombatState

# TODO: rewrite it on the state machine once have time

@export var damage: int
var is_attack_cooldown = false
var is_attacking = false
var targets: Dictionary[Node2D, bool] = {}
