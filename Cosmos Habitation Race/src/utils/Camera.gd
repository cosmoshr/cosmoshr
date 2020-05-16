extends Camera2D

# Max and min zoom levels for godot
export var MIN_ZOOM_LEVEL: = 0.5
export var MAX_ZOOM_LEVEL: = 8.0

# Zoom increments for godot
const ZOOM_INCREMENT: = 0.2

# Create a signal for move and zoomed
signal moved()
signal zoomed()

# Internal variables
var _current_zoom_level: = 1.0
var _drag: = false 

func _input(event: InputEvent) -> void:
	if event.is_action_pressed('cam_drag'):
		_drag = true
	elif event.is_action_released('cam_drag'):
		_drag = false
	elif event.is_action('cam_zoom_in'):
		_update_zoom(-ZOOM_INCREMENT, get_local_mouse_position())
	elif event.is_action('cam_zoom_out'):	
		_update_zoom(ZOOM_INCREMENT, get_local_mouse_position())
	elif event is InputEventMouseMotion && _drag:
		set_offset(get_offset() - event.relative*_current_zoom_level)
		emit_signal('moved')

func _update_zoom(incr: float, zoom_anchor: Vector2):
	var old_zoom = _current_zoom_level
	_current_zoom_level += incr
	
	if _current_zoom_level < MIN_ZOOM_LEVEL:
		_current_zoom_level = MIN_ZOOM_LEVEL
	elif _current_zoom_level > MAX_ZOOM_LEVEL:
		_current_zoom_level = MAX_ZOOM_LEVEL
	
	if old_zoom == _current_zoom_level:
		return
	
	var zoom_center = zoom_anchor - get_offset()
	var ratio = 1-_current_zoom_level/old_zoom
	set_offset(get_offset() + zoom_center*ratio)
	
	set_zoom(Vector2(_current_zoom_level, _current_zoom_level))
	emit_signal("zoomed")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
