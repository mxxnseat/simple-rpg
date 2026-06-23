extends AnimatedSprite2D
class_name ChestView

func _ready():
	toggle_visibility(false)

func toggle_visibility(toggle: bool):
	if toggle:
		play("opened")
	else:
		play("closed")
