extends Label

#this is the script that retreives the high score to be shown on the main menu

func _ready() -> void:
	text = text % Gamedata.high_score

