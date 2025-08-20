extends Control

@export var back_color:Color
@export var fill_color:Color
@onready var progress_bar: ProgressBar = $ProgressBar
@onready var label: Label = $Label

func _ready() -> void:
    var bcg=progress_bar.get_theme_stylebox("background").duplicate()
    bcg.bg_color=back_color
    
    var fill=progress_bar.get_theme_stylebox("fill").duplicate()
    fill.bg_color=fill_color
    
    progress_bar.add_theme_stylebox_override("background",bcg)
    progress_bar.add_theme_stylebox_override("fill",fill)
    
func _process(delta: float) -> void:
    progress_bar.max_value=get_parent().health_max
    progress_bar.value=get_parent().cur_health
    label.text=str(get_parent().cur_health)
    
    
    
