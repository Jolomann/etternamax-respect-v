return Def.ActorFrame{

	InitCommand = function()
		loadRandomTitleSong()
		THEME:ReloadMetrics()
	end,
	LoadActor("ScrollerImages")
}