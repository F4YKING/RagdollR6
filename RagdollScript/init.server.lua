-- // F4YKING - GITHUB
-- // 04 February 2024 - 20:02:32

-- // init.server.lua - RagdollScript.lua

--[[

]]

---- Variables ----
-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Ragdoll
local RagdollR6 = require(script.Parent.RagdollR6)
local Ragdolls = {}

-- RagdollRE
local RagdollRE = Instance.new("RemoteEvent")
RagdollRE.Name = "RagdollRE"; RagdollRE.Parent = ReplicatedStorage

---- Functions ----
---- Initialize ----
-- Ragdoll
RagdollRE.OnServerEvent:Connect(function(plr)
    local ragdoll = Ragdolls[plr]
    if not ragdoll then return end

    ragdoll:Toggle()
end)

Players.PlayerAdded:Connect(function(plr: Player)

    plr.CharacterAppearanceLoaded:Connect(function(char: Model)

        local humanoid: Humanoid = char:FindFirstChildWhichIsA("Humanoid")
        if not humanoid then return end

        Ragdolls[plr] = RagdollR6.new(char, true)

    end)

end)