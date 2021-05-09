
local PLAYER = FindMetaTable("Player")


function PLAYER:HasHEVOn()
	return self:GetModel()=="models/player/sgg/hev_helmet.mdl"
end
local AllowedModelsToLoadArmor = {
    ["models/player/blackmesa_guard.mdl"] = true,
    ["models/player/sgg/hev_helmet.mdl"] = true,
    ["models/player/blackmesa_marine.mdl"] = true
}
function PLAYER:CanLoadArmor()
	return AllowedModelsToLoadArmor[self:GetModel()]
end