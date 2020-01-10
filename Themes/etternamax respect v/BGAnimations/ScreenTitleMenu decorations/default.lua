return Def.ActorFrame{

	InitCommand = function()
		THEME:ReloadMetrics()

		if lastActiveScreen == "ScreenSelectMusic" or lastActiveScreen == "ScreenOptionsService" then
			SOUND:PlayMusicPart(THEME:GetPathS("","ScreenInit music (loop).ogg"),0,69.824,0,0,true,false,false)
		end
	end,
	LoadActor("ScrollerImages")
}