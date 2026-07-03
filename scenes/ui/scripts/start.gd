extends Control

func _ready() -> void:
	MusicUi.play_music()

func _on_continue_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/save_ui.tscn")

func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/settings.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()
