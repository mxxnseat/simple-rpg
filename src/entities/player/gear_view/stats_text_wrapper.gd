extends Panel
class_name GearStatsTextWrapper

var stats: Stats

@onready var attack_label: GearViewStatLabel = $AttackStat
@onready var defence_label: GearViewStatLabel = $DefenceStat

func setup(p_stats: Stats) -> void:
	stats = p_stats
	
	var damage_stat_name := Global.STATS_NAMES["DAMAGE"]
	var defence_stat_name := Global.STATS_NAMES["DEFENCE"]
	
	
	stats.get_stat(damage_stat_name).changed.connect(_on_stats_damage_changed)
	_on_stats_damage_changed(stats.get_stat(damage_stat_name).get_value())
	
	stats.get_stat(defence_stat_name).changed.connect(_on_stats_defence_changed)
	_on_stats_defence_changed(stats.get_stat(defence_stat_name).get_value())
	
func _on_stats_damage_changed(value: float) -> void:
	attack_label.set_value(value)
	
func _on_stats_defence_changed(value: float) -> void:
	defence_label.set_value(value)
