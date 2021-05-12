local JOB = {}
JOB.UniqueID = "Janitor"
JOB.Allowed = {CLASS_JANITOR}

JOB.TrashPositions = {
    Vector("-2267.692871 -1815.459106 634.031250"),
    Vector("-2060.059082 -1992.174805 634.031250"),
    Vector("-1927.844971 -2248.559326 634.031250"),
    Vector("-2079.797363 -2366.705566 634.031250"),
    Vector("-2233.905273 -2496.792969 634.031250")
}
JOB.GarbageModels = {"models/props_junk/garbage128_composite001a.mdl","models/props_junk/garbage128_composite001b.mdl","models/props_junk/garbage_bag001a.mdl","models/props_junk/garbage_carboard002a.mdl"}

JOB.GenerateTask = function()
    local RandomPos = JOB.TrashPositions[math.random(1,#JOB.TrashPositions)]
    local RandomModel = JOB.GarbageModels[math.random(1,#JOB.GarbageModels)]
    local TrashEnt = ents.Create("prop_physics")
    TrashEnt:SetModel(RandomModel)
    TrashEnt:SetPos(RandomPos)
    TrashEnt:SetCollisionGroup(COLLISION_GROUP_WEAPON)
    TrashEnt:DropToFloor()
    TrashEnt.IsTrash = true
    TrashEnt:Spawn()
    TrashEnt:GetPhysicsObject():Sleep()
    TrashEnt:SetUseType( SIMPLE_USE )
    if(!Jobs.ActiveTasks["Janitor"].ents) then
        Jobs.ActiveTasks["Janitor"].ents = {}
    end
    Jobs.ActiveTasks["Janitor"].ents[#Jobs.ActiveTasks["Janitor"].ents+1] = TrashEnt
end

JOB.CanActivate = function()
    for _,v in pairs(player.GetAll()) do
        local Class = v:GetCharacter():GetClass()
        if(Class==CLASS_JANITOR) then
            return true 
        end
    end
    return false
end

JOB.Reward = function(player)
    player:GetCharacter():AddXP(20)
end




RegisterJob(JOB)