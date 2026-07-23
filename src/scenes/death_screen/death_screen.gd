extends Control

@onready var restart_button: Button = $CenterContainer/VBoxContainer/RestartButton

func _ready() -> void:
	restart_button.pressed.connect(_on_restart_pressed)

func _on_restart_pressed() -> void:
	get_tree().change_scene_to_file("res://src/scenes/world/world.tscn")
