
AddCSLuaFile()

DEFINE_BASECLASS( "base_anim" )


ENT.PrintName = "Spawn Effect"
ENT.Author = "Lechu2375"
ENT.Information = "Spawn Effect"
ENT.Category = "Helix - Black Mesa"
ENT.bNoPersist = true
ENT.PhysgunDisable = true

ENT.Editable = true
ENT.Spawnable = false
ENT.AdminOnly = true
ENT.RenderGroup = RENDERGROUP_OTHER


	function ENT:Initialize()
		self:SetModel("")
		self:SetSolid(SOLID_NONE)
		self:PhysicsInit(SOLID_NONE)
		self:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
        self:SetColor( Color( 0, 0, 0, 255 ) ) 
        self:SetRenderMode( RENDERGROUP_OTHER )
        self:DrawShadow(false)
	end

if ( SERVER ) then return end 

function ENT:DrawModel()
    return false
end

function ENT:Think()

	local dlight = DynamicLight( self:EntIndex() )
	if ( dlight ) then
		dlight.pos = self:GetPos()
		dlight.r = 0
		dlight.g = 255
		dlight.b = 0
		dlight.brightness = 5
		dlight.Decay = 1000
		dlight.Size = 256
		dlight.DieTime = CurTime() + 4
	end

end
