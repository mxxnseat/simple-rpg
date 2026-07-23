extends Control

@onready var mute_check_button: CheckButton = $CenterContainer/VBoxContainer/MuteCheckButton
@onready var back_button: Button = $CenterContainer/VBoxContainer/BackButton

func _ready() -> void:
	mute_check_button.button_pressed = Sound.muted
	mute_check_button.toggled.connect(_on_mute_toggled)
	back_button.pressed.connect(_on_back_pressed)

func _on_mute_toggled(toggled_on: bool) -> void:
	Sound.set_muted(toggled_on)

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://src/scenes/start_menu/start_menu.tscn")
