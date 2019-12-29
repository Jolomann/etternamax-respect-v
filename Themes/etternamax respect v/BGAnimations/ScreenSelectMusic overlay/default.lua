local showVisualizer = themeConfig:get_data().global.ShowVisualizer

local function input(event)
	if event.DeviceInput.button == "DeviceButton_left mouse button" and event.type == "InputEventType_Release" then
		MESSAGEMAN:Broadcast("MouseLeftClick")
	elseif event.DeviceInput.button == "DeviceButton_right mouse button" and event.type == "InputEventType_Release" then
		MESSAGEMAN:Broadcast("MouseRightClick")
	end
	return false
end

local function highlight(self)
	self:GetChild("rando"):queuecommand("Highlight")
end

local function highlightIfOver(self)
	if isOver(self) then
		self:diffusealpha(0.6)
	else
		self:diffusealpha(0.2)
	end
end

local t =
	Def.ActorFrame {
	BeginCommand = function(self)
		self:SetUpdateFunction(highlight)
		self:SetUpdateFunctionInterval(0.025)
		local s = SCREENMAN:GetTopScreen()
		s:AddInputCallback(input)
	end
}

t[#t + 1] =
	Def.Actor {
	CodeMessageCommand = function(self, params)
		if params.Name == "AvatarShow" and getTabIndex() == 0 and not SCREENMAN:get_input_redirected(PLAYER_1) then
			SCREENMAN:SetNewScreen("ScreenAssetSettings")
		end
	end
}

t[#t + 1] = LoadActor("../_frame")
t[#t + 1] = LoadActor("../_PlayerInfo")


t[#t + 1] = LoadActor("currentsort")
t[#t + 1] =
	LoadFont("Common Normal") ..
	{
		Name="rando",
		InitCommand = function(self)
			self:xy(75, 22):halign(0):valign(1):zoom(0.35):diffuse(getMainColor("positive")):diffusealpha(0.2)
			self:settext("SONG SELECT")
		end,
		HighlightCommand=function(self)
			highlightIfOver(self)
		end,
		MouseLeftClickMessageCommand = function(self)
			if isOver(self) then
				local t = SONGMAN:GetAllSongs()
				local random_song = t[math.random(#t)]
				SCREENMAN:GetTopScreen():GetMusicWheel():SelectSong(random_song)
			end
		end
	}

t[#t + 1] = LoadActor("../_cursor")
t[#t + 1] = LoadActor("../_halppls")
t[#t + 1] = LoadActor("currenttime")

GAMESTATE:UpdateDiscordMenu(
	GetPlayerOrMachineProfile(PLAYER_1):GetDisplayName() ..
		": " .. string.format("%5.2f", GetPlayerOrMachineProfile(PLAYER_1):GetPlayerRating())
)

File.Write("nowplaying.txt", " ")
return t