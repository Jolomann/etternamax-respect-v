local t = Def.ActorFrame {}
t[#t+1] = Def.Sprite {
	InitCommand = function(self)
		self:fadeleft(0)
		self:halign(1)
		self:zoomto(64,32)
		self:x(0)
		self:y(0)
		self:diffusealpha(1)
		end,
		SetMessageCommand = function(self,params)
			local song = params.Song
			local bnpath = nil
			if song then
				bnpath = params.Song:GetBackgroundPath()
				if not bnpath then
					bnpath = THEME:GetPathG("Common", "fallback banner")
				end
				self:LoadBackground(bnpath)
				self:zoomto(64,32)
			end
		end
	};
return t