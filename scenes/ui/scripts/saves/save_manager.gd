extends Node

const MAX_SLOTS := 3
const SAVE_DIR := "user://saves/"
const SAVE_VER := 1

var pending_load_data: Dictionary = {}

func _ready() -> void:
	DirAccess.make_dir_recursive_absolute(SAVE_DIR)

func _get_slot_path(slot: int) -> String:
	return SAVE_DIR + "save_%d.json" % slot

func save_slot(slot: int, data: Dictionary) -> bool:
	var path  := _get_slot_path(slot)
	
	var file := FileAccess.open(path, FileAccess.WRITE)
	if not file:
		push_error("Failed to write: ", path)
		return false
	
	file.store_string(JSON.stringify(data, "\t"))
	return true

func load_slot(slot: int) -> Dictionary:
	var path := _get_slot_path(slot)
	
	if not FileAccess.file_exists(path):
		return {}
	
	var file := FileAccess.open(path, FileAccess.READ)
	if not file:
		push_error("Failed to read: ", path)
		return {}
	
	var json := JSON.new()
	var parse_err := json.parse(file.get_as_text())
	if parse_err != OK:
		push_error("JSON Parse Error: ", json.get_error_message())
		return {}
		
	return json.data

func get_slot_metadata(slot: int) -> Dictionary:
	var data := load_slot(slot)
	return data.get("metadata", {})

func slot_exists(slot: int) -> bool:
	return FileAccess.file_exists(_get_slot_path(slot))

func delete_slot(slot: int) -> void:
	DirAccess.remove_absolute(_get_slot_path(slot))

func get_occupied_slots() -> Array[int]:
	var occupied: Array[int] = []
	for i in range(1, MAX_SLOTS + 1):
		if slot_exists(i):
			occupied.append(i)
	return occupied
