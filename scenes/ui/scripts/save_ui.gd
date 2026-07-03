extends Control

func _on_save_slot_1_pressed() -> void:
	var data = SaveManager.load_slot(1)
	if data.is_empty():
		get_tree().change_scene_to_file("res://scenes/main.tscn")
		return
	SaveManager.pending_load_data = data
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_save_slot_2_pressed() -> void:
	var data = SaveManager.load_slot(2)
	if data.is_empty():
		get_tree().change_scene_to_file("res://scenes/main.tscn")
		return
	SaveManager.pending_load_data = data
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_save_slot_3_pressed() -> void:
	var data = SaveManager.load_slot(3)
	if data.is_empty():
		get_tree().change_scene_to_file("res://scenes/main.tscn")
		return
	SaveManager.pending_load_data = data
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_delete_button_1_pressed() -> void:
	SaveManager.delete_slot(1)


func _on_delete_button_2_pressed() -> void:
	SaveManager.delete_slot(2)


func _on_delete_button_3_pressed() -> void:
	SaveManager.delete_slot(3)


func _on_exit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/start.tscn")
