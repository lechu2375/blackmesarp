
AddCSLuaFile()

DEFINE_BASECLASS( "base_anim" )


ENT.PrintName = "Sparks"
ENT.Author = "Lechu2375"
ENT.Information = "Sparks"
ENT.Category = "Helix - Black Mesa"
ENT.bNoPersist = true
ENT.Editable = false
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.RenderGroup = RENDERGROUP_OTHER


	function ENT:Initialize()
        if(SERVER)then
            self:SetModel("models/props_c17/gravestone003a.mdl")
            self:SetSolid(SOLID_BBOX)
            self:PhysicsInit(SOLID_BBOX)
            self:SetCollisionGroup(COLLISION_GROUP_NONE)
            self:SetRenderMode( RENDERGROUP_OTHER )
            self:GetPhysicsObject():EnableGravity(false)
            self:GetPhysicsObject():EnableMotion(false)
            self:SetUseType(SIMPLE_USE)
        end
        
        self:DrawShadow(false)
        if(CLIENT)then
            timer.Create("SparkMaker"..self:EntIndex(),3,0, function()
                if(!IsValid(self)) then
                    timer.Remove("SparkMaker"..self:EntIndex())
                    return
                end
                self:MakeSpark()
                timer.Simple(math.Rand(0.3,0.5), function()
                    if(IsValid(self) and math.random(0,1)==1)then
                        self:MakeSpark()
                    end
                end)
            end)
        end
	end


function ENT:MakeSpark()
    local effectdata = EffectData()
    effectdata:SetOrigin( self:GetPos() )
    util.Effect("ManhackSparks",effectdata)
    self:EmitSound("ambient/energy/spark"..math.random(1,6)..".wav")
    if(CLIENT) then
        local dlight = DynamicLight( self:EntIndex() )
        if ( dlight ) then
            dlight.pos = self:GetPos()
            dlight.r = 255
            dlight.g = 255
            dlight.b = 255
            dlight.brightness = 2
            dlight.Decay = 1000
            dlight.Size = 200
            dlight.DieTime = CurTime() + 1
        end
    end
end
if(SERVER) then
    function ENT:Use(activator,caller)
        if!(caller:GetCharacter():GetClass()==CLASS_TECHNICIAN) then return false end
        //if(caller.ActiveQuestion) then return false end
        //caller.ActiveQuestion = true
        local RandomFirst = math.random(-100,100)
        local RandomSecond = math.random(-100,100)
        local Answer = RandomFirst+RandomSecond
        local Question = string.format("Answer: %d + %d",RandomFirst,RandomSecond)
        caller:RequestString("Question",Question,function(text)
            if(tonumber(text)==Answer) then
                print("good")
                self:Remove()
                Jobs.Tasks.Mechanic.Reward(activator)
                //caller.ActiveQuestion = false
            else
                print("bad")
                //caller.ActiveQuestion = false
            end
        end,"")
    end
end
if ( SERVER ) then return end 

function ENT:DrawModel()
    return false
end

function ENT:Think()


end
