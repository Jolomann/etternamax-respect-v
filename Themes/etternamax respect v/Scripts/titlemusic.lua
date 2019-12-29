local songList = {"title1.ogg", "title2.ogg", "title3.ogg", "title4.ogg"}


--old music script. uses default sound system and rewrites the sound redir file
--each time title screen is entered

function loadRandomTitleSong()
	local songIndex = math.random(1, #songList)

	local name = songList[songIndex]

	local f = RageFileUtil.CreateRageFile()
	if f:Open("/Themes/" .. THEME:GetCurThemeName() .. "/Sounds/songlol.redir", 2) then
    	f:Write(name)
    f:destroy()
    end
end


-- (WIP) new music script. uses custom sound system with PlayMusicPart()

--[[function loadRandomTitleSong()
	local songIndex = math.random(1, #songList)
	local songname = songList[songIndex]

		--Command values in order: musicPath, musicStart, musicLength, fadeIn, fadeOut, loop, applyRate, alignBeat
	SOUNDMAN:PlayMusicPart(songname,0,0,0.5,0.5,1,1,0)

end]]--