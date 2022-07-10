extends Spatial


var key_scene = null
var key_instance = null
var first_row = ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"]
var alt_first_row = ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p"]
var second_row = ["A", "S", "D", "F", "G", "H", "J", "K", "L"]
var alt_second_row = ["a", "s", "d", "f", "g", "h", "j", "k", "l"]
var third_row = ["Z", "X", "C", "V", "B", "N", "M", ",","."]
var alt_third_row = ["z", "x", "c", "v", "b", "n", "m","<", ">"]
var first_row_transform = null
var second_row_transform = null
var third_row_transform = null
var first_row_keys = []
var second_row_keys = []
var third_row_keys = []
var physical_keyboard = null

# Called when the node enters the scene tree for the first time.
func _ready():
	key_scene = load("res://addons/godot-xr-tools/objects/PhysicalKeyboard3-5/Key.tscn")
	first_row_transform = global_transform
	second_row_transform = global_transform.translated(Vector3(.030,0,.07))
	third_row_transform = global_transform.translated(Vector3(.060,0,.14))
	create_keys(first_row, first_row_transform, first_row_keys)
	create_keys(second_row, second_row_transform, second_row_keys)
	create_keys(third_row, third_row_transform, third_row_keys)
	physical_keyboard = get_parent().get_parent()

func create_keys(list_of_keys, row_transform, key_nodes):
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
		key_nodes.append(key_instance)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(str(get_parent().get_parent().keyboard_mode))
	print(str(get_parent().get_parent().changed_state))
	
	if physical_keyboard.keyboard_mode == "alternate" and physical_keyboard.changed_state == true:
		for key_node in first_row_keys:
			key_node.queue_free()
		for key_node in second_row_keys:
			key_node.queue_free()
		for key_node in third_row_keys:
			key_node.queue_free()
		first_row_keys = []
		second_row_keys = []
		third_row_keys = []
		create_keys(alt_first_row, first_row_transform, first_row_keys)
		create_keys(alt_second_row, second_row_transform, second_row_keys)
		create_keys(alt_third_row, third_row_transform, third_row_keys)
		physical_keyboard.changed_state  = false
		var keyboard_keys = get_tree().get_nodes_in_group("Keys")  
		for key in keyboard_keys:  
			key.connect("keyboard_key_pressed", physical_keyboard, "on_keyboard_key_pressed")
	
	if physical_keyboard.keyboard_mode == "regular" and physical_keyboard.changed_state == true:
		for key_node in first_row_keys:
			key_node.queue_free()
		for key_node in second_row_keys:
			key_node.queue_free()
		for key_node in third_row_keys:
			key_node.queue_free()
		first_row_keys = []
		second_row_keys = []
		third_row_keys = []
		create_keys(first_row, first_row_transform, first_row_keys)
		create_keys(second_row, second_row_transform, second_row_keys)
		create_keys(third_row, third_row_transform, third_row_keys)
		physical_keyboard.changed_state  = false
		var keyboard_keys = get_tree().get_nodes_in_group("Keys")  
		for key in keyboard_keys:  
			key.connect("keyboard_key_pressed", physical_keyboard, "on_keyboard_key_pressed")
