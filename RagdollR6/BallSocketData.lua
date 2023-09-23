---- Variables ----
---- NeckJoint
local NeckJoint: BallSocketConstraint = Instance.new("BallSocketConstraint")

-- BallSocket
NeckJoint.LimitsEnabled = true

-- Friction
NeckJoint.MaxFrictionTorque = 0

-- Limits
NeckJoint.Restitution = 0
NeckJoint.TwistLimitsEnabled = true
NeckJoint.UpperAngle = 0

-- TwistLimits
NeckJoint.TwistLowerAngle = -70
NeckJoint.UpperAngle = 70

---- Default
local Default: BallSocketConstraint = Instance.new("BallSocketConstraint")

-- BallSocket
Default.LimitsEnabled = true

-- Friction
Default.MaxFrictionTorque = 0

-- Limits
Default.Restitution = 0
Default.TwistLimitsEnabled = false
Default.UpperAngle = 70

---- Initialize ----
-- return
return {
	-- Torso / Head - Neck
	NeckJoint = {
		Instance = NeckJoint:Clone(),

		Att0 = "NeckAttachment",
		Att1 = "TorsoNeckAttachment",

		Parent = "Torso"
	},

	-- Torso / RightArm  - RightArm
	RightArmJoint = {
		Instance = Default:Clone(),

		Att0 = "TorsoRightArmAttachment",
		Att1 = "RightArmAttachment",

		Parent = "Torso"
	},

	-- Torso / LeftArm - LeftArm
	LeftArmJoint = {
		Instance = Default:Clone(),

		Att0 = "TorsoLeftArmAttachment",
		Att1 = "LeftArmAttachment",

		Parent = "Torso"
	},

	-- Torso / RightLeg - RightLeg
	RightLegJoint = {
		Instance = Default:Clone(),

		Att0 = "RightLegAttachment",
		Att1 = "TorsoRightLegAttachment",

		Parent = "Torso"
	},

	-- Torso / LeftLeg - LeftLeg
	LeftLegJoint = {
		Instance = Default:Clone(),

		Att0 = "LeftLegAttachment",
		Att1 = "TorsoLeftLegAttachment",

		Parent = "Torso"
	}
}