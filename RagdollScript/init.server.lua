-- F4YKING - Github
-- 22 September 2023

--[[
    This is an example on how you can use RagdollR6 Module.
]]

---- Variables ----
-- Services
local Players = game:GetService("Players")

-- Ragdoll
local RagdollR6 = require(script.Parent.RagdollR6)

local Ragdolls = {}

---- Initialize ----
-- PlayerAdded
Players.PlayerAdded:Connect(function(plr: Player)

    Ragdolls[plr] = RagdollR6.new(plr)

    plr.CharacterAppearanceLoaded:Connect(function(char: Model)

        local hum: Humanoid = char.Humanoid

        hum.BreakJointsOnDeath = false
        hum.RequiresNeck =  false

        Ragdolls[plr]:Init(char)

        hum.Died:Connect(function()
            Ragdolls[plr]:Start()
        end)

    end)


end)