extends QuestCondition
class_name KillEnemyQuestCondition

@export var count: int = 1
@export var enemy_id: int = -1

var current_progress: int = 0

func _init() -> void:
	type = QuestType.KillEnemy

func evaluate() -> bool:
	current_progress += 1
	
	return count == current_progress
