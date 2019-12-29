local mainImageWidth = 200
local mainImageHeight = 200
local transitionSeconds = 0.1


local scrollerChoices = THEME:GetMetric("ScreenTitleMenu", "ChoiceNames")

local choices = {}
local i = 0
for name in string.gmatch(scrollerChoices, "%a+") do
	i = i + 1
	choices[name] = i
end

local str = ''

local lastSelected = ''
local leftTransition = true
local t = Def.ActorFrame{
	InitCommand = function(self)
		self:SetUpdateFunction(function()
			local selected = SCREENMAN:GetTopScreen()["selected"]
			if lastSelected ~= selected then
				if lastSelected ~= '' then
					if choices[selected] - choices[lastSelected] ~= -1 and choices[selected] - choices[lastSelected] <= 1 then --- last = 1, selected = 6
						leftTransition = true
					else
						leftTransition = false
					end
					
					lastSelected = selected
					
					self:GetChildren()["ScrollerImage1"]:playcommand("MenuSelectionChanged")
					self:GetChildren()["ScrollerImage2"]:playcommand("MenuSelectionChanged")
				else
					lastSelected = selected
				end
			end
			
		end)
	end
}


-- the sprites below trade jobs on each transition
-- at any given time, one is occupying the middle of the screen and the other is hiding off the edge (to be repositioned right or left depending on which direction scroll)

t[#t+1] = Def.Sprite{
	Name = "ScrollerImage1",
	
	InitCommand = function(self)
		self:Load(THEME:GetPathG("", "MenuItems/GameStart"))
		
		self:stretchto(0,0, mainImageWidth, mainImageHeight) -- stop being lazy and use set size or wahtever 
		self:halign(0.5):valign(0.5)
		self:xy(SCREEN_CENTER_X, SCREEN_CENTER_Y)
	end,
	
	MenuSelectionChangedCommand  = function(self)
		self:finishtweening()
		
		local xDest
		local xStart
		if leftTransition then
			xDest = 0 - mainImageWidth/2 -- goes left
			xStart = SCREEN_WIDTH + mainImageWidth/2 -- or starts right
		else
			xDest = SCREEN_WIDTH + mainImageWidth/2 -- goes right
			xStart = 0 - mainImageWidth/2 -- or starts left
		end
		
		if self:GetX() ~= SCREEN_CENTER_X then
			self:Load(THEME:GetPathG("", "MenuItems/" .. lastSelected))
			self:x(xStart)
			xDest = SCREEN_CENTER_X
		end
		
		self:linear(transitionSeconds) -- decelerate
		self:x(xDest)
	end
}

t[#t+1] = Def.Sprite{
	Name = "ScrollerImage2",
	
	InitCommand = function(self)
		self:Load(THEME:GetPathG("", "MenuItems/GameStart"))
		
		self:stretchto(0,0, mainImageWidth, mainImageHeight) -- stop being lazy and use set size or wahtever 
		self:halign(0.5):valign(0.5)
		self:xy(SCREEN_WIDTH + mainImageWidth/2, SCREEN_CENTER_Y)
	end,
	
	MenuSelectionChangedCommand  = function(self)
		self:finishtweening()
		
		local xDest
		local xStart
		if leftTransition then
			xDest = 0 - mainImageWidth/2 -- goes left
			xStart = SCREEN_WIDTH + mainImageWidth/2 -- or starts right
		else
			xDest = SCREEN_WIDTH + mainImageWidth/2 -- goes right
			xStart = 0 - mainImageWidth/2 -- or starts left
		end
		
		if self:GetX() ~= SCREEN_CENTER_X then
			self:Load(THEME:GetPathG("", "MenuItems/" .. lastSelected))
			self:x(xStart)
			xDest = SCREEN_CENTER_X
		end
		
		self:linear(transitionSeconds) -- decelerate
		self:x(xDest)
	end
}

return t