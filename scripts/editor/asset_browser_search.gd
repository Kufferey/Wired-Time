extends Control

@onready var item_list = $ItemList

var assets : Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	
	var folder_icon : Array[Texture2D] = [
		load("res://assets/images/editor/folder_icon.png"),
		load("res://assets/images/editor/folder_icon_2d.png"),
		load("res://assets/images/editor/folder_icon_3d.png"),
		load("res://assets/images/editor/folder_icon_music.png"),
	]
	
	var asset_path : Array[String] = [
		"res://assets/",
		"res://assets/sounds/",
		"res://assets/models/decorative/",
		"res://assets/models/interior/",
	]
				
	find_sound_items(asset_path[1], folder_icon)
	find_decorative_items(asset_path[2], folder_icon)
	find_interior_items(asset_path[3], folder_icon)


func find_decorative_items(asset_path : String, folder_icon : Array) -> void:
	for asset in DirAccess.get_directories_at(asset_path):
		for asset_main in DirAccess.get_files_at(asset_path + asset + "/"):
			if asset_main.get_extension() == "tscn":
				assets[asset] = (asset_path + asset)
				item_list.add_item(asset_main.replace(".tscn", ""), folder_icon[2], true)
			elif asset_main.get_extension() == "png":
				assets[asset] = (asset_path + asset)
				item_list.add_item(asset_main.replace(".png", ""), folder_icon[1], true)


func find_interior_items(asset_path : String, folder_icon : Array) -> void:
	for asset in DirAccess.get_directories_at(asset_path):
		for asset_main in DirAccess.get_files_at(asset_path + asset + "/"):
			if asset_main.get_extension() == "tscn":
				assets[asset] = (asset_path + asset)
				item_list.add_item(asset_main.replace(".tscn", ""), folder_icon[2], true)
			elif asset_main.get_extension() == "png":
				assets[asset] = (asset_path + asset)
				item_list.add_item(asset_main.replace(".png", ""), folder_icon[1], true)


func find_sound_items(asset_path : String, folder_icon : Array) -> void:
	for asset in DirAccess.get_files_at(asset_path):
		if asset.get_extension() == "ogg":
			assets[asset] = (asset_path + asset)
			item_list.add_item(asset.replace(".ogg", ""), folder_icon[3], true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	$".".hide()
