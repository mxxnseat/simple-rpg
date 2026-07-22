extends QuestCondition
class_name PressActionQuestCondition

@export var action: Global.PLAYER_ACTION_TYPES

func _init():
	type = QuestType.PressAction

func evaluate(action_to_evaluate: Global.PLAYER_ACTION_TYPES) -> bool:
	return action_to_evaluate == action
