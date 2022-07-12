--================================--
--          RP /me v1.0.0         --
--            by GIMI             --
--      License: GNU GPL 3.0      --
--================================--

Config = {}

Config.Text = {
    displayDistance = 15, -- 3D text display distance in GTA units,
    maxLength = 120, -- Maximum text length to be displayed, in characters
    forceLength = true, -- Set to true if you don't want to allow lengthy texts in /me (exceeding maxLength above)
    background = true, -- Set to false to disable text background
    font = 4,
    scale = 0.35,
    timeOnScreen = 5000 -- Time in ms after which the 3D text will disappear
}