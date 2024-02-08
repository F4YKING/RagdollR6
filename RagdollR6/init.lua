-- // F4YKING - GITHUB
-- // 04 February 2024 - 19:05:24

-- // init.lua - RagdollR6.lua

--[[
    [08 February 2024 - 14:21:04]
    - Thanks for @CompletedLoop (roblox) for the codes
    - https://devforum.roblox.com/t/2413582
]]

---- Variables ----
-- Service
local Players = game:GetService("Players")

-- Trove
local Trove = require(script.Parent.Trove)

-- Modules
local AttachmentCFrames = require(script.AttachmentCFrames)
local BallSocketConf = require(script.BallSocketConf)

---- Initialize ----
-- RagdollR6
local RagdollR6: RagdollR6 = {}; export type RagdollR6 = typeof(RagdollR6.new())
RagdollR6.__index = RagdollR6

-- New
function RagdollR6.new(char: Model, ragdollWhenDie: boolean?)
    local self = setmetatable({}, RagdollR6)
    self._trove = Trove.new()

    self.Character = char
    self.Humanoid = (char and char:FindFirstChildWhichIsA("Humanoid")) :: Humanoid?

    self.Torso = (char and char:FindFirstChild("Torso")) :: Part?
    self.HumanoidRootPart = (char and char:FindFirstChild("HumanoidRootPart")) :: Part?

    self.Ragdolling = false
    self.RagdollWhenDie = ragdollWhenDie

    self.Motor6Ds = {}

    self:Init(); return self
end

function RagdollR6:Init()

    if not self:Checks() then self:Destroy(); return end
    self._trove:AttachToInstance(self.Character)

    self.Humanoid.BreakJointsOnDeath = false
    -- self.Humanoid.RequiresNeck = false

    if self.RagdollWhenDie then

        local healthConn: RBXScriptConnection
        healthConn = self.Humanoid.HealthChanged:Connect(function(nVal: number)
            if nVal > 0 then return end
            healthConn:Disconnect(); self:Start()
        end)

    end

end

function RagdollR6:Checks()

    if self.Character == nil then return end

    return self._trove~=nil
    and self.Character
    and self.Humanoid
    and self.Humanoid.RigType == Enum.HumanoidRigType.R6
    and self.HumanoidRootPart
    and self.Torso

end

-- Ragdoll
function RagdollR6:Start()

    if self.Ragdolling then return end
    if not self:Checks() then self:Stop(true); return end

    self.Ragdolling = true
    self:ReplaceJoints()

end

function RagdollR6:CreateColliderPart(part: Part)

    if not part then return end

    local colliderPart: Part = self._trove:Add(Instance.new("Part"))
    colliderPart.Name =  "ColliderPart"

    colliderPart.Massless = true
    colliderPart.Transparency = 1

    colliderPart.Size = part.Size/1.7
    colliderPart.CFrame = part.CFrame

    local weldConst: WeldConstraint = Instance.new("WeldConstraint")
    weldConst.Part0 = colliderPart
    weldConst.Part1 = part

    weldConst.Parent = colliderPart
    colliderPart.Parent = part

end

function RagdollR6:ReplaceJoints()

    for _, motor: Motor6D in pairs(self.Character:GetDescendants()) do

        if not motor:IsA("Motor6D") then continue end
        if not AttachmentCFrames[motor.Name] then continue end

        motor.Enabled = false

        local att0: Attachment = self._trove:Add(Instance.new("Attachment"))
        local att1: Attachment = self._trove:Add(Instance.new("Attachment"))
        att0.CFrame = AttachmentCFrames[motor.Name][1]
        att1.CFrame = AttachmentCFrames[motor.Name][2]

        att0.Name = "RagdollAttachment"
        att1.Name = "RagdollAttachment"

        self:CreateColliderPart(motor.Part1)

        local ballSocket: BallSocketConstraint = BallSocketConf[motor.Name~="Neck" and 1 or 2]:Clone()
        ballSocket.Attachment0 = att0
        ballSocket.Attachment1 = att1

        att0.Parent = motor.Part0
        att1.Parent = motor.Part1

        ballSocket.Parent = motor.Parent
        self.Motor6Ds[motor.Name] = motor

    end

    self.Humanoid.AutoRotate = false

    -- if self.Humanoid.Health > 0 then
    --     self.HumanoidRootPart:SetNetworkOwner(nil); task.wait()
    --     self.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, false)
    -- end

end

-- Stop / Destroy
function RagdollR6:Stop( forever: boolean? )

    for name: string, motor6D: Motor6D in pairs(self.Motor6Ds) do
        motor6D.Enabled = true
        self.Motor6Ds[name] = nil
    end

    -- if self.Humanoid.Health > 0 then
    --     self.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, true); task.wait()
    --     self.HumanoidRootPart:SetNetworkOwner(Players:GetPlayerFromCharacter(self.Character))
    -- end

    self._trove:Destroy()
    self._trove = if not forever then Trove.new() else nil

    self.Humanoid.AutoRotate = true
    self.Ragdolling = false

end

function RagdollR6:Destroy()
    self:Stop(true)
end

-- Misc
function RagdollR6:Toggle()

    if self.Ragdolling then
        self:Stop()
    else
        self:Start()
    end

end

return RagdollR6