class_name Stats
extends Node

var stats: Dictionary[String, Stat] = {}

@export var default_damage: float = 10.0
@export var default_max_hp: float = 10.0
@export var default_regeneration: float = 10.0

func _ready() -> void:
	stats[Global.STATS_NAMES["DAMAGE"]] = Stat.new(default_damage)
	stats[Global.STATS_NAMES["MAX_HP"]] = Stat.new(default_max_hp)
	stats[Global.STATS_NAMES["REGENERATION"]] = Stat.new(default_regeneration)

func set_max_hp(value: float):
	_set_stat(Global.STATS_NAMES["MAX_HP"], value)
	
func set_damage(value: float):
	_set_stat(Global.STATS_NAMES["DAMAGE"], value)

func _set_stat(name: String, value: float) -> void:
	stats[name] = Stat.new(value)

func get_stat(name: String) -> Stat:
	return stats[name]
