extends Panel
class_name GearStatsTextWrapper

var stats: Stats

@onready var attack_label: GearViewStatLabel = $AttackStat

func setup(p_stats: Stats) -> void:
	stats = p_stats
	
	stats.get_stat(Global.STATS_NAMES["DAMAGE"]).changed.connect(_on_stats_damage_changed)
	_on_stats_damage_changed(stats.get_stat(Global.STATS_NAMES["DAMAGE"]).get_value())
	
func _on_stats_damage_changed(value: float) -> void:
	attack_label.set_value(value)
