extends Sprite2D

@export var bpm: float = 124.0
@export var min_scale: Vector2 = Vector2(0.95, 0.95)
@export var max_scale: Vector2 = Vector2(1.0, 1.0)
@export var min_rotation_deg: float = -2.0       # twist left (degrees)
@export var max_rotation_deg: float = 2.0        # twist right (degrees)
@export var phase_offset: float = 0.0
@export var amplitude_curve_power: float = 1.0
@export var pulse_opacity: bool = false
@export var min_opacity: float = 0.9
@export var max_opacity: float = 1.0

signal beat

var _t: float = 0.0
var _last_beat_count: int = -1

func _process(delta: float) -> void:
	_t += delta
	var frequency = bpm / 60.0
	var ang = TAU * frequency * (_t + phase_offset)

	# Smooth oscillation 0..1
	var raw = 0.5 * (1.0 - cos(ang))
	var shaped = pow(raw, amplitude_curve_power)

	# --- Pulse scale ---
	scale = min_scale.lerp(max_scale, shaped)

	# --- Twist rotation ---
	# Convert degrees → radians
	var rot_min = deg_to_rad(min_rotation_deg)
	var rot_max = deg_to_rad(max_rotation_deg)
	rotation = lerp(rot_min, rot_max, shaped)

	# --- Optional opacity pulse ---
	if pulse_opacity:
		modulate.a = lerp(min_opacity, max_opacity, shaped)

	# --- Emit beat signal (once per beat) ---
	var beat_index = int(floor(frequency * (_t + phase_offset)))
	if beat_index != _last_beat_count:
		_last_beat_count = beat_index
		emit_signal("beat")
