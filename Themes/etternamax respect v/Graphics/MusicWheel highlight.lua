return Def.ActorFrame {
	Def.Quad {
		Name = "Horizontal",
		InitCommand = function(self)
			self:xy(0, 0):zoomto(450, 34):halign(0)
		end,
		SetCommand = function(self)
			self:decelerate(0.1):zoomx(0):accelerate(0.1):zoomx(450)
			self:diffuseramp()
			self:effectcolor1(color("#FFFFFF33"))
			self:effectcolor2(color("#FFFFFF33"))
		end,
		BeginCommand = function(self)
			self:decelerate(0.1):zoomx(0):queuecommand("Set")
		end,
		OffCommand = function(self)
			self:visible(false)
		end
	}
}
