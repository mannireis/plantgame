extends Control

@onready var root = $".."

func _ready():
	var save_popup = %SaveMenu.get_popup()
	var shop_popup = %ShopMenu.get_popup()

	save_popup.add_item("Slot 1", 0)
	save_popup.add_item("Slot 2", 1)
	save_popup.add_item("Slot 3", 2)
	save_popup.add_item("Exit", 3)
	
	shop_popup.add_item("Seed 1", 0)

	save_popup.id_pressed.connect(_on_save_menu_item_pressed)
	shop_popup.id_pressed.connect(_on_shop_menu_item_pressed)

func _on_save_menu_item_pressed(id):
	match id:
		0:
			var main = get_parent()
			var data = main.get_save_data()
			SaveManager.save_slot(1, data) 
		1:
			var main = get_parent()
			var data = main.get_save_data()
			SaveManager.save_slot(2, data) 
		2:
			var main = get_parent()
			var data = main.get_save_data()
			SaveManager.save_slot(3, data) 
		3:
			get_tree().change_scene_to_file("res://scenes/ui/start.tscn")


func _on_shop_menu_item_pressed(id):
	match id:
		0:
			print("meow")

func _process(delta: float) -> void:
	%MoneyLabel.text = str(root.money) + "c"
