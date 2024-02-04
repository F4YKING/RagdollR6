-- // F4YKING - GITHUB
-- // 04 February 2024 - 19:05:24

-- // init.lua - RagdollR6.lua

--[[

]]

---- Variables ----
-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Trove
local Trove = require(script.Parent.Trove)

-- Modules
local LimbTree = require(script.LimbTree)
local AttachmentData = require(script.AttachmentData)
local BallSocketData = require(script.BallSocketData)

---- Initialize ----
-- RagdollR6
local RagdollR6: RagdollR6 = {}; export type RagdollR6 = typeof(RagdollR6.new())
RagdollR6.__index = RagdollR6

-- New
function RagdollR6.new(char: Model)
    local self = setmetatable({}, RagdollR6)
    self._trove = Trove.new()

    self.Character = char
    self.Humanoid = (char and char:FindFirstChildWhichIsA("Humanoid")) :: Humanoid?

    self.HumanoidRootPart = (char and char:FindFirstChild("HumanoidRootPart")) :: Part?

    self.Atts = {}
    self.Accessories = {}

    self:Init(); return self
end

function RagdollR6:Init()

    if not self:Checks() then self:Stop(true); return end
    self._trove:AttachToInstance(self.Character); print(self)

    self.Humanoid.BreakJointsOnDeath = false

end

function RagdollR6:Checks()
    if self.Character == nil then return end

    return self.Character and self.Humanoid and self.HumanoidRootPart
end

-- Ragdoll
function RagdollR6:Start()

    if not self:Checks() then self:Stop(true); return end

    -- self.HumanoidRootPart.CanCollide = false

    self.Humanoid:ChangeState(Enum.HumanoidStateType.Ragdoll)


end

-- Stop / Destroy
function RagdollR6:Stop( forever: boolean? )
    
end

return RagdollR6