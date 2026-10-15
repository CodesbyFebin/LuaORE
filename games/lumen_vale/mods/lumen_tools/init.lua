-- Tools for the LuaORE Lumen Vale game.

local S = minetest.get_translator("lumen_tools")

local function tool(name, def)
	minetest.register_tool("lumen_tools:" .. name, def)
end

tool("pick_stone", {
	description = S("Stone Pickaxe"),
	inventory_image = "default_tool_stonepick.png",
	tool_capabilities = {
		full_punch_interval = 1.2,
		max_drop_level = 1,
		groupcaps = {
			cracky = {times = {[2] = 1.6, [3] = 1.0}, uses = 20, maxlevel = 1},
		},
		damage_groups = {fleshy = 3},
	},
	groups = {pickaxe = 1},
})

tool("pick_crystal", {
	description = S("Crystal Pickaxe"),
	inventory_image = "default_tool_mesepick.png",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level = 3,
		groupcaps = {
			cracky = {times = {[1] = 2.0, [2] = 1.0, [3] = 0.5}, uses = 30, maxlevel = 3},
		},
		damage_groups = {fleshy = 5},
	},
	groups = {pickaxe = 1},
})

minetest.register_craft({
	output = "lumen_tools:pick_stone",
	recipe = {
		{"lumen_default:stone", "lumen_default:stone", "lumen_default:stone"},
		{"", "lumen_default:stone", ""},
		{"", "lumen_default:stone", ""},
	},
})

minetest.register_craft({
	output = "lumen_tools:pick_crystal",
	recipe = {
		{"lumen_default:crystal_shard", "lumen_default:crystal_shard", "lumen_default:crystal_shard"},
		{"", "lumen_tools:pick_stone", ""},
		{"", "lumen_default:stone", ""},
	},
})

minetest.register_on_newplayer(function(player)
	local inv = player:get_inventory()
	if inv == nil then
		return
	end
	inv:add_item("main", "lumen_tools:pick_stone")
	inv:add_item("main", "lumen_default:crystal 8")
end)
