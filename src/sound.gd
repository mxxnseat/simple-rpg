extends Node

var pool_size = 8
var players: Array[AudioStreamPlayer] = []

func _ready():
	for i in pool_size:
		var p = AudioStreamPlayer.new()
		add_child(p)
		players.append(p)

func play(sound: AudioStream, volume_db: float = 0.0):
	for p in players:
		if not p.playing:
			p.stream = sound
			p.volume_db = volume_db
			p.play()
			return
