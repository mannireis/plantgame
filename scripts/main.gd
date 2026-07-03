extends Node2D

var inventory: Dictionary = {}
var money: int = 5

func _ready() -> void:
	MusicUi.stop_music()
	if not SaveManager.pending_load_data.is_empty():
		load_from_data(SaveManager.pending_load_data)
		SaveManager.pending_load_data = {}

func get_save_data() -> Dictionary:
	return {
		"grid": $grid.get_save_data(),
		"timer_active": not %Timer.is_stopped(),
		"inventory": inventory,
		"money": money
	}

func load_from_data(data: Dictionary) -> void:
	$grid.load_from_data(data.get("grid", {}))
	
	if data.get("timer_active", false):
		%Timer.start()
	else:
		%Timer.stop()
	
	inventory = data.get("inventory", {})
	money = data.get("money", 5)
