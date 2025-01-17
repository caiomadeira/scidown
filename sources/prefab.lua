#include "sources/commons/constants.lua"


Level = {
    planet = {
        name = "planet1",
        prefab = "MOD/planet1.xml"
    }
}


Building = {

    planet = {
        ground = {
            type = "voxbox",
            name = "planet_ground",
            tags = "planet_ground",
            pos = "0.0 0.0 -500.0",
            rot = "0.0 0.0 0.0",
            desc ="",
            texture = "15",
            blendtexture = "2",
            density = "100",
            strength = "100",
            size = "1000 5 1000",
            collide = "true",
            prop = "true",
            brush = "",
            material = "dirt",
            pbr= "0 0 0 0",
            color = "0.91 0.52 0.14"
        }
    },

    safehouse = {
        base = {
            type = "voxbox",
            name = "safehouse",
            tags = "safehouse",
            pos = "1.0 4.0 2.0",
            rot = "0.0 0.0 0.0",
            desc ="A safehouse",
            texture = "15",
            blendtexture = "2",
            density = "100",
            strength = "100",
            size = "128 90 128",
            collide = "true",
            prop = "false",
            brush = "MOD/assets/vox/world/safehouse/safehouse.vox",
            material = "heavymetal",
            pbr= "0 0 0 0",
            color = "0.5 0.5 0.5"
        },

        ground = {
            type = "voxbox",
            name = "safehouse",
            tags = "safehouse",
            pos = "0.0 0.0 0.0",
            rot = "0.0 0.0 0.0",
            desc ="A safehouse",
            texture = "5",
            blendtexture = "10",
            density = "100",
            strength = "100",
            size = "185 80 184",
            collide = "true",
            prop = "false",
            brush = "MOD/assets/vox/world/safehouse/safehouse_ground.vox",
            material = "heavymetal",
            pbr= "0 0 0 0",
            color = "0.5 0.5 0.5"
        },

        tube = {
            type = "voxbox",
            name = "safehouse",
            tags = "safehouse",
            pos = "-5.2 0.0 -20.3",
            rot = "0.0 0.0 0.0",
            desc ="A safehouse",
            texture = "10",
            blendtexture = "10",
            density = "10",
            strength = "10",
            size = "128 90 128",
            collide = "true",
            prop = "false",
            brush = "MOD/assets/vox/world/safehouse/safehouse_tubes.vox",
            material = "heavymetal",
            pbr= "1 1 1 32",
            color = "0.5 0.5 0.5"
        },

    },


}

Prefabs = {
    naturalSatellite = {
        type = "voxbox",
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
        brush ="MOD/assets/vox/world/satellites/moon1.vox", -- provides an default vox file
        material = "rock",
        pbr= "0 0 0 0",
        color = '0.72 0.12 0.32'
    },
    
    planet = {
        type = "voxbox",
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
        brush ="MOD/assets/vox/world/planets/dwarf_planet.vox",
        material = "rock",
        pbr= "0 0 0 0",
        color = '0.72 0.12 0.32'
    },

    star = {
        type = "voxbox",
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
        size = "40 40 40",
        brush ="MOD/assets/vox/world/stars/star1.vox",
        material = "rock",
        pbr= "0 0 0 32",
        color = '0.5 0.5 0.5',
    },

    asteroid = {
        type = "voxbox",
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
        brush ="MOD/assets/vox/world/asteroids/asteroid1.vox",
        material = "rock",
        pbr= "0 0 0 0",
        color = '0.5 0.5 0.5',
    }, 

    blackHole = {
        type = "voxbox",
        name = 'black_hole',
        tags = 'black_hole',
        pos = '1.0 5.0 1.0',
        rot = "0 0 0",
        desc ="Stay away from this!",
        texture = "0",
        blendtexture = "0",
        density = "100",
        strength = "100",
        collide = "false",
        prop = "false",
        size = "256 256 256",
        brush ="MOD/assets/vox/world/black_holes/big_blackhole.vox",
        material = "unphysical",
        pbr= "0 0 0 10",
        color = '0.0 0.0 0.0'
    },
}

function RandomizePrefabProperty(property, tdPropertyPreset)
    tdPropertyPreset = tdPropertyPreset or {  }
    local num, max;
    local min = 0;
    if (property == 'blendtexture') then -- Range of 0-15
        max = 15
        num = math.random(min, max); 

    elseif (property == 'texture') then -- Range of 0-31
        max = 31
        num = math.random(min, max); 

    elseif (property == 'pbr') then
        min = 10
        max = 32
        num = math.random(min, max)
        num = "0 0 0 " .. num
        --print("> RandomizePrefabProperty() - pbr: ", num)

    elseif (property == 'material' or property == 'brush') then
        local randomIndex = math.random(1, #tdPropertyPreset)
        num = tdPropertyPreset[randomIndex]
        --print("> RandomizePrefabProperty() - [" .. property .. "]: ", num)
    end
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
        --print("\n[+] function() RandomizeObjectPosition() | ObjectPos is a 'string': " .. objectPos)
        objectPos = ConvertStrToTable(objectPos) -- Return pos as integers
        --print("\n[+] function() RandomizeObjectPosition() | ObjectPos Converted to Table: " .. dump(objectPos))
    elseif type(objectPos) == 'table' then
        --print("\nobjectPos is a table. No convertion needed.")
    else
        --print("RandomizeObjectPosition Error: the object pos is not an string or table.")
    end
    --print("NEW RandomizeObjectPosition OBJECTPOS: " .. dump(objectPos))

    randomObjectPos = CalcSpawnPosWithOffset(objectPos, { worldWidth, worldHeight, worldDepth }, distanceDivider)
    --print("\n[+] function() RandomizeObjectPosition() | randomObjectPos = CalcSpawnPosWithOffset: " .. dump(randomObjectPos))

    -- Get player pos - Sum of Pos + Qeuler Y = 1 to point to center of player
    playerPos = VecAdd(GetPlayerTransform().pos, Vec(0, 1, 0))

    -- return the sun of two vectors = vector/table with 3 of size
    --print("\n[+] function() RandomizeObjectPosition() | Return value " .. dump(VecAdd(playerPos, randomObjectPos)))
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

    --print("CalcSpawnPosWithOffset() : distanceDivider: " .. distanceDivider)

    for i=1, #objectPos do
        --print(">>> objectPos[i] type: " .. type(objectPos[i]), objectPos[i])
        -- if the axis value is in world range (width, height or depth)
        if (objectPos[i] >= (math.abs(wordLength[i])*-1) and objectPos[i] <= wordLength[i]) then
            --print("CalcSpawnPosWithOffset() :" .. objectPos[i]  .. " is IN world axis range.")
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
           -- print("CalcSpawnPosWithOffset() :" ..objectPos[i]  ..  " is out of world range")
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

function CreateXMLPrefab(prefabProperties)
    local base; 
    local scale = 1;

    -- CHECK IF PREFAB PROPERTIES IS MASSIVE_PLANET 
    -- MASSIVE_PLANET ONLY CAN BE OF <VOX/> TYPE 
    if (prefabProperties.brush == CONSTANTS.VOX.WORLD.PLANETS.MASSIVE_PLANET) then
        --print("[!] function() Create XML Prefab | IT'S A MASSIVE_PLANET")
        prefabProperties.type = 'vox'
        scale = 4;
    end

    if (prefabProperties.type == 'voxbox') then
        base = "<" .. prefabProperties.type .. " " ..
        "name=" .. "'".. prefabProperties.name .. "'" .. " " ..
        "tags=" .. "'".. prefabProperties.tags .. "'" .. " " ..
        "pos=" .. "'".. prefabProperties.pos .. "'" .. " " ..
        "rot=" .. "'".. prefabProperties.rot .. "'" .. " " ..
        "desc=" .. "'".. prefabProperties.desc .. "'" .. " " ..
        "texture=" .. "'".. prefabProperties.texture .. "'" .. " " ..
        "blendtexture=" .. "'".. prefabProperties.blendtexture .. "'" .. " " ..
        "density=" .. "'".. prefabProperties.density .. "'" .. " " ..
        "strength=" .. "'".. prefabProperties.strength .. "'" .. " " ..
        "collide=" .. "'".. prefabProperties.collide .. "'" .. " " ..
        "prop=" .. "'".. prefabProperties.prop .. "'" .. " " ..
        "size=" .. "'".. prefabProperties.size .. "'" .. " " ..
        "brush=" .. "'".. prefabProperties.brush .. "'" .. " " ..
        "material=" .. "'".. prefabProperties.material .. "'" .. " " ..
        "pbr=" .. "'".. prefabProperties.pbr .. "'" .. " " ..
        "color=" .. "'" .. prefabProperties.color .. "'" ..
        " />"
    -- Later, put some random id generated by function
    -- 	<vox id_="1538158208" 
    elseif (prefabProperties.type == 'vox') then
        base = "<" .. prefabProperties.type .. " " ..
        "name=" .. "'".. prefabProperties.name .. "'" .. " " ..
        "tags=" .. "'".. prefabProperties.tags .. "'" .. " " ..
        "pos=" .. "'".. prefabProperties.pos .. "'" .. " " ..
        "rot=" .. "'".. prefabProperties.rot .. "'" .. " " ..
        "desc=" .. "'".. prefabProperties.desc .. "'" .. " " ..
        "texture=" .. "'".. prefabProperties.texture .. "'" .. " " ..
        "blendtexture=" .. "'".. prefabProperties.blendtexture .. "'" .. " " ..
        "density=" .. "'".. prefabProperties.density .. "'" .. " " ..
        "strength=" .. "'".. prefabProperties.strength .. "'" .. " " ..
        "collide=" .. "'".. prefabProperties.collide .. "'" .. " " ..
        "prop=" .. "'".. prefabProperties.prop .. "'" .. " " ..
        "scale=" .. "'".. prefabProperties.size .. "'" .. " " ..
        "scale=" .. "'".. scale .. "'" .. " " ..
        "file=" .. "'".. prefabProperties.brush .. "'" .. " " .. -- file == brush
        "pbr=" .. "'".. prefabProperties.pbr .. "'" .. " " ..
        "color=" .. "'" .. prefabProperties.color .. "'" ..
        " />"

    -- <environment template="sunset"/>
    elseif (prefabProperties.type =='environment') then
        base = "<" .. prefabProperties.type .. " " ..
        "name=" .. "'".. prefabProperties.name .. "'" .. " " ..
        "tags=" .. "'".. prefabProperties.tags .. "'" .. " " ..
        "template=" .. "'".. prefabProperties.template .. "'" .. " " ..
        "skybox=" .. "'".. prefabProperties.skybox .. "'" .. " " ..
        "skyboxtint=" .. "'".. prefabProperties.skyboxtint .. "'" .. " " ..
        "skyboxbrightness=" .. "'".. prefabProperties.skyboxbrightness .. "'" .. " " ..
        "ambient=" .. "'".. prefabProperties.ambient .. "'" .. " " ..
        "ambientexponent=" .. "'".. prefabProperties.ambientexponent .. "'" .. " " ..
        "fogcolor=" .. "'".. prefabProperties.fogcolor .. "'" .. " " ..
        "fogParams=" .. "'".. prefabProperties.fogParams .. "'" .. " " ..
        "sunBrightness=" .. "'".. prefabProperties.sunBrightness .. "'" .. " " ..
        "sunColorTint=" .. "'".. prefabProperties.sunColorTint .. "'" .. " " ..
        "sunFogScale=" .. "'".. prefabProperties.sunFogScale .. "'" .. " " ..
        "sunGlare=" .. "'".. prefabProperties.sunGlare .. "'" .. " " ..
        "brightness=" .. "'".. prefabProperties.brightness .. "'" .. " " .. -- file == brush
        "nightlight=" .. "'".. prefabProperties.nightlight .. "'" .. " " ..
        "fogscale=" .. "'" .. prefabProperties.fogscale .. "'" ..
        " />"
    else 
        --print("[x] function() CreateXMLPrefab() | ERROR: The type of vox is not provided. ")
    end
    --print("xml created: ", base)
    return base;
end

--[[

---------------------------------------------
-- PREFAB SHAPE AND BODY FUNCTIONS
---------------------------------------------

CreateBodyForShape(prefabProperties) - Create a body 
for shape and activated if is dynamic (can movemment)

]]--

function CreateBodyForShape(tag)
    -- CREATE A BODY FOR SHAPE AND CHECK IF IS IsBodyActive
    -- For performance reasons, bodies that don't move are taken out of the simulation. 
    local handleShape = FindShape(tag, true)
    local handleShapeBody = GetShapeBody(handleShape) -- For some reason, the body is not created
    if handleShapeBody ~=0 then
        -- print("body for " .. tag .. " found with handle: ", handleShapeBody)
        SetTag(handleShapeBody, tag)
        --print("Tag setted? ", HasTag(handleShape, tag))
        --if IsBodyActive(handleShapeBody) then
            --print("Body is active.")
        --else
            --print("Body is NOT active.")
            --SetBodyDynamic(handleShapeBody, false)
            --print("Now, is body dinamic? ", IsBodyActive(handleShapeBody))
       -- end
    else 
        -- print("body for " .. tag .. " not found. ", handleShapeBody)
    end
    return handleShape;
end

-- Return a feedback of the shape creation
function HasShapeCreated(handleShape, prefabProperties, prefabXml)
   -- Check if the object has CREATED (shape and body) and gives a feedback if debug is active
   if handleShape ~= 0 then
        -- Print formated prefab xml properties 
        --print(":::::::::::::: PREFAB [" .. string.upper(prefabProperties.name)  .. "] CREATED :::::::::::::::::::")
        for p in prefabXml:gmatch("%S+") do
            if string.find(p, "<") or string.find(p, "/>") then
                --print(p)
            else
                --print("\t", p)
            end
        end
    else
        --print("XXXXXXXXXXXXX PREFAB [" .. string.upper(prefabProperties.name)  .. "] NOT CREATED XXXXXXXXXXXXX")
    end
end