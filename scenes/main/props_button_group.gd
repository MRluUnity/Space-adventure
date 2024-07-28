class_name PropsButtonGroup extends GridContainer

signal update_codex_context(_texture : Texture, _name : String, _text : String)

@onready var scroll_container: ScrollContainer = $".."
@onready var force_field_galaxy: Button = $ForceFieldGalaxy
@onready var black_hole: Button = $BlackHole
@onready var boundary_stabilizer: Button = $BoundaryStabilizer
@onready var spare_ship: Button = $SpareShip
@onready var fate_dice: Button = $FateDice
@onready var damaged_armour: Button = $DamagedArmour
@onready var deceleration_machine: Button = $DecelerationMachine
@onready var gravity_eliminator: Button = $GravityEliminator
@onready var repair_tool: Button = $RepairTool
@onready var laser_transmiter: Button = $LaserTransmiter

func _on_force_field_galaxy_pressed() -> void:
	update_codex_context.emit(force_field_galaxy.icon, "力场护盾", "持续类道具
持续时间：10秒
作用：在玩家周围创建一个护盾，护盾会摧毁所有撞到的陨石，并给予基本陨石计分。
特性：当玩家已经有护盾时拿到该道具转而加分。")


func _on_black_hole_pressed() -> void:
	update_codex_context.emit(black_hole.icon, "黑洞", "一次性道具
作用：玩家激活黑洞后，黑洞将蔓延开来将全屏的陨石和道具销毁，并给予两倍陨石计分。
特性：黑洞是唯一一个无法被陨石撞毁的道具。")


func _on_boundary_stabilizer_pressed() -> void:
	update_codex_context.emit(boundary_stabilizer.icon, "边界稳定器", "一次性道具
作用：玩家激活边界稳定器后，将边界向外扩一段距离。
特性：只有在得分超过边界坍塌事件的出现分数才会出现。")


func _on_spare_ship_pressed() -> void:
	update_codex_context.emit(spare_ship.icon, "备用飞船", "一次性道具
作用：玩家激活备用飞船后，将会有特效在玩家身上来回，当玩家受到致命伤害时免除该伤害。")


func _on_fate_dice_pressed() -> void:
	update_codex_context.emit(fate_dice.icon, "命运色子", "一次性道具
作用：在所有道具中随机一种给玩家。")


func _on_damaged_armour_pressed() -> void:
	update_codex_context.emit(damaged_armour.icon, "临时护甲", "持续类道具
持续时间：15秒
作用：玩家激活临时护甲后，将会给玩家一点临时血量。
特性：当玩家已经有一点临时血量时拿到该道具转而加分。")


func _on_deceleration_machine_pressed() -> void:
	update_codex_context.emit(deceleration_machine.icon, "减速器", "持续类道具
持续时间：5秒
作用：玩家激活减速器后，将会在屏幕右侧生成一个减速区域，经过的陨石速度减半。
特性：当右侧已经激活一个减速区域时拿到该道具转而加分（10 * Game.difficulty_multiple）")


func _on_gravity_eliminator_pressed() -> void:
	update_codex_context.emit(gravity_eliminator.icon, "重力消除器", "持续类道具
持续时间：20秒
作用：玩家激活重力消除器后，消除玩家的重力。
提示：这时飞船将会跟随玩家点击的位置，可以长按移动飞船。")


func _on_repair_tool_pressed() -> void:
	update_codex_context.emit(repair_tool.icon, "修复工具", "一次性道具
作用：玩家激活修复工具后，修复工具将会为玩家回复一滴血。
特性：当玩家已经满血时拿到该道具转而加分。")


func _on_laser_transmiter_pressed() -> void:
	update_codex_context.emit(laser_transmiter.icon, "激光发射器", "一次性道具
作用：玩家激活激光发射器后，生成一个激光来将接触的陨石和道具销毁，并给予两倍陨石计分。
提示：激光从出现到消失时间为1.5秒。")
