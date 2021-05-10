local CHAR = ix.meta.character

if(SERVER)then
    function CHAR:AddXP(amount)
        local XpAmount = self:GetXp()
        self:SetXp(XpAmount+amount)
        //maybe notification here??
    end
end

local Exp = PLUGIN.lvlUpExp
local ExpMultiplier = PLUGIN.lvlExpMultiplier
function CHAR:GetLevel()
    local XpAmount = self:GetXp()
    local CurrentLevel = 1
    local AExp = Exp

    while(true)do
        AExp=AExp*ExpMultiplier
        if(XpAmount>=AExp) then
            CurrentLevel=CurrentLevel+1
        else
            return CurrentLevel
        end
    end
end

