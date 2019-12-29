local gc = Var("GameCommand")

--[[local str = ''
for i,v in pairs(debug.getmetatable(gc).__index) do
	pcall(function() str = str .. tostring(i) .. ": " .. tostring(gc[i](gc)) .. '\n' end)
end
SCREENMAN:SystemMessage(str)]]

return Def.ActorFrame {
	LoadFont("Common Normal") ..
		{
			Text=THEME:GetString("ScreenTitleMenu",gc:GetText()),
		OnCommand=function(self)
			self:uppercase(true):halign(.5):valign(.5)
		end,
		GainFocusCommand=function(self)
			SCREENMAN:GetTopScreen()["selected"] = gc:GetName()
			self:zoom(0.5):diffuse(color("#050001")):diffusealpha(1):halign(.5)
		end,
		LoseFocusCommand=function(self)
			self:zoom(0.5):diffuse(color("#050001")):diffusealpha(0.4):halign(.5)
		end,
	}
}
