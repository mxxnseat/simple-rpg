class_name Stats
extends Node

var stats: Dictionary[String, Stat] = {}

func _ready() -> void:
	stats["damage"] = Stat.new(10.0)

func get_stat(name: String) -> Stat:
	return stats[name]
