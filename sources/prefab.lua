#include "sources/commons/constants.lua"

Prefabs = {
    naturalSatellite = {
        name = 'natural_satellite',
        tags = 'natural_satellite',
        pos = '5.0 15.0 5.9',
        rot = "0 0 0",
        desc ="A magnific natural satellite.",
        texture = "30",
        blendtexture = "10",
        density = "100",
        strength = "100",
        collide = "true",
        prop = "false",
        size = "40 39 40",
        brush ="MOD/assets/models/moon.vox",
        material = "rock",
        pbr= "0 0 0 0",
        color = '0.72 0.12 0.32'
    },
    
    planet = {
        name = 'planet',
        tags = 'planet',
        pos = '3.0 19.0 0.9',
        rot = "0 0 0",
        desc ="A strange planet.",
        texture = "30",
        blendtexture = "10",
        density = "100",
        strength = "100",
        collide = "true",
        prop = "false",
        size = "40 39 40",
        brush ="MOD/assets/models/planet.vox",
        material = "rock",
        pbr= "0 0 0 0",
        color = '0.72 0.12 0.32'
    },

    star = {
        name = 'star',
        tags = 'star',
        pos = '9.4 10.0 -6.4',
        rot = "0.3 0.3 0.4",
        desc ="A beautiful star.",
        texture = "20",
        blendtexture = "15",
        density = "100",
        strength = "100",
        collide = "false",
        prop = "false", -- allows to create a dynamic body
        size = "40 39 40",
        brush ="MOD/assets/models/star.vox",
        material = "rock",
        pbr= "0 0 0 32",
        color = '0.5 0.5 0.5',
    },

    asteroid = {
        name = 'asteroid',
        tags = 'asteroid',
        pos = '0.0 1.0 1.0',
        rot = "0 0 0",
        desc ="A fast asteroid.",
        texture = "5",
        blendtexture = "6",
        density = "10",
        strength = "10",
        collide = "true",
        prop = "true", -- allows to create a dynamic body
        size = "40 39 40",
        brush ="MOD/assets/models/asteroid.vox",
        material = "rock",
        pbr= "0 0 0 0",
        color = '0.5 0.5 0.5',
    }, 

    Particles = {
        nebulosa = {
            name = 'nebulosa',
            pos = {0, 1, 0},
            velocity = {1, 5, -1},
            duration = 1.0, 
            collide = 1, -- 0 or 1
            emissive = 10,
            alpha = {0.2, 0.2},
            rotation = 4,
            color1 = {1, 1, 0},
            color2 = {1, 0, 0},
            tile = 5 -- 5 fire or 0 smoke
        },

        giantStar = {
            name = 'giantStar',
            pos = {0, 1, 0},
            velocity = {1, 5, -1},
            duration = 1.0, 
            collide = 1, -- 0 or 1
            emissive = 10,
            alpha = {0.2, 0.2},
            rotation = 4,
            color1 = {1, 1, 0},
            color2 = {1, 0, 0},
            tile = 5 -- 5 fire or 0 smoke
        }
    }
}

-- TODO: Refactor this trash
function CreateXMLPrefab(properties, debug)
    local xmlTable = {  }
    count = 0;

    -- FOR VOX 
    for key, value in pairs(properties) do
        if (tostring(key) == 'type' and tostring(value) == 'vox') then
            count = count + 1
            if (tostring(key) == 'type') then
                xmlTable[1] = '<' .. value .. ''
            elseif (tostring(key) == 'name') then
                xmlTable[2] = " " .. key .. '=' .. '"' .. value .. '" '
            else
                -- CHECK IF THE NEXT KEY IS EQUAL NIL (THE LAST IN ARRAY)
                if next(properties, key) == nil then
                    xmlTable[count] = " " .. key .. '=' .. '"' .. value .. '"/>'
                else
                    xmlTable[count] = " " .. key .. '=' .. '"' .. value .. '" '
                end
            end 
        end
    end

    -- FOR VOXBOX 
    for key, value in pairs(properties) do
        if (tostring(key) == 'type' and tostring(value) == 'voxbox') then
            xmlTable[1] = '<' .. value .. ''
        elseif (tostring(key) == 'name') then
            xmlTable[2] = " " .. key .. '=' .. '"' .. value .. '" '
        else
            count = count + 1
            if next(properties, key) == nil then
                xmlTable[count] = " " .. key .. '=' .. '"' .. value .. '"/>'
            else
                xmlTable[count] = " " .. key .. '=' .. '"' .. value .. '" '            
            end
        end
    end

    if debug then
        DebugPrint("::::::: XML STRUCTURE for " .. tostring(properties['name']) .. ":::::::\n")
        DebugPrint(dump(xmlTable))
        DebugPrint("XML created.")
        DebugPrint(":::::::::::::::::::::\n")
    end
    return xmlTable -- Return the table
end

function SpawnPrefab(properties, debug)
    local xmlProperties = CreateXMLPrefab(properties)
    local xmlCombined = table.concat(xmlProperties, "") -- Convert into a string

    local prefabCoord = GetTableValuesFromProperties(properties, 'pos')
    Spawn(xmlCombined, Transform(Vec(prefabCoord[1], prefabCoord[2] , prefabCoord[3])), true, true)
	 --Spawn(xmlCombined, Transform(Vec(-9.4, 0.0 , -9.4)))
    if debug then
        DebugPrint("::::::: PREFAB COORD :::::::\n")
        DebugPrint(dump(prefabCoord))
        DebugPrint(":::::::::::::::::::::\n")
        DebugPrint("::::::: FEEDBACK :::::::\n")
        DebugPrint("XML full string: " .. xmlCombined)
        DebugPrint("Prefab [" .. string.upper(properties.name)  .. "] spawned.")
    end
end

--[[ 
-- Get Spawn Coordinates from prefab table (DEPRECATED)
function GetTableValuesFromProperties(properties, key)
    local values = {  }
    -- DebugPrint("[+] GetTableValuesFromProperties: " ..dump(properties))
    for k, v in pairs(properties) do
        if k == key then
            for num in v:gmatch("%S+") do -- Use gmatch "%S+" regex pattern to separate float numbers
                table.insert(values, num)
            end
        end
    end
    return values
end
]]--

-- Spawn object according to the player's position (DEPRECATED) SEE CalcSpawnPosWithOffset
-- TODO: Refactor this trash
function SpawnObjectAccordingPlayerPos(object, xOffset, yOffset, zOffset, isXmlFile)
    DebugPrint(":::::::: SpawnObjectAccordingPlayerPos :::::::::")
    local pPos = GetPlayerTransform().pos
    local newPosX, newPosY, newPosZ

    -- POS X
    if pPos[1] >= 2 then
        newPosX = pPos[1] * xOffset
    else -- minor than zero
        newPosX = pPos[1] + xOffset
    end

    -- POS Y
    if pPos[2] >= 2 then
        newPosY = pPos[2] * yOffset
    else -- minor than zero
        newPosY = pPos[2] + yOffset
    end

    -- POS Z
    if pPos[3] >= 2 then
        newPosZ = pPos[3] * zOffset
    else -- minor than zero
        newPosZ = pPos[3] + zOffset
    end
    
    if isXmlFile then
        Spawn(object, Transform(Vec(newPosX, newPosY , newPosZ)), true, true)
    else
        object.pos = tostring(newPosX) .. " " .. tostring(newPosY) .. " " .. tostring(newPosZ) .. " " 
        DebugPrint(">> SPAWNED PREFAB " .. object.name .. " POS: " ..  object.pos)
        SpawnPrefab(object)
    end

    DebugPrint("::::::::::::::::::::::::::")
end

function RandomPrefabProperty(property)
    local num, max;
    local min = 0;
    if (property == 'blendtexture') then -- Range of 0-15
        max = 15
    elseif (property == 'texture') then -- Range of 0-31
        max = 31
    end
    num = math.random(min, max); 
    return tostring(num);
end

function RandomizeObjectPosition(objectPos, distanceDivider)
    local worldWidth = CONSTANTS.WORLD.SIZE.WIDTH - 100; -- This magic numbers are safe offsets to spawn
    local worldHeight = CONSTANTS.WORLD.SIZE.HEIGHT - 40;
    local worldDepth = CONSTANTS.WORLD.SIZE.DEPTH - 100;
    local playerPos;
    local randomObjectPos;

    -- If the objectPos passed as param is a string prefab we need to convert them.
    if type(objectPos) == 'string' then
        print("\n[+] function() RandomizeObjectPosition() | ObjectPos is a 'string': " .. objectPos)
        objectPos = ConvertStrToTable(objectPos) -- Return pos as integers
        print("\n[+] function() RandomizeObjectPosition() | ObjectPos Converted to Table: " .. dump(objectPos))
    elseif type(objectPos) == 'table' then
        print("\nobjectPos is a table. No convertion needed.")
    else
        --print("RandomizeObjectPosition Error: the object pos is not an string or table.")
    end
    --print("NEW RandomizeObjectPosition OBJECTPOS: " .. dump(objectPos))

    randomObjectPos = CalcSpawnPosWithOffset(objectPos, { worldWidth, worldHeight, worldDepth }, distanceDivider)
    print("\n[+] function() RandomizeObjectPosition() | randomObjectPos = CalcSpawnPosWithOffset: " .. dump(randomObjectPos))

    -- Get player pos - Sum of Pos + Qeuler Y = 1 to point to center of player
    playerPos = VecAdd(GetPlayerTransform().pos, Vec(0, 1, 0))

    -- return the sun of two vectors = vector/table with 3 of size
    print("\n[+] function() RandomizeObjectPosition() | Return value " .. dump(VecAdd(playerPos, randomObjectPos)))
    return VecAdd(playerPos, randomObjectPos);
end

--[[
CalcSpawnPosWithOffset

This function may be have some problems:

    objectPos = table
    - The X axis has a strange behavior. Like range numbers above
    the normal (world width). It's can be the random seed, the time or
    the logic. I don't know

]]--

-- oriPos = original pos
function CalcSpawnPosWithOffset(objectPos, wordLength, distanceDivider)
    distanceDivider = distanceDivider or 1.5; -- Provides a default value if user not privader
    local axisOffset; -- random multipliers
    local axes = {  }; -- Axes table contains X,Y,Z axis
    local newObjectSpawnPos = {  }

    print("CalcSpawnPosWithOffset() : distanceDivider: " .. distanceDivider)

    for i=1, #objectPos do
        --print(">>> objectPos[i] type: " .. type(objectPos[i]), objectPos[i])
        -- if the axis value is in world range (width, height or depth)
        if (objectPos[i] >= (math.abs(wordLength[i])*-1) and objectPos[i] <= wordLength[i]) then
            print("CalcSpawnPosWithOffset() :" .. objectPos[i]  .. " is IN world axis range.")
            -- If the value is in world range, then, you need to
            -- calculate the multiplier

            math.randomseed(math.random(1, wordLength[i]))
            --print(math.random())
            --print(math.random())
            --print(math.random())

            -- Set custom behaviors for world measures (width, height, depth)
            local worldArea;
            if i == 1 then -- calculate base area
                -- NOTE: YOU NEED TO DIVIDE BY 2 BEACOUSE DE (0, 0 ,0) STARS IN THE MIDDLE.
                -- SEE DOCS FOLDER TO MORE INFO
                worldArea = CalculateCubeBaseArea(wordLength[i]) / distanceDivider
            elseif i == 2 then -- calculate side(edge) area
                worldArea = CalculateCubeLateralArea(wordLength[i]) / distanceDivider
            else -- calculate base area (?)
                worldArea = CalculateCubeBaseArea(wordLength[i]) / distanceDivider
            end
            axisOffset = math.random(1, worldArea) -- o y deve ser o resultado da area da cena
            table.insert(axes, axisOffset)
        else
            print("CalcSpawnPosWithOffset() :" ..objectPos[i]  ..  " is out of world range")
            -- If the value is out of range, then you must be recalculate this. May i be use recursion?
            local newAxisValue = math.random(math.abs(wordLength[i])*-1, wordLength[i])
            --print("newAxisValue: " ..newAxisValue)
            objectPos[i] = newAxisValue
            --print("so the value is positive too: " .. objectPos[i])
            -- Now i need to check if the newAxisValue is negative or positive
            -- to apply the multiplier

            -- If the number is negative, i only use math.random negative numbers
            if (objectPos[i] < 0) then -- Check if is negative
                --print("Yes, its is negative.")
                -- For now, i wnat to make the multiplier hardcoded without an smart logic
                
                -- Since the TEARDOWN API doen'st allow to use 'os' you 
                -- need to use the GetTime() function, but if you are
                -- running some test, you need to use os.time()

                --math.randomseed(time)
                axisOffset = math.random(-2, -1)-- Can't use 0
                --print("axisOffset: " .. axisOffset)
                table.insert(axes, axisOffset)
            else
                --print("No, its is positive.")
                -- Or, if the newAxisValue is positive, than just make the same 
                -- but with positive numbers
                -- math.randomseed(time)
                axisOffset = math.random(1, 2) -- Reverse 
                --print("axisOffset: " .. axisOffset)
                table.insert(axes, axisOffset)
            end
        end
        --table.insert(axes, axisOffset[i])
    end

    -- Multiplier position by random generated offset
    for i=1, #objectPos do
        objectPos[i] = objectPos[i] * axes[i]
        table.insert(newObjectSpawnPos, objectPos[i])
    end
    --print("New Spawn Position for Object (with offset applied): " .. dump(newObjectSpawnPos))
    -- Need to return Vec(x, y, z)/{ x, y, z } (a table with 3 values)
    return axes;
end