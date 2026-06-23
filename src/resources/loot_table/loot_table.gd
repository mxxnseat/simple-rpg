extends Resource
class_name LootTable

@export var entries: Array[LootEntry] = []

func roll() -> Array[Item]:
	var result: Array[Item] = []
	for entry in entries:
		if randf() <= entry.chance:
			result.append(entry.item)
	return result
