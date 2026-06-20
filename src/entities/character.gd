extends CharacterBody2D

signal died(who)
signal request_drop(position: Vector2)

var health = null
var is_dead = false
var can_attack = true

func _ready():
	$health_bar.position = Vector2(-5, 5)
	$health_bar/ProgressBar.max_value = health
	$health_bar/ProgressBar.value = health

func take_damage(amount):
	var new_health = max(health - amount, 0)
	health = new_health
	$health_bar.update(health)
	die()
		
func die():
	if health == 0:
		emit_signal("died", self)
		emit_signal("request_drop", global_position)
		is_dead = true
		can_attack = false
		var animation = $AnimatedSprite2D
		var is_animation_exists = animation.sprite_frames.has_animation("death")
		if is_animation_exists:
			animation.play("death")
			await animation.animation_finished
		else:
			print(self, " does not have animation 'death'")
		queue_free()
