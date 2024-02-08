-- // F4YKING - GITHUB
-- // 08 February 2024 - 14:23:46

-- // TestService.lua

--[[
    [08 February 2024 - 14:24:17]
    - Thanks for @CompletedLoop (roblox) for making this
    - https://devforum.roblox.com/t/2413582
]]

---- Variables ----
-- AttachmentCFrames
local AttachmentCFrames = {
	["Neck"] = {
        CFrame.new(0, 1, 0, 0, -1, 0, 1, 0, -0, 0, 0, 1),
        CFrame.new(0, -0.5, 0, 0, -1, 0, 1, 0, -0, 0, 0, 1)
    },

	["Left Shoulder"] = {
        CFrame.new(-1.3, 0.75, 0, -1, 0, 0, 0, -1, 0, 0, 0, 1),
        CFrame.new(0.2, 0.75, 0, -1, 0, 0, 0, -1, 0, 0, 0, 1)
    },

	["Right Shoulder"] = {
        CFrame.new(1.3, 0.75, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
        CFrame.new(-0.2, 0.75, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
    },

	["Left Hip"] = {
        CFrame.new(-0.5, -1, 0, 0, 1, -0, -1, 0, 0, 0, 0, 1),
        CFrame.new(0, 1, 0, 0, 1, -0, -1, 0, 0, 0, 0, 1)
    },

	["Right Hip"] = {
        CFrame.new(0.5, -1, 0, 0, 1, -0, -1, 0, 0, 0, 0, 1),
        CFrame.new(0, 1, 0, 0, 1, -0, -1, 0, 0, 0, 0, 1)
    },
}


---- Initialize ----
-- AttachmentCFrames
return AttachmentCFrames