
-- Here is where all of your shared hooks should go.

-- Disable entity driving.
function Schema:CanDrive(client, entity)
	return false
end

function Schema:CanPlayerJoinClass(client, class, info)
	if(info.RequiredLevel)then
		return client:GetCharacter():GetLevel()>=info.RequiredLevel
	end
end