--file containing stuff for cursors.
--this should only be loaded by screen overlays,
--otherwise the inputcallback function won't be able to find the actors.

local maxChild = 20
local curIndex = 0

function cursorClick(index)
	return LoadActor("ClickCursor") ..
		{
			Name = "CursorClick",
			InitCommand = function(self)
				self:diffusealpha(0)
			end,
			MouseLeftClickMessageCommand = function(self)
				if index == curIndex then
					self:finishtweening()
					self:xy(INPUTFILTER:GetMouseX(), INPUTFILTER:GetMouseY())
					self:diffusealpha(0.6)
					self:zoom(0)
					self:decelerate(0.5)
					self:diffusealpha(0)
					self:zoom(0.5)
				end
			end
		}
end

local t =
	Def.ActorFrame {
	Name = "Cursor"
}

for i = 0, maxChild do
	t[#t + 1] = cursorClick(i)
end

t[#t+1] = LoadActor("cursorr")..{
	Name="Cursor";
	InitCommand=function(self)
		self:xy(0,0):zoom(1)
	end
}

local function Update(self)
	--self:GetChild("MouseXY"):settextf("X:%5.2f Y:%5.2f W:%5.2f",INPUTFILTER:GetMouseX(),INPUTFILTER:GetMouseY(),INPUTFILTER:GetMouseWheel())
	if not PREFSMAN:GetPreference("Windowed") then
		self:GetChild("Cursor"):xy(INPUTFILTER:GetMouseX(), INPUTFILTER:GetMouseY())
		self:GetChild("Cursor"):visible(true)
	else
		self:GetChild("Cursor"):visible(false)
	end
	--self:GetChild("FullScreen"):settextf("FullScreen: %s",tostring(not PREFSMAN:GetPreference("Windowed")))
end
t.InitCommand = function(self)
	self:SetUpdateFunction(Update)
	self:SetUpdateFunctionInterval(.008)
end

return t