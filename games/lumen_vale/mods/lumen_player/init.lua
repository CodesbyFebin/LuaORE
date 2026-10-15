-- Player spawn for the LuaORE Lumen Vale game.

local S = minetest.get_translator("lumen_player")

minetest.register_on_joinplayer(function(player)
	player:hud_set_flags({healthbar = true, breathbar = false, minimap = true})
	player:set_properties({
		eye_height = 1.47,
		zoom_fov = 20,
	})
	local name = player:get_player_name()
	minetest.chat_send_player(name, S("Lumen Vale. LuaORE. Mine the vein."))
end)

minetest.register_on_respawnplayer(function(player)
	player:set_pos({x = 0, y = 12, z = 0})
	return true
end)

local hand = {
	description = S("Hand"),
	wield_scale = {x = 1, y = 1, z = 2.5},
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level = 0,
		groupcaps = {
			crumbly = {times = {[2] = 3.0, [3] = 0.7}, uses = 0, maxlevel = 1},
			cracky = {times = {[3] = 4.0}, uses = 0, maxlevel = 1},
			oddly_breakable_by_hand = {times = {[1] = 3.5, [2] = 2.0, [3] = 0.7}, uses = 0},
		},
		damage_groups = {fleshy = 1},
	},
}

if minetest.override_item then
	minetest.override_item("", hand)
end
