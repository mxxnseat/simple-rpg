extends Button
class_name UIButton

@export var hover_sound: AudioStream = preload("res://sfx/ui-hover.mp3")

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)

func _on_mouse_entered() -> void:
	Sound.play(hover_sound, 0.0, Sound.UI_BUS)
