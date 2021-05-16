PLUGIN.name = "Jobs"
PLUGIN.author = "Lechu2375"


Jobs = Jobs or {}
Jobs.Tasks = {}
Jobs.ActiveTasks = Jobs.ActiveTasks or {}

if(SERVER) then
    function RegisterJob(JobTable)
        
        Jobs.Tasks[JobTable.UniqueID] = JobTable
    end
end

ix.util.Include("jobs/sv_trash.lua")
ix.util.Include("jobs/sv_mechanic.lua")
ix.util.Include("jobs/cl_mechanic.lua")

ix.command.Add("checkjobs", {
	description = "ehe",
	OnRun = function(self)
        for k,v in pairs(Jobs.Tasks) do
            if(v.CanActivate()) then
                Jobs.ActiveTasks[v.UniqueID] = {}
                v.GenerateTask()
            end
        end
	end
})

if ( SERVER ) then
    function PLUGIN:PlayerUse(ply,ent )
        
        if(IsValid(ent.BrokenEffect)) then
            return false
        end
        if(ent.IsTrash and ((ply.TrashNotifyDelay or 1) <CurTime())) then //trash job handle
            local class = ply:GetCharacter():GetClass()
            if!(class==CLASS_JANITOR)then
                ply:NotifyLocalized("notYourJob")
                ply.TrashNotifyDelay = CurTime()+1
                return false 
            end

            if(!ply.PickingUpTrash) then
                ply:SetAction(L("pickingUp",ply), 2) // for displaying the progress bar
                ply.PickingUpTrash = true
                ply:DoStaredAction(ent, function()
                    ent:Remove()
                    Jobs.Tasks.Janitor.Reward(ply)
                    ply.PickingUpTrash = false
                end,2,function() ply.PickingUpTrash = false end,100)              
            end
        end



    end

    function PLUGIN:AcceptInput(ent,input,activator,caller,value )
        if((input=="Open" or input=="Close") and IsValid(ent.BrokenEffect)) then
            local random = math.random(0,3)
            if(random==3) then
                ent:Fire("unlock")
                ent:Fire("open")
                timer.Simple(0.2, function()
                    ent:Fire("close")
                end)
            else
                return true
            end
        end

        if((input=="Toggle") and IsValid(ent.BrokenEffect)) then
            return true
        end
    end
end