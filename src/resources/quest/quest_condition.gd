extends Resource
class_name QuestCondition

signal completed

enum QuestType { KillEnemy, PressAction, ItemExistInInventory }

@export_multiline var description: String
@export var type: QuestType
