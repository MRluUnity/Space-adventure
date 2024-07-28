extends Node

@onready var sfx_player: AudioStreamPlayer2D = $SFXPlayer
@onready var ambient_player: AudioStreamPlayer2D = $AmbientPlayer
@onready var bgm_player: AudioStreamPlayer2D = $BGMPlayer

var db : float

func sfx_play(sfx_index : int) -> void:
	pass

func ambient_play(ambient_index : int) -> void:
	pass

func bgm_play(bgm : AudioStreamOggVorbis) -> void:
	if not bgm_player.playing:
		bgm_player.stream = bgm
		bgm_player.play()
		return
	db = bgm_player.volume_db
	var tween_down : Tween = create_tween()
	tween_down.tween_property(bgm_player, "volume_db", linear_to_db(.1), .7)
	await tween_down.finished
	bgm_player.stream = bgm
	bgm_player.play()
	var tween_up : Tween = create_tween()
	tween_up.tween_property(bgm_player, "volume_db", db, .7)
