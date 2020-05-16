extends Node2D

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
export var MAX_SIZE = 6000
export var MIN_SIZE = 2000

var HEIGHT: int = 50000
var rand_gen: = RandomNumberGenerator.new()

var current_seed

var _final_circles = []

var _solar_system = []
var _solar_system_mutex

var _current_circle = 0
var _current_circle_mutex

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

func _solar_system_thread():
	_current_circle_mutex.lock()
	var circle = {
		'pos': _final_circles[_current_circle].pos,
		'radius': _final_circles[_current_circle].radius,
		'id': _current_circle
	}
	_current_circle += 1
	_current_circle_mutex.unlock()
	
	circle.sunSize = rand_gen.randi_range(80, 280)
	circle.planets = {}
	
	
	

func _draw() -> void:
	for circle in _final_circles:
		draw_circle(circle.pos, circle.radius, Color.red)
	
	return

func generate():
	_final_circles = _generate_circles()
	print(OS.get_processor_count())
	
	_solar_system_mutex = Mutex.new()
	_current_circle_mutex = Mutex.new()
	
	
	
	var index = 0
	for circle in _final_circles:
		var solar_system = {
			'pos': circle.pos,
			'id': index,
			'radius': circle.radius
		}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rand_gen.randomize()
	current_seed = rand_gen.seed
	generate()

func _init(height = HEIGHT, max_size = MAX_SIZE, min_size = MIN_SIZE) -> void:
	HEIGHT = height
	MAX_SIZE = max_size
	MIN_SIZE = min_size

func set_seed(gen_seed: int) -> void:
	current_seed = gen_seed
	
	rand_gen.set_seed(gen_seed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
