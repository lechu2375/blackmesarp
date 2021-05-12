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

        if(ent.IsTrash) then //trash job handle
            local class = ply:GetCharacter():GetClass()
            if(class==CLASS_JANITOR and !ply.PickingUpTrash) then
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
end