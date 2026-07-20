# signal interacted
extends Interactable
class_name Chest

signal inventory_updated(state: IInventoryState, previous_state: IInventoryState)

@onready var sfx_player: AnimationPlayer = $sfx_player
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

func _play_sound(state: IInventoryState, previous_state: IInventoryState):
	if state.is_opened == previous_state.is_opened:
		return
	if state.is_opened:
		sfx_player.play("open_sfx")
	else:
		sfx_player.play("close_sfx")

func _on_inventory_updated(state: IInventoryState, previous_state: IInventoryState):
	_play_sound(state, previous_state)
	view.toggle_visibility(state.is_opened)
	inventory_updated.emit(state, previous_state)

func open_inventory():
	inventory.open()
	
func close_inventory():
	inventory.close()
