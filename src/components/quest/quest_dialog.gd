extends Panel
class_name QuestDialog

@onready var text_label: Label = $Label

func close() -> void:
	visible = false
	text_label.text = ""

func setup(quest_log: QuestLog) -> void:
	quest_log.quest_progressed.connect(_on_quest_progressed)
	
func _on_quest_progressed(quest: QuestInstance) -> void:
	if len(quest.current_conditions) == 0:
		return
	var condition := quest.current_conditions[0]
	visible = true
	text_label.text = condition.description
