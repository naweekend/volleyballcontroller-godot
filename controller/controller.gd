extends Node

var udp = PacketPeerUDP.new()
var connected = false
@onready var connected_label: Label = $CanvasLayer/HBoxContainer3/ConnectedLabel

func _ready():
	udp.connect_to_host("###.###.###.##", 4242)

func _process(delta):
	if !connected:
		# Try to contact server
		udp.put_packet("Yo server and back to me!".to_utf8_buffer())
	if udp.get_available_packet_count() > 0:
		print("Connected: %s" % udp.get_packet().get_string_from_utf8())
		connected = true

	if connected:
		connected_label.visible = true
	else:
		connected_label.visible = false

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("left"):
		udp.put_packet("LEFT_PRESSED".to_utf8_buffer())
	if Input.is_action_just_released("left"):
		udp.put_packet("LEFT_RELEASED".to_utf8_buffer())
	if Input.is_action_just_pressed("right"):
		udp.put_packet("RIGHT_PRESSED".to_utf8_buffer())
	if Input.is_action_just_released("right"):
		udp.put_packet("RIGHT_RELEASED".to_utf8_buffer())
	if Input.is_action_just_pressed("jump"):
		udp.put_packet("JUMP_PRESSED".to_utf8_buffer())
	if Input.is_action_just_released("jump"):
		udp.put_packet("JUMP_RELEASED".to_utf8_buffer())


func _on_left_button_pressed() -> void:
	udp.put_packet("LEFT_PRESSED".to_utf8_buffer())

func _on_left_button_released() -> void:
	udp.put_packet("LEFT_RELEASED".to_utf8_buffer())

func _on_right_button_pressed() -> void:
	udp.put_packet("RIGHT_PRESSED".to_utf8_buffer())

func _on_right_button_released() -> void:
	udp.put_packet("RIGHT_RELEASED".to_utf8_buffer())

func _on_jump_button_pressed() -> void:
	udp.put_packet("JUMP_PRESSED".to_utf8_buffer())

func _on_jump_button_released() -> void:
	udp.put_packet("JUMP_RELEASED".to_utf8_buffer())
