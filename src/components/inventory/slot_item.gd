extends TextureRect

signal double_clicked(position: int)

@export var item_position = -1
var double_click_component = preload("../double_click/double_click.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var double_click = double_click_component.instantiate()
	double_click.double_clicked.connect(
		func(): emit_signal("double_clicked", item_position)
	)
	add_child(double_click)
