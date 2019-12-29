--Binds escape to cancel(menu back)
local function goBack(event)
	if event.type == "InputEventType_Release" and event.DeviceInput.button == "DeviceButton_escape" then
            SCREENMAN:GetTopScreen():Cancel()
    end
end

--Effecttiming test function
local function effectTest(self)
	--Effecttiming uses several floats to control 'keyframes' for an effect. Think of them as sections
	--where you can control the time of the effect section by section. The floats are percentages of
	--the total time of the effect they are applied to.
	--The are in a specific order
	--1: Ramp to half
	--2: Hold at half
	--3: Ramp to full
	--4: Hold at zero
	--5: Hold at full
	self:effecttiming(.1,0,.1,0,0)
end

--Table for bezier curve animation
SmoothAnim = {
	0,
	0,
	0.42,
	-0.42,
	2 / 3,
	0.3,
	1,
	1
}

--Define bezier move function and call it later
local function bezierMove(self)
		self:linear(0.5):bezier(1,SmoothAnim):addx(50):linear(0.5):bezier(1,SmoothAnim):addy(50):linear(0.5):bezier(1,SmoothAnim):addx(-50):linear(0.5):bezier(1,SmoothAnim):addy(-50)
	end

local t = Def.ActorFrame {

	--Enables back button function
	Def.ActorFrame {
	OnCommand=function(self)
		SCREENMAN:GetTopScreen():AddInputCallback( goBack )
		end
	},

	--Displays active input devices
	Def.DeviceList {
		Font = "Common Normal",
		InitCommand = function(self)
			self:zoom(0.5)
			self:x(SCREEN_LEFT + 20):y(SCREEN_TOP + 80):halign(0)
		end
	},

	--List of active inputs
	Def.InputList {
		Font = "Common Normal",
		InitCommand = function(self)
			self:zoom(0.5)
			self:x(SCREEN_CENTER_X - 250):y(SCREEN_CENTER_Y):halign(0)
			self:vertspacing(8)
		end
	}
}

t[#t + 1] = Def.ActorFrame {
	InitCommand=function(self)
		self:xy(SCREEN_CENTER_X,SCREEN_CENTER_Y)
		self:diffuse(getMainColor('positive'))
	end,



	--Frame text
	LoadFont("Common Normal") .. {
		
		Text="Bezier test";
		InitCommand=function(self)
			self:zoom(0.5)
			self:addx(10):valign(0.5):halign(0.5)
			self:spin()
		end
	},


	--Moving quad with bezier curve(test, kinda jank)
	Def.Quad {
		--Set position and size
		InitCommand=function(self)
			self:addx(100)
			self:zoomto(20,20)
		end,
		--Move smoothly and automatically
		OnCommand=function(self)
			self:bezierMove()
		end
	},
}

t[#t + 1] = Def.ActorFrame {
	InitCommand=function(self)
		self:xy(SCREEN_CENTER_X,SCREEN_CENTER_Y-100)
		self:diffuse(getMainColor('positive'))
	end,

	--Frame text
	LoadFont("Common Normal") .. {
		
		Text="Accel/Decel test";
		InitCommand=function(self)
			self:zoom(0.5)
			self:addx(10):valign(0.5):halign(0.5)
		end
	},


	--Accelerate/Decelerate quad test
	Def.Quad {
		--Set position and size
		InitCommand=function(self)
			self:addx(100)
			self:zoomto(20,20)
		end,
		--Move smoothly and automatically
		OnCommand=function(self)
			self:accelerate(0.5):addx(50):accelerate(0.5):addy(50):accelerate(0.5):addx(-50):accelerate(0.5):addy(-50)
		end
	},

}

return t