local gc = Var("GameCommand")

return Def.ActorFrame {
	LoadFont("Common Normal") ..
		{
			Text=THEME:GetString("ScreenTitleMenu",gc:GetText()),
		OnCommand=function(self)
			self:uppercase(true):halign(.5):valign(.5)
		end,
		GainFocusCommand=function(self)
			self:zoom(0.5):diffuse(color("#050001")):diffusealpha(1):halign(.5)
		end,
		LoseFocusCommand=function(self)
			self:zoom(0.5):diffuse(color("#050001")):diffusealpha(0.4):halign(.5)
		end,
	}
}
