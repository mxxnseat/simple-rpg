extends Node

const SETTINGS_PATH := "user://settings.cfg"
const GAME_BUS := "Game"
const UI_BUS := "UI"

var pool_size = 8
var players: Array[AudioStreamPlayer] = []
var muted: bool = false

func _ready():
	for i in pool_size:
		var p = AudioStreamPlayer.new()
		p.bus = GAME_BUS
		add_child(p)
		players.append(p)

	var config := ConfigFile.new()
	if config.load(SETTINGS_PATH) == OK:
		muted = config.get_value("audio", "muted", false)
	AudioServer.set_bus_mute(AudioServer.get_bus_index(GAME_BUS), muted)

func play(sound: AudioStream, volume_db: float = 0.0, bus: String = GAME_BUS):
	for p in players:
		if not p.playing:
			p.stream = sound
			p.volume_db = volume_db
			p.bus = bus
			p.play()
			return

func set_muted(value: bool) -> void:
	muted = value
	AudioServer.set_bus_mute(AudioServer.get_bus_index(GAME_BUS), muted)

	var config := ConfigFile.new()
	config.set_value("audio", "muted", muted)
	config.save(SETTINGS_PATH)
