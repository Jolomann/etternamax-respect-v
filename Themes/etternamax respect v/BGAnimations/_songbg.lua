local bgPosTable = {
--The grid of backgrounds is shaped like
--a 4x4 grid of dots that's missing the corners so it becomes 12 sprites in total.
--The points in the grid are offset from the center point

--Centered square of backgrounds
  {SCREEN_CENTER_X-1,SCREEN_CENTER_Y-1},
  {SCREEN_CENTER_X+1,SCREEN_CENTER_Y-1},
  {SCREEN_CENTER_X+1,SCREEN_CENTER_Y+1},
  {SCREEN_CENTER_X-1,SCREEN_CENTER_Y+1},

--Outer left side
  {SCREEN_CENTER_X-2,SCREEN_CENTER_Y-1},
  {SCREEN_CENTER_X-2,SCREEN_CENTER_Y+1},

--Outer right side
  {SCREEN_CENTER_X+2,SCREEN_CENTER_Y-1},
  {SCREEN_CENTER_X+2,SCREEN_CENTER_Y+1},

--Outer top side
  {SCREEN_CENTER_X-1,SCREEN_CENTER_Y-2},
  {SCREEN_CENTER_X+1,SCREEN_CENTER_Y-2},

--Outer bottom side
  {SCREEN_CENTER_X-1,SCREEN_CENTER_Y+2},
  {SCREEN_CENTER_X+1,SCREEN_CENTER_Y+2}
}

local enabled = themeConfig:get_data().global.SongBGEnabled
local brightness = 0.033333333333333

local t = Def.ActorFrame {}

if enabled then
	for i=1,12 do
		t[#t + 1] =
			Def.Sprite {
				CurrentSongChangedMessageCommand = function(self)
					self:finishtweening():smooth(0.5):diffusealpha(0):sleep(0.2):queuecommand("ModifySongBackground")
				end,
				ModifySongBackgroundCommand = function(self)
					self:finishtweening()
					if GAMESTATE:GetCurrentSong() and GAMESTATE:GetCurrentSong():GetBackgroundPath() then
						self:finishtweening()
						self:visible(true)
						self:LoadBackground(GAMESTATE:GetCurrentSong():GetBackgroundPath())
						self:scaletocover(0, 0, SCREEN_WIDTH, SCREEN_BOTTOM)
						self:xy(bgPosTable[i][1], bgPosTable[i][2])
						self:sleep(0.25)
						self:smooth(0.5)
						self:diffusealpha(brightness)
					else
						self:visible(false)
					end
				end,
				OffCommand = function(self)
					self:smooth(0.5):diffusealpha(0)
				end,
				BGOffMessageCommand = function(self)
					self:finishtweening()
					self:visible(false)
				end
			}
	end
end

t[#t + 1] =
			Def.Sprite {
				Texture = THEME:GetPathG("","SongBackgroundGradient");
				InitCommand = function(self)
					self:xy(0,0):halign(0):valign(0):zoomto(SCREEN_WIDTH,SCREEN_HEIGHT):diffusealpha(0.5)
				end
}

t[#t + 1] =
			Def.Sprite {
				Texture = THEME:GetPathG("","LineGradient");
				InitCommand = function(self)
					self:xy(0,0):halign(0):valign(0):zoomto(SCREEN_WIDTH,SCREEN_HEIGHT)
				end
}

return t
