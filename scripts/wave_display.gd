extends CanvasLayer


@onready var timer: Timer = $Timer
@onready var wave: Label = $VBoxContainer/wave
@onready var wave_time: Label = $VBoxContainer/wave_time

var wave_num=1
func _ready() -> void:
    wave.text="第"+str(wave_num)+"波"
    wave_time.text=str(timer.time_left)
    timer.start()
    
func _process(delta: float) -> void:
    wave_time.text=str(snapped(timer.time_left,0.1))

func _on_timer_timeout() -> void:
    wave_num+=1
    wave.text="第"+str(wave_num)+"波"
    timer.start()
