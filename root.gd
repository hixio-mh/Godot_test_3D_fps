extends Spatial

const c_time_to_change_props = 60.0
const c_increase_shadow_max_distance = 50.0
const c_max_shadow_distance = 1000.0

var m_time = 0.0
var m_change_max_distance = true
var m_logging = false

func _ready():
	m_time = 0.0

	$dir_light.set_shadow_depth_range(DirectionalLight.SHADOW_DEPTH_RANGE_STABLE)
	$dir_light.directional_shadow_max_distance = c_increase_shadow_max_distance

	m_logging = true
	m_change_max_distance = true

	$HUD/debug.set_logging(true)
	log_dir_light_props()

func _process(delta):
	if(!m_logging):
		return
	m_time += delta
	if(m_time >= c_time_to_change_props):
		if(m_change_max_distance):
			$dir_light.directional_shadow_max_distance += c_increase_shadow_max_distance
			log_dir_light_props()
			m_time -= c_time_to_change_props
			if($dir_light.directional_shadow_max_distance >= c_max_shadow_distance):
				m_change_max_distance = false
		else:
			if($dir_light.get_shadow_depth_range() == DirectionalLight.SHADOW_DEPTH_RANGE_OPTIMIZED):
				m_logging = true
				$HUD/debug.set_logging(false)
			else:
				$dir_light.directional_shadow_max_distance = c_increase_shadow_max_distance
				$dir_light.set_shadow_depth_range(DirectionalLight.SHADOW_DEPTH_RANGE_OPTIMIZED)
				m_change_max_distance = true

func change_dir_light_props():
	pass

func log_dir_light_props():
	print("*** Dir light props:")
	print("Depth range: " + get_depth_range_name($dir_light.get_shadow_depth_range()))
	print("Max Distance: " + str($dir_light.directional_shadow_max_distance))

func get_depth_range_name(type):
	match type:
		DirectionalLight.SHADOW_DEPTH_RANGE_STABLE:
			return "Stable"
		DirectionalLight.SHADOW_DEPTH_RANGE_OPTIMIZED:
			return "Optimized"
	return "Depth range not defined: " + str(type)
