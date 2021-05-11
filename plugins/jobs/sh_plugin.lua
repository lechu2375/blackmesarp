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