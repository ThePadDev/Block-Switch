extends Area2D

var tile_size : int = 64

var lit : bool = false
var lit_time : float = 0.33

# LEVEL EDITOR VARIABLES

var editor_mode = false
var void_scene = preload("res://Blocks/Void.tscn")

#

onready var anim_player = $AnimationPlayer


func _ready():
	if get_tree().current_scene.name == "LevelEditor":
		editor_mode = true
	snap()


func snap():
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size / 2


func light_up():
	if !lit:
		anim_player.play("light_up")
		yield(anim_player, "animation_finished")
		lit = true
		yield(get_tree().create_timer(lit_time), "timeout")
		light_down()


func light_down():
	if lit:
		anim_player.play("light_down")
		yield(anim_player, "animation_finished")
		lit = false


func _on_Block_area_entered(area: Area2D):
	if area.is_in_group("Player"):
		light_up()

