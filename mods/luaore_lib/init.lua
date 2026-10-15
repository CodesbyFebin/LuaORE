-- Small shared library for LuaORE mods.
-- Other mods can depend on luaore_lib and call luaore.*.

luaore = rawget(_G, "luaore") or {}
_G.luaore = luaore

luaore.engine = "LuaORE"
luaore.game = "Lumen Vale"
luaore.version = "1.0.0"

function luaore.id(modname, name)
	if name == nil then
		return modname
	end
	return modname .. ":" .. name
end

function luaore.log(message)
	minetest.log("action", "[LuaORE] " .. tostring(message))
end

function luaore.give(player, item, count)
	count = count or 1
	local inv = player:get_inventory()
	if inv == nil then
		return false
	end
	return inv:add_item("main", ItemStack(item .. " " .. count))
end

function luaore.player_name(player)
	if player == nil or player.get_player_name == nil then
		return ""
	end
	return player:get_player_name()
end

function luaore.register_ore_node(modname, name, def)
	def.description = def.description or name
	def.groups = def.groups or {cracky = 2, ore = 1}
	def.is_ground_content = true
	minetest.register_node(luaore.id(modname, name), def)
end

minetest.register_chatcommand("luaore", {
	params = "",
	description = "Print the LuaORE engine name and version",
	func = function(name)
		luaore.log(name .. " asked for the engine stamp")
		return true, luaore.engine .. " " .. luaore.version .. " — " .. luaore.game
	end,
})

luaore.log("library loaded")
