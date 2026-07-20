extends HBoxContainer
class_name GearViewStatLabel

@export var stat_label_text: String = ''

@onready var stat_label: Label = $StatLabel
@onready var stat_value: Label = $StatValue

func _ready() -> void:
	stat_label.text = stat_label_text
	
func set_value(value) -> void:
	stat_value.text = str(value)
