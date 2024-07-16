extends Control

signal asset_selected(id, asset_name : String, full_path : String)

@onready var decor_item_list = $SelectionBox/TabContainer/Decorative/ItemList
@onready var inter_item_list = $SelectionBox/TabContainer/Interior/ItemList
@onready var sound_item_list = $SelectionBox/TabContainer/Sounds/ItemList

var assets : Dictionary = {}

var decor_assets_name : Array[String] = []
var inter_assets_name : Array[String] = []
var sound_assets_name : Array[String] = []

var temp_tab : TabBar

# Called when the node enters the scene tree for the first time.
func _ready():
	decor_item_list.connect("item_clicked", decorative_selected)
	inter_item_list.connect("item_clicked", interior_selected)
	sound_item_list.connect("item_clicked", sound_selected)
	
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


func add_asset_name(catagory : int, asset : String, extension : String, asset_path : String) -> void:
	if extension != "":
		assets[asset] = (asset_path + asset + "/" + asset.get_file() + "." + extension)
	else:
		assets[asset] = (asset_path + asset)
	print(asset)
	print(asset_path)
	print(assets)
	match catagory:
		1:
			decor_assets_name.append(asset)
		2:
			inter_assets_name.append(asset)
		3:
			sound_assets_name.append(asset)


func find_decorative_items(asset_path : String, folder_icon : Array[Texture2D]) -> void:
	for asset in DirAccess.get_directories_at(asset_path):
		for asset_main in DirAccess.get_files_at(asset_path + asset + "/"):
			if asset_main.get_extension() == "tscn":
				add_asset_name(1, asset, "tscn", asset_path)
				decor_item_list.add_item(asset_main.replace(".tscn", ""), folder_icon[2], true)
			elif asset_main.get_extension() == "png":
				add_asset_name(1, asset, "png", asset_path)
				decor_item_list.add_item(asset_main.replace(".png", ""), folder_icon[1], true)


func find_interior_items(asset_path : String, folder_icon : Array[Texture2D]) -> void:
	for asset in DirAccess.get_directories_at(asset_path):
		for asset_main in DirAccess.get_files_at(asset_path + asset + "/"):
			if asset_main.get_extension() == "tscn":
				add_asset_name(2, asset, "tscn", asset_path)
				inter_item_list.add_item(asset_main.replace(".tscn", ""), folder_icon[2], true)
			elif asset_main.get_extension() == "png":
				add_asset_name(2, asset, "png", asset_path)
				inter_item_list.add_item(asset_main.replace(".png", ""), folder_icon[1], true)


func find_sound_items(asset_path : String, folder_icon : Array[Texture2D]) -> void:
	for asset in DirAccess.get_files_at(asset_path):
		if asset.get_extension() == "ogg":
			add_asset_name(3, asset, "", asset_path)
			sound_item_list.add_item(asset.replace(".ogg", ""), folder_icon[3], true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_more_assets_pressed():
	print(assets)
	$"../../Menus/AssetBrowserFull".show()


func decorative_selected(index : int, at_position, mouse_button_index):
	var name_of_asset : String = decor_assets_name[index]
	var path_of_asset : String = assets.get(name_of_asset)
	
	asset_selected.emit(index, name_of_asset, path_of_asset)


func interior_selected(index : int, at_position, mouse_button_index):
	var name_of_asset : String = inter_assets_name[index]
	var path_of_asset : String = assets.get(name_of_asset)
	
	asset_selected.emit(index, name_of_asset, path_of_asset)


func sound_selected(index : int, at_position, mouse_button_index):
	var name_of_asset : String = sound_assets_name[index]
	var path_of_asset : String = assets.get(name_of_asset)
	
	asset_selected.emit(index, name_of_asset, path_of_asset)
