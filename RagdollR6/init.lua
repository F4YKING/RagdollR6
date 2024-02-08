-- // F4YKING - GITHUB
-- // 04 February 2024 - 19:05:24

-- // init.lua - RagdollR6.lua

--[[

]]

---- Variables ----
-- Services
local DataStoreService = game:GetService("DataStoreService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Trove
local Trove = require(script.Parent.Trove)

-- Modules
local LimbTree = require(script.LimbTree)
local AttachmentConf = require(script.AttachmentConf)
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

    self.Limbs = {}
    self.Atts = {}

    self.Motor6D = nil :: Motor6D?

    self:Init(); return self
end

function RagdollR6:Init()

    if not self:Checks() then self:Stop(true); return end
    self._trove:AttachToInstance(self.Character); print(self)

    self.Humanoid.BreakJointsOnDeath = false

    if self.RagdollWhenDie then

        local humConn: RBXScriptConnection
        humConn = self.Humanoid.HealthChanged:Connect(function(nVal: number)
            print(nVal)
            if nVal > 0 then return end
            self:Start(); humConn:Disconnect()
        end)

    end

end

function RagdollR6:Checks()

    if self.Character == nil then return end
    return self.Character and self.Humanoid and self.HumanoidRootPart and self.Torso

end

-- Ragdoll
function RagdollR6:Start()

    if self.Ragdolling then print("yo?"); return end
    if not self:Checks() then self:Stop(true); return end

    self.Ragdolling = true
    -- if self.Humanoid:GetState() == Enum.HumanoidStateType.Dead then
    --     self.Humanoid:ChangeState(Enum.HumanoidStateType.Ragdoll)
    -- end

    self:SetNoCollisionConstraints()

    self:SetAttachments()
    self:SetBallSockets()

    -- self.HumanoidRootPart.CanCollide = false

end

function RagdollR6:SetAttachments()

    for name: string, conf: AttachmentConf.AttachmentConf in pairs(AttachmentConf) do

        local newAtt: Attachment = self._trove:Add(Instance.new("Attachment"))
        newAtt.CFrame = conf.CFrame

        newAtt.Name = name
        newAtt.Parent = self.Limbs[conf.Parent]

        self.Atts[name] = newAtt

    end

end

function RagdollR6:SetBallSockets()

    for name: string, conf: BallSocketConf.BallSocketConf in pairs(BallSocketConf) do

        local newBallSocket: BallSocketConstraint = self._trove:Add(conf.Instance:Clone());

        newBallSocket.Attachment0 = self.Atts[conf.Att0]
        newBallSocket.Attachment1 = self.Atts[conf.Att1]

        newBallSocket.Name = name
        newBallSocket.Parent = self.Torso
    end

end

function RagdollR6:SetNoCollisionConstraints()

    for _, v: BasePart | Motor6D in ipairs(self.Character:GetDescendants()) do

        if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then

            local nCollConst: NoCollisionConstraint = self._trove:Add(Instance.new("NoCollisionConstraint"))

            nCollConst.Part0 = v
            nCollConst.Part1 = self.Torso

            nCollConst.Name = v.Name
            nCollConst.Parent = self.Torso

            self.Limbs[v.Name] = v

        elseif v:IsA("Motor6D") and v.Name ~= "Root" and v.Name ~= "RootJoint" then

            self.Motor6D = v
            v.Enabled = false

        end

    end

end

-- Stop / Destroy
function RagdollR6:Stop( forever: boolean? )

    -- self.HumanoidRootPart.CanCollide = true

    if self.Motor6D then
        self.Motor6D.Enabled = true
        self.Motor6D = nil
    end

    -- if self.Humanoid and self.Humanoid.Health > 0 then
    --     self.Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
    -- end

    self._trove:Destroy()
    self._trove = if forever then Trove.new() else nil

    self.Ragdolling = false

end

return RagdollR6