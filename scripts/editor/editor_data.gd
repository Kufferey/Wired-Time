extends Control


var total_assets : int
var total_sounds : int


# Called when the node enters the scene tree for the first time.
func _ready():
	for asset in DirAccess.get_directories_at("res://assets/models/decorative/") + DirAccess.get_directories_at("res://assets/models/interior/"):
		total_assets += 1
	
	for sound in DirAccess.get_files_at("res://assets/sounds/"):
		if sound.get_extension() == "ogg":
			total_sounds += 1
	
	$Control/TotalAssets.text = "Total Assets: " + str(total_assets)
	$Control/TotalSounds.text = "Total Sounds: " + str(total_sounds)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
