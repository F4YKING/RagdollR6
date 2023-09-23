-- // F4YKING - Github
-- // 22 September 2023

--[[]]

---- Variables ----
-- Packages
local Trove = require(script.Parent.Trove)

-- Modules
local LimbTree = require(script.LimbTree)
local AttachmentData = require(script.AttachmentData)
local BallSocketData = require(script.BallSocketData)

---- Initialize ----
-- RagdollR6
local RagdollR6 = {}
RagdollR6.__index = RagdollR6

--[=[
    @param plr Player
    @return RagdollR6
]=]

function RagdollR6.new(plr: Player)
    local self = setmetatable({}, RagdollR6)
    self._trove = Trove.new()

    self.Player = plr
    self.Char = nil

    self.Limbs = {}
    self.Atts = {}

    return self
end

--[=[
    @param char Model
]=]

function RagdollR6:Init(char: Model)

	self.Char = char

    if not self:Checks() then self:Destroy() return end

    for _, LimbName in ipairs(LimbTree) do
		self.Limbs[LimbName] = self.Char:FindFirstChild(LimbName)
	end

end

--[=[

]=]

function RagdollR6:Start()

    if self.Limbs.Torso and not self.Limbs.Torso:FindFirstChild("NeckJoint") then

        for name: string, data: {CFrame: CFrame, Parent: string} in pairs(AttachmentData) do

            local nAtt: Attachment = self._trove:Add(Instance.new("Attachment"))
            nAtt.CFrame = data.CFrame

            nAtt.Name = name
            nAtt.Parent = self.Limbs[data.Parent]

            self.Atts[name] = nAtt

        end

        for name: string, data: { Instance: BallSocketConstraint, Att0: string, Att1: string, Parent: string } in pairs(BallSocketData) do

            local nBS: BallSocketConstraint = self._trove:Add(data.Instance:Clone())
            nBS.Attachment0 = self.Atts[data.Att0]
            nBS.Attachment1 = self.Atts[data.Att1]

            nBS.Name = name
            nBS.Parent = self.Limbs[data.Parent]

        end

    end

    self.Limbs.HumanoidRootPart.CanCollide = false

    for _, v: BasePart | Motor6D in ipairs(self.Char:GetDescendants()) do

        if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then

            local nCC: NoCollisionConstraint = self._trove:Add(Instance.new("NoCollisionConstraint"))

            nCC.Part0 = v
            nCC.Part1 = self.Limbs.Torso

            nCC.Name = v.Name
            nCC.Parent = self.Limbs.Torso

        elseif v:IsA("Motor6D") and v.Name ~= "Root" and v.Name ~= "RootJoint" then

            v.Enabled = false

        end

    end

end

--[=[
    @param forever boolean
]=]

function RagdollR6:Stop(forever: boolean)

    self.Limbs.HumanoidRootPart.CanCollide = true

    self._trove:Destroy()

    for _, v: Motor6D? in ipairs(self.Char:GetDescendants()) do

        if v:IsA("Motor6D") and v.Name ~= "Root" and v.Name ~= "RootJoint" then
            v.Enabled = true
        end

    end

    self._trove = not forever and Trove.new() or nil

end

--[=[

]=]

function RagdollR6:Checks()

    return self.Player and
        self.Char and
        self.Char:FindFirstChild("Humanoid") and
        self.Char.Humanoid.RigType == Enum.HumanoidRigType.R6

end

--[=[

]=]

function RagdollR6:Destroy()

    self:Stop(true)

end

return RagdollR6