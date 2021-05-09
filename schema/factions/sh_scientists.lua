
-- Since this faction is not a default, any player that wants to become part of this faction will need to be manually
-- whitelisted by an administrator.

FACTION.name = "Naukowcy"
FACTION.description = "Ludzie, którzy zajmuj¹ siê dzia³alnoœci¹ naukow¹."
FACTION.color = Color(247, 159, 31)
FACTION.pay = 15 -- How much money every member of the faction gets paid at regular intervals.

FACTION.isGloballyRecognized = true -- Makes it so that everyone knows the name of the characters in this faction.

-- Note that FACTION.models is optional. If it is not defined, it will use all the standard HL2 citizen models.
FACTION.models = {"models/player/blackmesa_scientific.mdl"}


FACTION_SCIENTISTS = FACTION.index
