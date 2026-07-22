extends Node2D

var enemy_scene = preload("res://src/entities/slime/slime.tscn")
var pickup_scene = preload("res://src/components/pickup/pickup.tscn")
var inventory_view_scene = preload("res://src/components/inventory/inventory_view/inventory_view.tscn")
var introduction_quest: Quest = preload("res://src/items/quests/introduction.tres")

@onready var quest_dialog: QuestDialog = $UI/QuestDialog
@onready var player_inventory_view: InventoryView = $UI/CenterContainer/HBoxContainer/VBoxContainer/PlayerInventoryView
@onready var player_gear_view: GearView = $UI/CenterContainer/HBoxContainer/VBoxContainer/PlayerGearView
@onready var player_inventories_view_wrapper =  $UI/CenterContainer/HBoxContainer/VBoxContainer
@onready var world_drop_zone: WorldDropZone = $UI/WorldDropZone
@onready var player: Player = $player
@onready var enemy: Enemy = $slime
@onready var big_slime: Enemy = $big_slime
@onready var chests_wrapper: Node2D = $chests

var quest_log := QuestLog.new()
var not_player_inventory_view: InventoryView = null

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
	
	player.setup(quest_log)
	enemy.setup(quest_log)
	big_slime.setup(quest_log)
	quest_dialog.setup(quest_log)
	
	quest_log.activate_quest(introduction_quest)
	
	world_drop_zone.setup(player)
	player_inventory_view.setup(player.inventory.model)
	player_inventory_view.set_label_text()
	player_gear_view.setup(player.gear)
	
	player.inventory_updated.connect(_player_on_inventory_updated)
	enemy.items_dropped.connect(_on_items_dropped)
	player.items_dropped.connect(_on_items_dropped)
	setup_chest_ui_listeners()

func setup_chest_ui_listeners():
	var chests = chests_wrapper.get_children() as Array[Chest]
	for chest in chests:
		chest.inventory_updated.connect(
			func(state: IInventoryState, previous_state: IInventoryState): 
				_chest_on_inventory_updated(chest, state)
		)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("close_dialog"):
		quest_dialog.close()
	
func _player_on_inventory_updated(state: IInventoryState, previous_state: IInventoryState):
	_player_on_inventory_updated_quest_log(state, previous_state)
	if state.is_opened or not not_player_inventory_view:
		return
	not_player_inventory_view.model.close()
	
func _player_on_inventory_updated_quest_log(state: IInventoryState, previous_state: IInventoryState) -> void:
	quest_log.notify_inventory_updated(state.slots)
	
func _chest_on_inventory_updated(chest: Chest, state: IInventoryState):
	chest_state_is_closed(state)
	chest_state_is_opened(chest, state)
	
func chest_state_is_closed(state: IInventoryState):
	if state.is_opened or not not_player_inventory_view:
		return
	not_player_inventory_view.queue_free()
	not_player_inventory_view = null

func chest_state_is_opened(chest: Chest, state: IInventoryState):
	if not state.is_opened or not_player_inventory_view:
		return
	var chestView: InventoryView = inventory_view_scene.instantiate()
	var hbox = $UI/CenterContainer/HBoxContainer
	hbox.add_child(chestView)
	hbox.move_child(player_inventories_view_wrapper, 1) # maybe will break in the future but now it works
	
	chestView.setup(chest.inventory.model)
	chestView.set_label_text()
	not_player_inventory_view = chestView
	
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
	var enemy: Enemy = enemy_scene.instantiate()
	enemy.position = position
	add_child(enemy)
	enemy.setup(quest_log)

func _on_items_dropped(items: Array[DropItemResource]):
	for drop_item in items:
		var pickup: Pickup = pickup_scene.instantiate()
		pickup.item = drop_item.item
		pickup.position = drop_item.position
		add_child(pickup)
