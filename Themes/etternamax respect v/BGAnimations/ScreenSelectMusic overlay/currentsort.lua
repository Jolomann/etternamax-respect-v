local function highlightIfOver(self)
	if isOver(self) then
		self:diffusealpha(0.6)
	else
		self:diffusealpha(1)
	end
end

local t = Def.ActorFrame {
	InitCommand=function(self)
		self:SetUpdateFunction(highlight)
		self:SetUpdateFunctionInterval(0.025)
	end
}

local frameWidth = 280
local frameHeight = 20
local frameX = SCREEN_WIDTH - 5
local frameY = 15

local sortTable = {
	SortOrder_Preferred = THEME:GetString("SortOrder", "Preferred"),
	SortOrder_Group = THEME:GetString("SortOrder", "Group"),
	SortOrder_Title = THEME:GetString("SortOrder", "Title"),
	SortOrder_BPM = THEME:GetString("SortOrder", "BPM"),
	SortOrder_Popularity = THEME:GetString("SortOrder", "Popularity"),
	SortOrder_TopGrades = THEME:GetString("SortOrder", "TopGrades"),
	SortOrder_Artist = THEME:GetString("SortOrder", "Artist"),
	SortOrder_Genre = THEME:GetString("SortOrder", "Genre"),
	SortOrder_ModeMenu = THEME:GetString("SortOrder", "ModeMenu"),
	SortOrder_Length = THEME:GetString("SortOrder", "Length"),
	SortOrder_Recent = THEME:GetString("SortOrder", "Recent"),
	SortOrder_Favorites = THEME:GetString("SortOrder", "Favorites"),
	SortOrder_Overall = THEME:GetString("SortOrder", "Overall"),
	SortOrder_Stream = THEME:GetString("SortOrder", "Stream"),
	SortOrder_Jumpstream = THEME:GetString("SortOrder", "Jumpstream"),
	SortOrder_Handstream = THEME:GetString("SortOrder", "Handstream"),
	SortOrder_Stamina = THEME:GetString("SortOrder", "Stamina"),
	SortOrder_JackSpeed = THEME:GetString("SortOrder", "JackSpeed"),
	SortOrder_Chordjack = THEME:GetString("SortOrder", "Chordjack"),
	SortOrder_Technical = THEME:GetString("SortOrder", "Technical")
}

local translated_info = {
	Sort = THEME:GetString("SortOrder", "SortWord")
}

t[#t + 1] =
	Def.Quad {
	Name = "CurrentSort",
	InitCommand = function(self)
		self:xy(frameX, frameY):halign(1):zoomto(frameWidth, frameHeight):diffuse(getMainColor("frames")):diffusealpha(0)
	end
}



t[#t + 1] = StandardDecorationFromFileOptional("BPMDisplay", "BPMDisplay")
t[#t + 1] = StandardDecorationFromFileOptional("BPMLabel", "BPMLabel")

--just a simple mouse rollover test.
--[[ 
local function Update(self)
	t.InitCommand=function(self)
		self:SetUpdateFunction(Update)
	end;
	if isOver(self:GetChild("CurrentSort")) then
    	self:GetChild("CurrentSort"):diffusealpha(0.5)
    else
    	self:GetChild("CurrentSort"):diffusealpha(1)
    end;
end; 

t.InitCommand=function(self)
	self:SetUpdateFunction(Update)
end;
--]]
return t
