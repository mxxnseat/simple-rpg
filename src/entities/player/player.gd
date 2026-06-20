extends CharacterBody2D
class_name Player

@onready var state: PlayerState = $State
@onready var model: PlayerModel = $Model
@onready var controller: PlayerController = $Controller
@onready var anim_manager: PlayerAnimationManager = $AnimationManager
@onready var health_bar: HealthBar = $health_bar
@onready var combat: Combat = $combat


func _ready():
	health_bar.setup(state)
	model.setup(state)
	controller.setup(model, combat.model)
	anim_manager.setup(state)
	combat.setup(100)
	
	health_bar.model.died.connect(_on_health_bar_died)

func _on_health_bar_died():
	model.die()
	await anim_manager.on_death()
	queue_free()

func take_damage(amount: int):
	health_bar.take_damage(amount)
