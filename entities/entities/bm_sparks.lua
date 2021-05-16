
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

//This effect can be spawned manualy, If you will be watching at door then it will be parented to it check ENT:SpawnFunction method
	function ENT:Initialize()
        if(SERVER)then
            self:SetModel("models/props_c17/gravestone003a.mdl")
            self:SetSolid(SOLID_BBOX)
            self:SetMoveType(MOVETYPE_NONE)
            self:PhysicsInit(SOLID_BBOX)
            self:SetCollisionGroup(COLLISION_GROUP_NONE)
            self:SetRenderMode( RENDERGROUP_OTHER )
            self:GetPhysicsObject():EnableGravity(false)
            self:GetPhysicsObject():EnableMotion(false)
            self:SetUseType(SIMPLE_USE)
            self.BadAnswers = 0
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

        if(caller.ActiveWireConnection and IsValid(caller.ActiveWireConnection)) then //hmm

            return
        end
        caller.ActiveWireConnection = self
        net.Start("connectWires")
        net.Send(caller)
    end

    function ENT:SpawnFunction(client, trace)
		local door = trace.Entity
		local position = trace.HitPos

		local entity = ents.Create("bm_sparks")
		entity:SetPos(trace.HitPos)
		entity:Spawn()
		if (door:IsDoor() and !IsValid(door.BrokenEffect)) then
            entity:SetPos(door:GetPos())
            entity:SetParent(door,1)
            door.BrokenEffect = entity
		end

		return entity
	end

end
if ( SERVER ) then return end 

function ENT:DrawModel()
    return false
end

function ENT:Think()


end
