if IsSMOnlineLoggedIn() then
	CloseConnection()
end

local function input(event) -- for update button
	if event.type ~= "InputEventType_Release" then
		if event.DeviceInput.button == "DeviceButton_left mouse button" then
		elseif event.DeviceInput.button == "DeviceButton_right mouse button" then
		end
	end
	return false
end

local t =
	Def.ActorFrame {
	OnCommand = function(self)
		SCREENMAN:GetTopScreen():AddInputCallback(input)
	end
}

local frameX = THEME:GetMetric("ScreenTitleMenu", "ScrollerX")
local frameY = THEME:GetMetric("ScreenTitleMenu", "ScrollerY")

--Left gray rectangle
--[[t[#t+1] = Def.Quad{
	InitCommand=function(self)
		self:xy(0,0):halign(0):valign(0):zoomto(250,900):diffuse(getTitleColor('BG_Left')):diffusealpha(1)
	end;
};]]--

--Right gray rectangle
--[[t[#t+1] = Def.Quad{
	InitCommand=function(self)
		self:xy(250,0):halign(0):valign(0):zoomto(1000,900):diffuse(getTitleColor('BG_Right')):diffusealpha(1)
	end;
};

--Light purple line
t[#t+1] = Def.Quad{
	InitCommand=function(self)
		self:xy(250,0):halign(0):valign(0):zoomto(10,900):diffuse(getTitleColor('Line_Left')):diffusealpha(1)
	end;
};

--Dark purple line
t[#t+1] = Def.Quad{
	InitCommand=function(self)
		self:xy(260,0):halign(0):valign(0):zoomto(10,900):diffuse(getTitleColor('Line_Right')):diffusealpha(1)
	end;
};]]--

--Title text
--[[t[#t+1] = LoadFont("Common Large") .. {
	InitCommand=function(self)
		self:xy(75,frameY-82):zoom(0.65):valign(1):halign(0):diffuse(getMainColor('positive'))
	end,
	OnCommand=function(self)
	self:settext("Etterna")
	end,
}]]--

--Theme text
--[[t[#t+1] = LoadFont("Common Normal") .. {
	InitCommand=function(self)
		self:xy(87,frameY-52):zoom(0.65):valign(1):halign(0):diffuse(getMainColor('positive'))
		-- previousX, 42, previousY, frameY(-62)
	end,
	OnCommand=function(self)
		self:settext(getThemeName())
	end,
}]]--

-- lazy game update button -mina
--[[local gameneedsupdating = false
local buttons = {x = 122, y = 40, width = 140, height = 36, fontScale = 0.3, color = getMainColor("frames")}
t[#t + 1] =
	Def.Quad {
	InitCommand = function(self)
		self:xy(buttons.x, buttons.y):zoomto(buttons.width, buttons.height):halign(1):valign(0):diffuse(buttons.color):diffusealpha(
			0
		)
		local latest = tonumber((DLMAN:GetLastVersion():gsub("[.]", "", 1)))
		local current = tonumber((GAMESTATE:GetEtternaVersion():gsub("[.]", "", 1)))
		if latest and latest > current then
			gameneedsupdating = true
		end
	end,
	OnCommand = function(self)
		if gameneedsupdating then
			self:diffusealpha(1)
		end
	end,
	MouseLeftClickMessageCommand = function(self)
		if isOver(self) and gameneedsupdating then
			GAMESTATE:ApplyGameCommand("urlnoexit,https://github.com/etternagame/etterna/releases;text,GitHub")
		end
	end
}

t[#t + 1] =
	LoadFont("Common Large") ..
	{
		OnCommand = function(self)
			self:xy(buttons.x + 3, buttons.y + 14):halign(1):zoom(buttons.fontScale):diffuse(getMainColor("positive"))
			if gameneedsupdating then
				self:settext(THEME:GetString("ScreenTitleMenu", "UpdateAvailable"))
			else
				self:settext("")
			end
		end
	}]]--
	
t[#t + 1] =
	Def.Sprite {
		Texture=THEME:GetPathG("","TitleBG/PlayGradient");
		InitCommand = function(self)
			self:xy(0,0):valign(0):halign(0):zoomto(SCREEN_WIDTH,SCREEN_HEIGHT)
		end
	}

t[#t + 1] =
	Def.Sprite {
		Texture=THEME:GetPathG("","LineGradient");
		InitCommand = function(self)
			self:xy(0,0):halign(0):valign(0):zoomto(SCREEN_WIDTH,SCREEN_HEIGHT)
		end
	}

t[#t + 1] =
	Def.Sprite {
		Texture=THEME:GetPathG("","MenuArrow");
		InitCommand = function(self)
			self:xy(27,SCREEN_CENTER_Y-2):valign(0.5):halign(0):zoom(0.275)
		end
	}
	
t[#t + 1] =
	Def.Sprite {
		Texture=THEME:GetPathG("","MenuArrow");
		InitCommand = function(self)
			self:xy(SCREEN_RIGHT-98,SCREEN_CENTER_Y-2):valign(0.5):halign(1):zoom(0.275):zoomx(-0.275)
		end
	}

t[#t + 1] =
	Def.Quad {
		InitCommand = function(self)
			self:xy(0,SCREEN_BOTTOM):halign(0):valign(1):zoomto(SCREEN_WIDTH,38):diffuse(color("#000000")):diffusealpha(.6)
		end
	}


function mysplit(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t = {}
	i = 1
	for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end

local transformF = THEME:GetMetric("ScreenTitleMenu", "ScrollerTransform")
local scrollerX = THEME:GetMetric("ScreenTitleMenu", "ScrollerX")
local scrollerY = THEME:GetMetric("ScreenTitleMenu", "ScrollerY")
local scrollerChoices = THEME:GetMetric("ScreenTitleMenu", "ChoiceNames")
local _, count = string.gsub(scrollerChoices, "%,", "")
local choices = mysplit(scrollerChoices, ",")
local choiceCount = count + 1
for i = 1, choiceCount do
	t[#t + 1] = Def.Quad {
		OnCommand = function(self)
			self:xy(scrollerX, scrollerY):zoomto(0, SCREEN_WIDTH*2)
			transformF(self, 0, i, choiceCount)
			self:addx(SCREEN_CENTER_X - 20)
			self:addy(SCREEN_CENTER_Y - 20)
			self:diffusealpha(0)
		end,
		MouseLeftClickMessageCommand = function(self)
			if (isOver(self)) then
				SCREENMAN:GetTopScreen():playcommand("MadeChoicePlayer_1")
				SCREENMAN:GetTopScreen():playcommand("Choose")
				if choices[i] == "Multi" or choices[i] == "GameStart" then
					GAMESTATE:JoinPlayer(PLAYER_1)
				end
				GAMESTATE:ApplyGameCommand(THEME:GetMetric("ScreenTitleMenu", "Choice" .. choices[i]))
			end
		end
	}
end

return t
