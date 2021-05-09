
-- Here is where all of your serverside hooks should go.

-- Change death sounds of people in the police faction to the metropolice death sound.

function Schema:PlayerUse(ply,ent )
    if(ent:GetClass()=="func_recharge" and !ply:CanLoadArmor()) then 
        return false
    end
end