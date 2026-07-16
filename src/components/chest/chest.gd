# signal interacted
extends Interactable
class_name Chest

signal inventory_updated(state: IInventoryState, previous_state: IInventoryState)

@onready var view: ChestView = $view
@onready var inventory: Inventory = $Inventory
@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer

@export var initial_entries: Array[InventorySlotData] = []

func _ready():
	super._ready()
	inventory.setup(10)
	interacted.connect(_on_interacted)
	_initialize_inventory()
	inventory.model.inventory_updated.connect(_on_inventory_updated)
	
func _on_interacted(result: bool) -> void:
	if result:
		inventory.toggle_opened()
	else:
		close_inventory()
		
func _initialize_inventory():
	for initial_entry in initial_entries:
		inventory.model.add_item(initial_entry.item, initial_entry.count)

func _play_sound(state: IInventoryState):
	if state.is_opened:
		audio_player.stream = preload("res://sfx/chest-open.mp3")
	else:
		audio_player.stream = preload("res://sfx/chest-close.mp3")
	audio_player.play()
	

func _on_inventory_updated(state: IInventoryState, previous_state: IInventoryState):
	_play_sound(state)
	view.toggle_visibility(state.is_opened)
	inventory_updated.emit(state, previous_state)

func open_inventory():
	inventory.open()
	
func close_inventory():
	inventory.close()
