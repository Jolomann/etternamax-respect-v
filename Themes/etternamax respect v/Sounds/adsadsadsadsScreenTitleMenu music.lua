local t = Def.ActorFrame {}

t[#t+1] = Def.Actor {
	InitCommand = function(self)
		self:PlayMusicPart(GetPathS("","titletheme.ogg"),0,0,0,0,1,0,0)
	end
};

return t