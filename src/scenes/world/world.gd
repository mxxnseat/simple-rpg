extends Node2D

var enemy_scene = preload("res://src/entities/enemy/enemy.tscn")
var pickup_scene = preload("res://src/components/pickup/pickup.tscn")
var key_item = preload("res://src/items/key.tres")

@onready var player_inventory_view: InventoryView = $UI/CenterContainer/HBoxContainer/PlayerInventoryView
@onready var player: Player = $player

func _ready():
	var used = $TileMap.get_used_rect()
	var cell_size = $TileMap.tile_set.tile_size
	
	var camera = $player/Camera2D
	camera.limit_left = used.position.x * cell_size.x
	camera.limit_top = used.position.y * cell_size.y
	camera.limit_right = used.end.x * cell_size.x
	camera.limit_bottom = used.end.y * cell_size.y
	
	create_borders()
	spawn_enemies_in_zone()
	
	var pickup: Pickup = pickup_scene.instantiate()
	pickup.item = key_item
	pickup.position = Vector2(10, 10)
	add_child(pickup)
	
	player_inventory_view.setup(player.inventory.model)

func create_borders():
	var used = $TileMap.get_used_rect()
	var cell_size = $TileMap.tile_set.tile_size
	var offset = $TileMap.position

	var left = used.position.x * cell_size.x + offset.x
	var top = used.position.y * cell_size.y + offset.y
	var right = used.end.x * cell_size.x + offset.x
	var bottom = used.end.y * cell_size.y + offset.y

	create_border(Vector2(left, (top + bottom) / 2), Vector2(1, bottom - top))
	create_border(Vector2(right, (top + bottom) / 2), Vector2(1, bottom - top))
	create_border(Vector2((left + right) / 2, top), Vector2(right - left, 1))
	create_border(Vector2((left + right) / 2, bottom), Vector2(right - left, 1))
	
func create_border(position: Vector2, size: Vector2):
	var body = StaticBody2D.new()
	var shape = CollisionShape2D.new()
	var rect = RectangleShape2D.new()
	
	rect.size = size
	shape.shape = rect
	body.position = position
	body.add_child(shape)
	add_child(body)
	
func spawn_enemies_in_zone():
	var zone = $enemy_spawns
	for area in zone.get_children():
		var enemies_count = area.get_meta("enemies_count", 0)
		for i in enemies_count:
			var global_position = zone.position + area.position
			var rect = area.shape.get_rect()
			var x = randf_range(rect.position.x+global_position.x, rect.end.x+global_position.x)
			var y = randf_range(rect.position.y+global_position.y, rect.end.y+global_position.y)
			
			spawn_enemy(Vector2(x, y))
		
func spawn_enemy(position: Vector2):
	var enemy = enemy_scene.instantiate()
	enemy.position = position
	add_child(enemy)
