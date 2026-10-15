local storage=minetest.get_mod_storage()
local state={phase="LOBBY_READY_UP",players={},end_at=0,digs={}}
local function persist()
 storage:set_string("match",minetest.serialize(state))
end
local function load()
 local ok,s=pcall(minetest.deserialize,storage:get_string("match"))
 if ok and type(s)=="table" and type(s.players)=="table" then
  state=s
  if state.phase=="ACTIVE_HUNT" then
   state={phase="LOBBY_READY_UP",players={},end_at=0,digs={}}
  end
 end
end
load()
local function standings()
 local list={}
 for name,p in pairs(state.players) do list[#list+1]={name=name,score=p.score or 0} end
 table.sort(list,function(a,b) if a.score==b.score then return a.name<b.name end return a.score>b.score end)
 return list
end
local function finish()
 if state.phase~="ACTIVE_HUNT" then return end
 state.phase="POST_ROUND_VERIFICATION"
 local list=standings()
 local winner=list[1]
 if winner then
  storage:set_int("wins:"..winner.name,storage:get_int("wins:"..winner.name)+1)
  minetest.chat_send_all("[OreBunker] Winner: "..winner.name.." with "..winner.score.." points")
 else minetest.chat_send_all("[OreBunker] Round complete. No participants.") end
 persist()
end
minetest.register_chatcommand("obready",{
 description="Ready for 60-second Ore Hunt (minimum two players)",
 func=function(name)
  if state.phase=="ACTIVE_HUNT" then return false,"Match already active" end
  if state.phase=="POST_ROUND_VERIFICATION" then
   state={phase="LOBBY_READY_UP",players={},end_at=0,digs={}}
  end
  local count=0
  for _ in pairs(state.players) do count=count+1 end
  if count>=25 and not state.players[name] then return false,"Lobby full" end
  state.players[name]={score=0,ready=true}
  count=0
  for _ in pairs(state.players) do count=count+1 end
  if count>=2 then
   state.phase="ACTIVE_HUNT";state.end_at=minetest.get_gametime()+60;state.digs={}
   minetest.chat_send_all("[OreBunker] ORE Hunt started! 60 seconds in the 48x48 arena centered at origin.")
  end
  persist()
  return true,"Ready in lobby ("..count.."/25)"
 end
})
minetest.register_chatcommand("obscore",{
 description="Show match score, wins and phase",
 func=function(name)
  local player=state.players[name]
  local score=player and player.score or 0
  return true,"Phase: "..state.phase.." | Score: "..score..
   " | Wins: "..storage:get_int("wins:"..name)
 end
})
minetest.register_on_dignode(function(pos,node,digger)
 if state.phase~="ACTIVE_HUNT" or not digger or not digger:is_player() then return end
 if minetest.get_gametime()>=state.end_at then finish();return end
 local name=digger:get_player_name()
 if not state.players[name] then return end
 if pos.x < -24 or pos.x >=24 or pos.z < -24 or pos.z >=24 then return end
 local key=pos.x..":"..pos.y..":"..pos.z
 if state.digs[key] then return end
 local score=({["ob_core:ore"]=25,["ob_core:solana"]=25,
  ["ob_core:diamond"]=25,["ob_core:coal"]=3,["ob_core:stone"]=1})[node.name]
 if not score then return end
 state.digs[key]=true
 state.players[name].score=state.players[name].score+score
 persist()
 minetest.chat_send_player(name,"+"..score.." | Total: "..state.players[name].score)
end)
local timer=0
minetest.register_globalstep(function(dt)
 timer=timer+dt
 if timer<0.25 then return end
 timer=0
 if state.phase=="ACTIVE_HUNT" and minetest.get_gametime()>=state.end_at then finish() end
end)
