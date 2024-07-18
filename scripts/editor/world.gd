extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _input(event):
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_asset_browser_asset_selected(id, asset_name, full_path):
	print(id)
	print(asset_name)
	print(full_path)
	
	var object_to_load = load(full_path)
	var object = object_to_load.instantiate()
	$Decorations.add_child(object)
