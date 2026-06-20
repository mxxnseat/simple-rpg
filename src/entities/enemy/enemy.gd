extends CharacterBody2D
class_name Enemy

@onready var state: EnemyState = $State
@onready var model: EnemyModel = $Model
@onready var controller: EnemyController = $Controller
@onready var anim_manager: EnemyAnimationManager = $AnimationManager
@onready var health_bar: HealthBar = $health_bar
@onready var combat: Combat = $combat

func _ready():
	health_bar.setup(state)
	model.setup(state)
	controller.setup(model, combat.model)
	anim_manager.setup(state)
	
	combat.setup(10)
	
	health_bar.model.died.connect(_on_health_bar_died)
	combat.model.attack_sig.connect(_on_combat_attack_sig)

func _on_health_bar_died():
	model.die()
	await anim_manager.on_death()
	queue_free()

func take_damage(amount: int):
	health_bar.take_damage(amount)

func _on_combat_attack_sig():
	model.attack()
