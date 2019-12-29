local mainImageWidth = 200
local mainImageHeight = 200
local transitionSeconds = 0.1

local lastSelected = ''
local transitionEven = false -- wow this variable naming sucks ass find a better name for it
local t = Def.ActorFrame{
	InitCommand = function(self)
		self:SetUpdateFunction(function()
			
			local selected = SCREENMAN:GetTopScreen()["selected"]
			if lastSelected ~= selected then
				if lastSelected ~= '' then
					transitionEven = not transitionEven
				
					lastSelected = selected
					
					MESSAGEMAN:Broadcast("MenuSelectionChanged")
				else
					lastSelected = selected
				end
			end
		end)
	end
}


-- the sprites below trade jobs on each transition
-- at any given time, one is occupying the middle of the screen and the other is hiding off the edge (to be repositioned right or left depending on which direction scroll)
-- changing whether they Load graphics before or after the tween i think is also necessary (queuecommand) ((don't quote me on this))

t[#t+1] = Def.Sprite{
	--Name = "fffffff" -- come up with an appropriate name for this and the other one
	
	InitCommand = function(self)
		self:Load(THEME:GetPathG("", "MenuItems/GameStart"))
		
		self:stretchto(0,0, mainImageWidth, mainImageHeight) -- stop being lazy and use set size or wahtever 
		self:halign(0.5):valign(0.5)
		self:xy(SCREEN_CENTER_X, SCREEN_CENTER_Y)
	end,
	
	MenuSelectionChangedMessageCommand  = function(self)
		self:Load(THEME:GetPathG("", "MenuItems/" .. lastSelected))
		
		self:stoptweening()
		self:linear(transitionSeconds)
		if transitionEven then
			self:x(0 - mainImageWidth/2)
		else
			self:x(SCREEN_CENTER_X)
		end
	end
}

t[#t+1] = Def.Sprite{
	--Name = "?????????" -- come up with an appropriate name for this and the other one
	
	InitCommand = function(self)
		self:Load(THEME:GetPathG("", "MenuItems/GameStart"))
		
		self:stretchto(0,0, mainImageWidth, mainImageHeight) -- stop being lazy and use set size or wahtever 
		self:halign(0.5):valign(0.5)
		self:xy(SCREEN_WIDTH + mainImageWidth, SCREEN_CENTER_Y)
	end,
	
	MenuSelectionChangedMessageCommand  = function(self)
		self:Load(THEME:GetPathG("", "MenuItems/" .. lastSelected))
		
		self:stoptweening()
		self:linear(transitionSeconds)
		if not transitionEven then
			self:x(0 - mainImageWidth/2)
		else
			self:x(SCREEN_CENTER_X)
		end
	end
}

return t