extends Node2D
class_name InventoryState

signal inventory_updated(state: IInventoryState, previous_state: IInventoryState)

var is_opened = false
var slots: Dictionary[int, InventorySlotData] = {}
var capacity: int = 0

func setup(capacity: int):
	set_capacity(capacity)
	
func set_is_opened(value: bool):
	if value == is_opened:
		return
	var previous_state = get_current_state()
	previous_state.is_opened = is_opened
	is_opened = value
	inventory_updated.emit(get_current_state(), previous_state)
	
func set_slots(new_slots: Dictionary[int, InventorySlotData]) -> void:
	if slots == new_slots:
		return
	var previous_state = get_current_state()
	previous_state.slots = slots.duplicate(true)
	slots = new_slots
	inventory_updated.emit(get_current_state(), previous_state)
	
func set_capacity(value: int) -> void:
	if capacity == value:
		return
	var previous_state = get_current_state()
	previous_state.capacity = capacity
	capacity = value

	inventory_updated.emit(get_current_state(), previous_state)
	
func get_current_state() -> IInventoryState:
	var state = IInventoryState.new()
	
	state.capacity = capacity
	state.slots = slots
	state.is_opened = is_opened
	
	return state
