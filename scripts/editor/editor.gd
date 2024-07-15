extends Control

var version : String = "0.1.2"

enum Difficulty {
	NONE,
	EASY,
	NORMAL,
	HARD,
	EXTREME,
}

var project : Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	DisplayServer.window_set_title("Wired Time - Map Editor (BETA v" + str(version) + ")")
	var default_project : Dictionary = {
		"init_data": {
			"name": "",
			"desc": "",
			"difficulty": Difficulty.NONE,
			"default_difficulty": Difficulty.NORMAL,
		},
		"assets": {
			"default_parameters": {"asset_model": "", "position": Vector3(0, 0, 0), "signals": {"receive": {"name_asset": ["col_hit", "clicked"]}, "push": {"name_asset": ["col_hit", "clicked"]}}, "custom_script": "", "events": []}
		}
	}
	project.merge(default_project, true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
