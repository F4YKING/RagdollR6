---- Variables ----
---- Default
local Default: BallSocketConstraint = Instance.new("BallSocketConstraint")
Default.Name = "RagdollJoint"

Default.Radius = 0.15
Default.LimitsEnabled = true
Default.TwistLimitsEnabled = false
Default.MaxFrictionTorque = 0
Default.Restitution = 0
Default.UpperAngle = 90
Default.TwistLowerAngle = -45
Default.TwistUpperAngle = 45

---- NeckJoint
local Neck: BallSocketConstraint = Default:Clone()

Neck.TwistLimitsEnabled = true
Neck.UpperAngle = 45
Neck.TwistLowerAngle = -70
Neck.TwistUpperAngle = 70

---- Initialize ----
-- return
return { Default, Neck }