extends Node2D

var m_time = 0.0
var m_logging = true

func _ready():
	m_time = 0.0
	m_logging = true

func _process(delta):
	if(!m_logging):
		return
	m_time += delta
	var fps = Performance.get_monitor(Performance.TIME_FPS)
	$fps.set_text("FPS: " + str(fps))
	print("Time: " + str(m_time) + " - FPS:" + str(fps))

func set_logging(logging):
	m_logging = logging
