return {
	-- Torso / Head - Neck
	NeckAttachment = {
		CFrame =
		CFrame.new(0, -.5, 0) *
		CFrame.Angles(0, 0, 0),

		Parent = "Head"
	},

	TorsoNeckAttachment = {
		CFrame =
		CFrame.new(0, 1, 0) *
		CFrame.Angles(0, 0, 0),

		Parent = "Torso"
	},

	-- Torso / RightArm - RightArm
	RightArmAttachment = {
		CFrame =
		CFrame.new(-.5, .5, 0) *
		CFrame.Angles(0, 0, 0),

		Parent = "Right Arm"
	},

	TorsoRightArmAttachment = {
		CFrame =
		CFrame.new(1, .5, 0) *
		CFrame.Angles(0, 0, 0),

		Parent = "Torso"
	},

	-- Torso / LeftArm - LeftArm
	LeftArmAttachment = {
		CFrame =
		CFrame.new(.5, .5, 0) *
		CFrame.Angles(0, 0, 0),

		Parent = "Left Arm"
	},

	TorsoLeftArmAttachment = {
		CFrame =
		CFrame.new(-1, .5, 0) *
		CFrame.Angles(0, 0, 0),

		Parent = "Torso"
	},

	-- Torso / RightLeg - RightLeg
	RightLegAttachment = {
		CFrame =
		CFrame.new(0, 1, 0) *
		CFrame.Angles(0, 0, -90),

		Parent = "Right Leg"
	},

	TorsoRightLegAttachment = {
		CFrame =
		CFrame.new(-.5, -1, 0) *
		CFrame.Angles(0, 0, -90),

		Parent = "Torso"
	},

	-- Torso / LeftLeg - LeftLeg
	LeftLegAttachment = {
		CFrame =
		CFrame.new(0, 1, 0) *
		CFrame.Angles(0, 0, -90),

		Parent = "Left Leg"
	},

	TorsoLeftLegAttachment = {
		CFrame =
		CFrame.new(.5, -1, 0) *
		CFrame.Angles(0, 0, -90),

		Parent = "Torso"
	}
}