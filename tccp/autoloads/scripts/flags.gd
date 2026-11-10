extends Node
## Usado para armazenar variaveis booleanas que podem ser acessadas e mudadas globalmente

# Usado em player.gd e talk_manager.gd
var can_move: bool = true 

# Usado em ladder_manager.gd e e player.gd
var on_ladder: bool = false

# Usado em player.gd e animation_manager.gd
var climbing: bool = false

# Usado em killzone.gd e animation_manager.gd
var in_killzone: bool = false
# -------------------------------------
