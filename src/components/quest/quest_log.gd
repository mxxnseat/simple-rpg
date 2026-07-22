extends Node
class_name QuestLog

signal quest_activated(quest: QuestInstance)
signal quest_completed(quest: QuestInstance)
signal quest_progressed(quest: QuestInstance)

var active_quests: Array[QuestInstance] = []

func notify_enemy_died(enemy: Enemy) -> void:
	for quest in active_quests:
		quest.enemy_killed(enemy)
	
func notify_player_action_pressed(action: Global.PLAYER_ACTION_TYPES) -> void:
	for quest in active_quests:
		quest.action_pressed(action)
		
func notify_inventory_updated(slots: Dictionary[int, InventorySlotData]) -> void:
	for quest in active_quests:
		quest.inventory_updated(slots)

func activate_quest(quest: Quest) -> void:
	var quest_instance := QuestInstance.new(quest)
	active_quests.append(quest_instance)
	
	quest_activated.emit(quest_instance)
	quest_progressed.emit(quest_instance)
	quest_instance.progressed.connect(_on_quest_progressed)
	quest_instance.completed.connect(_on_quest_completed)


func _on_quest_completed(quest: QuestInstance) -> void:
	active_quests.erase(quest)
	quest_completed.emit(quest)
	
func _on_quest_progressed(quest: QuestInstance) -> void:
	quest_progressed.emit(quest)
