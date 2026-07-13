extends Node2D
class_name CombatState

var is_attack_cooldown = false
var is_attacking = false
var targets: Dictionary[Node2D, bool] = {}
