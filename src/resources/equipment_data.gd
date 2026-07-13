extends Resource
class_name EquipmentData

@export var type: GearTypes.EquipSlot
@export var modifiers: Array[EquipmentDataModifer] = []

func equip(stats: Stats) -> void:
	for modifier in modifiers:
		stats.get_stat(modifier.stat) \
			.add_modifier(
				StatModifier.new(modifier.type, modifier.value, self)
			)

func unequip(stats: Stats) -> void:
	for modifier in modifiers:
		stats.get_stat(modifier.stat) \
			.remove_modifiers_from_source(self)
