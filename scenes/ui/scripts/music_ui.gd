extends AudioStreamPlayer2D

func stop_music():
	stop()

func play_music():
	if not playing:
		play()
