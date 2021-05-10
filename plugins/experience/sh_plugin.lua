PLUGIN.name = "Experience System"
PLUGIN.author = "Lechu2375"
PLUGIN.lvlUpExp = 100 //starting exp
PLUGIN.lvlExpMultiplier = 1.3 //second level will be above 164 third will be above 268
ix.char.RegisterVar("xp", { //GetXp SetXp
	field = "xp",
	fieldType = ix.type.number,
	default = 0,
	isLocal = true,
	bNoDisplay = true
})

ix.util.Include("sh_meta.lua")


