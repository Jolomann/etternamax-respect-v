return Def.ActorFrame {
	Def.Quad {
		InitCommand = function(self)
			self:xy(2, -2):zoomto(4, 19)
		end,
		SetGradeCommand = function(self, params)
			if params.HasGoal then
				self:diffuse(byJudgment("TapNoteScore_Miss"))
				self:diffusealpha(1)
			else
				self:diffusealpha(0)
			end
		end
	},
	LoadFont("Common Normal") ..
		{
			InitCommand = function(self)
				self:xy(400, 0):zoom(0.5)
			end,
			SetGradeCommand = function(self, params)
				local sGrade = params.Grade or "Grade_None"
				self:halign(1):valign(0.5)
				self:settext(THEME:GetString("Grade", ToEnumShortString(sGrade)) or "")
				self:diffuse(getGradeColor(sGrade))
			end
		},
		Def.Sprite {
			InitCommand = function(self)
				self:xy(-9, -15):zoomto(4, 19)
			end,
			SetGradeCommand = function(self, params)
				if params.PermaMirror then
					self:Load(THEME:GetPathG("", "mirror"))
					self:zoomto(20, 20)
					self:visible(true)
				else
					self:visible(false)
				end
			end
		},
		Def.Sprite {
			InitCommand = function(self)
				self:xy(1, -15):zoomto(4, 19)
			end,
			SetGradeCommand = function(self, params)
				if params.Favorited then
					self:Load(THEME:GetPathG("", "favorite"))
					self:zoomto(16, 16)
					self:visible(true)
				else
					self:visible(false)
				end
			end
		},
		Def.Sprite {
			InitCommand = function(self)
				self:halign(1):xy(0, 0):zoomto(64, 32)
			end,
			SetGradeCommand = function(self, params)
				if params.Favorited then
					self:Load(GAMESTATE:GetCurrentSong():GetBackgroundPath())
					self:zoomto(64, 32)
					self:visible(true)
				else
					self:visible(false)
				end
			end
		},
}