-- // F4YKING - GITHUB
-- // 04 February 2024 - 20:02:32

-- // init.server.lua - RagdollScript.lua

--[[

]]

---- Variables ----
-- Services
local Players = game:GetService("Players")

-- Ragdoll
local RagdollR6 = require(script.Parent.RagdollR6)
local Ragdolls = {}

---- Functions ----
---- Initialize ----
-- Ragdoll
Players.PlayerAdded:Connect(function(plr: Player)

    plr.CharacterAppearanceLoaded:Connect(function(char: Model)

        local humanoid: Humanoid = char:FindFirstChildWhichIsA("Humanoid")
        if not humanoid then return end

        local ragdoll = RagdollR6.new(char, true)

    end)

end)