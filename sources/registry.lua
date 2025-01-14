--[[

The registry is a database of hierarchical global variables that is used both internally in the engine, for 
communication between scripts and as a way to save persistent data.

]]--


-- This function needs to be called in update() or tick()
function DisablePlayerDefaultTools()
	-- This function needs to be called in  update()
	local list = ListKeys("game.tool")
	for i=1, #list do
		SetBool("game.tool."..list[i]..".enabled", false)
	end
	SetString("game.player.tool", "") -- Set initial tool to gun
end

-- TODO: THIS FUNCTION MAY BE USEFUL IN FUTURE BECAUSE I GET THE CURRENT PLAYER TOOL
-- I NEED TO CALL THIS IN TICK() OR UPDATE() TO GET THE REAL TIME TOOL
function PrintRegistryKeys(registryNode)
	local list = ListKeys(registryNode)
	for i=1, #list do 
		if registryNode == "game.player.tool" then
			--print("Tool>: " .. GetString(registryNode))
		end
	end
end

function SetLevelName(name)
    SetString("level.name", name)
end