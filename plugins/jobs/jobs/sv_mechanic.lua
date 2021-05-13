util.AddNetworkString("connectWires")
net.Receive("connectWires", function(len,ply)
    if(!(ply.ActiveWireConnection)) then
        return 
    end
    local result = net.ReadBool()
    if(result) then
        ply.ActiveWireConnection:Remove()
        ply.ActiveWireConnection = nil
        Jobs.Tasks.Mechanic.Reward(ply)
    else
        ply:TakeDamage(10,ply.ActiveWireConnection,ply.ActiveWireConnection)
    end
end)
local JOB = {}
JOB.UniqueID = "Mechanic"
JOB.Allowed = {CLASS_TECHNICIAN}

JOB.SparkPositions = {
    Vector("-2391.107666 -1998.419556 634.046631"),
    Vector("-2391.107910 -2175.271484 634.065247")
}
//This is electrican job but I need to think about one more job for him and make electrician class
JOB.GenerateTask = function()
    local RandomPos = JOB.SparkPositions[math.random(1,#JOB.SparkPositions)]

    local SparksEnt = ents.Create("bm_sparks")
    SparksEnt:SetPos(RandomPos)
    SparksEnt:Spawn()
    if(!Jobs.ActiveTasks["Mechanic"].ents) then
        Jobs.ActiveTasks["Mechanic"].ents = {}
    end
    Jobs.ActiveTasks["Mechanic"].ents[#Jobs.ActiveTasks["Mechanic"].ents+1] = SparksEnt
end

JOB.CanActivate = function()
    for _,v in pairs(player.GetAll()) do
        local Class = v:GetCharacter():GetClass()
        if(Class==CLASS_TECHNICIAN) then
            return true 
        end
    end
    return false
end

JOB.Reward = function(player)
    player:GetCharacter():AddXP(25)
end




RegisterJob(JOB)
