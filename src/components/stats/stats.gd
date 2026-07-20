class_name Stats
extends Node

var stats: Dictionary[String, Stat] = {}

func _ready() -> void:
	stats[Global.STATS_NAMES["DAMAGE"]] = Stat.new(10.0)
	stats[Global.STATS_NAMES["MAX_HP"]] = Stat.new(10.0)
	stats[Global.STATS_NAMES["REGENERATION"]] = Stat.new(10.0)

func set_max_hp(value: float):
	_set_stat(Global.STATS_NAMES["MAX_HP"], value)
	
func set_damage(value: float):
	_set_stat(Global.STATS_NAMES["DAMAGE"], value)

func _set_stat(name: String, value: float) -> void:
	stats[name] = Stat.new(value)

func get_stat(name: String) -> Stat:
	return stats[name]
