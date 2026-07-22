extends RefCounted
class_name QuestInstance

signal completed(quest: QuestInstance)
signal progressed(quest: QuestInstance)

var quest: Quest
var current_conditions: Array[QuestCondition]

func _init(quest: Quest):
	self.quest = quest
	current_conditions = quest.conditions.duplicate(true)
	
func enemy_killed(enemy: Enemy) -> void:
	var condition = current_conditions[0]
	if condition.type != QuestCondition.QuestType.KillEnemy:
		return
	var kill_enemy_condition: KillEnemyQuestCondition = condition
	if kill_enemy_condition.enemy_id != enemy.enemy_id:
		return
		
	if kill_enemy_condition.evaluate():
		current_conditions.erase(condition)
		progressed.emit(self)
			
	if is_completed():
		completed.emit(self)
		
func action_pressed(action: Global.PLAYER_ACTION_TYPES) -> void:
	var condition = current_conditions[0]
	if condition.type != QuestCondition.QuestType.PressAction:
		return
	var press_action_condition: PressActionQuestCondition = condition
	if press_action_condition.evaluate(action):
		current_conditions.erase(condition)
		progressed.emit(self)
	
	if is_completed():
		completed.emit(self)
		
func inventory_updated(slots: Dictionary[int, InventorySlotData]) -> void:
	var condition = current_conditions[0]
	if condition.type != QuestCondition.QuestType.ItemExistInInventory:
		return
	var inventory_item_existence_condition: InventoryItemExistenceQuestCondition = condition
	if inventory_item_existence_condition.evaluate(slots):
		current_conditions.erase(condition)
		progressed.emit(self)
	
	if is_completed():
		completed.emit(self)

func is_completed() -> bool:
	return len(current_conditions) == 0
