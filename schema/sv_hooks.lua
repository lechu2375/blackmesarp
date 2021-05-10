
-- Here is where all of your serverside hooks should go.

-- Change death sounds of people in the police faction to the metropolice death sound.

function Schema:PlayerUse(ply,ent )
    if(ent:GetClass()=="func_recharge" and !ply:CanLoadArmor()) then //allows using armor charger only for certain people
        return false
    end
end
function Schema:PlayerJoinedClass(client)
    client:KillSilent()
end