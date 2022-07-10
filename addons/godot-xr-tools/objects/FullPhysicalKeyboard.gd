extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var keyboard_keys = null
var keyboard_mode = "regular"
var changed_state = false
# Called when the node enters the scene tree for the first time.
func _ready():
	keyboard_keys = get_tree().get_nodes_in_group("Keys")  
	for key in keyboard_keys:  
		key.connect("keyboard_key_pressed", self, "on_keyboard_key_pressed") # Replace with function body.

func on_keyboard_key_pressed(key_text):
	var scan_code := OS.find_scancode_from_string(key_text)
	
	#Deal with abnormal keys
	if key_text == "BKSP":
		scan_code = OS.find_scancode_from_string("BackSpace")
		
	if key_text == ",":
		scan_code = OS.find_scancode_from_string("Comma")
		
	if key_text == ".":
		scan_code = OS.find_scancode_from_string("Period")
		
	if key_text == "Next":
		if keyboard_mode == "regular":
			keyboard_mode = "alternate"
			changed_state = true
			return
		else:
			keyboard_mode = "regular"
			changed_state = true
			return
		
	# Create the InputEventKey
	var input := InputEventKey.new()
	input.physical_scancode = scan_code
	input.unicode = scan_code
	input.pressed = true
	input.scancode = scan_code
	

	# Dispatch the input event
	Input.parse_input_event(input)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
