extends Spatial

var key_scene = null
var key_instance = null
var first_row = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]


var first_row_transform = null
var symbols_row_transform = null

# Called when the node enters the scene tree for the first time.
func _ready():
	key_scene = load("res://addons/godot-xr-tools/objects/PhysicalKeyboard3-5/Key.tscn")
	first_row_transform = global_transform
	
	create_keys(first_row, first_row_transform)
	

func create_keys(list_of_keys, row_transform):
	var last_key_transform = null
	var num_of_keys = list_of_keys.size()
	for each_key in num_of_keys:
		key_instance = key_scene.instance()
		add_child(key_instance)
		if each_key == 0:
			key_instance.global_transform = row_transform
		else:
			key_instance.global_transform = last_key_transform.translated(Vector3(.065,0,0))
		key_instance.get_node("Button/KeyLabel3D").text = list_of_keys[each_key]
		last_key_transform = key_instance.global_transform
