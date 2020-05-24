extends Node2D

export var MAX_SIZE = 6000
export var MIN_SIZE = 2000

var HEIGHT: int = 50000
var rand_gen: = RandomNumberGenerator.new()

var planet_names

var current_seed

var _final_circles: = []
var _solar_system: = []
var _current_circle = 0

func _generate_circles():
	var circles = []
	var protection: = HEIGHT
	
	var circle: = {}
	var overlapping: = false
	var counter: = 0
	
	# Create circles
	while (circles.size() < HEIGHT and counter < protection):
		# Generate the random circles
		circle = {
			'pos': Vector2(rand_gen.randi_range(0, HEIGHT), rand_gen.randi_range(0, HEIGHT)),
			'radius': rand_gen.randi_range(MIN_SIZE, MAX_SIZE)
		}
		overlapping = false
		
		# Make sure that the circles dont overlap 
		for item in circles:
			var d = circle.pos.distance_to(item.pos)
			if d < circle.radius + item.radius:
				overlapping = true
				break
		
		if !overlapping:
			circles.append(circle)
		
		counter += 1
	
	var final = []
	
	for circle in circles:
		var new_circle = circle
		new_circle.pos.x -= HEIGHT / 2
		new_circle.pos.y -= HEIGHT / 2
		final.append(new_circle)
	
	return final

func _planets(radius):
	var planets = []
	var num_planets = rand_gen.randi_range(0, (radius - 300) / 110)
	
	for planet_num in range(1, num_planets):
		var planet = {
			'name': planet_names[rand_gen.randi()%planet_names.size()],
			'distance_from_sun': 300 + 110 * planet_num
		}
		
		planet.width = rand_gen.randi_range(40, 100)
	
	return planets

func _solar_system_gen():
	while _current_circle < _final_circles.size():
		var circle = {
			'pos': _final_circles[_current_circle].pos,
			'radius': _final_circles[_current_circle].radius,
			'id': _current_circle
		}
		_current_circle += 1
		
		circle.sunSize = rand_gen.randi_range(80, 280)
		circle.planets = _planets(circle.radius)

func _draw() -> void:
	for circle in _final_circles:
		draw_circle(circle.pos, circle.radius, Color.red)
	
	return

func generate():
	_final_circles = _generate_circles()
	
	_solar_system_gen()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rand_gen.randomize()
	current_seed = rand_gen.seed
	generate()

func _init(height = HEIGHT, max_size = MAX_SIZE, min_size = MIN_SIZE) -> void:
	HEIGHT = height
	MAX_SIZE = max_size
	MIN_SIZE = min_size
	
	var file = File.new()
	file.open('res://assets/planets/names.json', File.READ)
	
	var text = file.get_as_text()
	planet_names = parse_json(text)
	file.close()
	
	planet_names.shuffle()
	print(planet_names[1])

func set_seed(gen_seed: int) -> void:
	current_seed = gen_seed
	
	rand_gen.set_seed(gen_seed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
