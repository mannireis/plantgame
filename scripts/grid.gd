extends Node2D

@onready var root = $".."
@onready var timer = %Timer

var grid = []
var state: States = States.WAITING
var spread_chance = 0.3

enum States {WAITING, RUNNING}

func  _ready() -> void:
	position = Vector2(
		(get_viewport_rect().size.x - 50) / 2.0,
		(get_viewport_rect().size.y - 50) / 2.0
	)
	grid = []
	for x in 50:
		grid.append([])
		for y in 50:
			grid[x].append(0)
	timer.wait_time = randi_range(0.1, 1)
	timer.timeout.connect(_on_timer_timeout)

func _draw() -> void:
	for x in range(50):
		for y in range(50):
			if grid[x][y] == 1:
				draw_rect(Rect2(x, y, 1 , 1), Color.LIME_GREEN)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed and root.money >= 1:
		var pos = get_local_mouse_position()
		var gx = int(pos.x)
		var gy = int(pos.y)
		if gx >= 0 and gx < 50 and gy >= 0 and gy <50:
			grid[gx][gy] = 1
			state = States.RUNNING
			timer.start()
			queue_redraw()
			root.money -= 1
			print(root.money)

func _on_timer_timeout() -> void:
	var new_plants = []
	for x in range(50):
		for y in range(50):
			if grid[x][y] == 1:
				var neighboors = get_neighboors(x, y)
				for n in neighboors:
					if grid[n[0]][n[1]] == 0 and randf() < spread_chance:
						new_plants.append(n)
						if randf() < 1.0 / 30.0:
							root.money += 1
	for p in new_plants:
		grid[p[0]][p[1]] = 1
	queue_redraw()
	
func get_neighboors(x, y):
	var result = []
	for dx in [-1, 0, 1]:
		for dy in [-1, 0, 1]:
			if dx == 0 and dy == 0:
				continue
			var nx = x + dx
			var ny = y + dy
			if nx >= 0 and nx < 50 and ny >= 0 and ny < 50:
				result.append([nx, ny])
	return result

func get_save_data() -> Dictionary:
	var count = 0
	for x in range(50):
		for y in range(50):
			count += grid[x][y]

	return {
		"grid": grid,
		"state": "RUNNING" if state == States.RUNNING else "WAITING",
		"spread_chance": spread_chance
	}

func load_from_data(data: Dictionary) -> void:
	if data.is_empty():
		return

	grid = []
	for row in data.get("grid", []):
		grid.append(row.duplicate())

	state = States.RUNNING if data.get("state") == "RUNNING" else States.WAITING

	spread_chance = data.get("spread_chance", 0.3)

	queue_redraw
