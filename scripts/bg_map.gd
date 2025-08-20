extends Node2D

@onready var decorate: TileMapLayer = $tilemap/decorate
@onready var bg_1: TileMapLayer = $tilemap/bg1
@onready var upgrade_page: Upgrade_page = $Upgrade_page

var player:Basic_Player

func _init() -> void:
    player=GlobalData.cur_Player
    add_child(player)
    
func _ready() -> void:
    random_tile()
    player.upgrade.connect(show_upgrade_page)
    AudioManager.play_music("res://assets/audio/Bg Music.mp3",true)
    
func show_upgrade_page(level:int):
    print(level)
    get_tree().paused=true
    upgrade_page.visible=true
    
    
func random_tile():
    decorate.clear()
    var bg1_cells=bg_1.get_used_cells()
    for cell_pos in bg1_cells:
        var num=randi()%180
        if num<=5:
            decorate.set_cell(cell_pos,3,Vector2i(6,1))
        if num<=2:
            decorate.set_cell(cell_pos,3,Vector2i(9,3))
        if num==0:
            decorate.set_cell(cell_pos,3,Vector2i(9,5))
    var s=bg_1.get_used_cells().max()
    var t=bg_1.to_global(bg_1.map_to_local(s))
    var s2=bg_1.get_used_cells().min()
    var t2=bg_1.to_global(bg_1.map_to_local(s2))
    
    
    print(bg_1.map_to_local(s))
    GlobalData.emit_signal("create_map"\
    ,Vector4(t2.x,t2.y,t.x,t.y))
