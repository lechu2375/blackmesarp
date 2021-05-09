
local PLUGIN = PLUGIN

PLUGIN.name = "Crosshair"
PLUGIN.author = "Lechu2375"
PLUGIN.description = "A Crosshair."

if (CLIENT) then


	local aimVector, punchAngle, ft, screen, scaleFraction, distance
	local filter = {}
local classes = {
	["ix_item"] = true,
	["func_button"] = true,
	["func_door"] = true,
	["prop_door_rotating"] = true,
	["class C_BaseEntity"] = true,
	["func_door_rotating"] = true
}
	local LambdaColor = Color(251,126,20, 255 )
	local message = "Wciśnij E by użyć"

	surface.SetFont( "ixMonoMediumFont" )
	local sizeX = surface.GetTextSize(message)/2
	function PLUGIN:DrawCrosshair(x, y, trace)
		local entity = trace.Entity
		distance = trace.StartPos:DistToSqr(trace.HitPos)
		local center = Vector( ScrW() / 2, ScrH() / 2, 0 )
		surface.SetDrawColor(251,126,20,255)
		//print(entity:GetClass())
		
		if (IsValid(entity) and  classes[entity:GetClass()] and
			entity:GetPos():DistToSqr(trace.StartPos) <= 16384) then
			surface.DrawCircle( center.x, center.y, 35,251,126,20,255)
			draw.SimpleText(message,"ixMonoMediumFont",center.x-sizeX,center.y+50,LambdaColor,TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP )
			return
		end



		


		surface.DrawLine(center.x,center.y-15,center.x,center.y-35)
		surface.DrawLine(center.x+1,center.y-15,center.x+1,center.y-35)

		surface.DrawLine((center.x-27),(center.y+15),(center.x-10),center.y)
		surface.DrawLine((center.x-26),(center.y+15),(center.x-9),center.y)

		surface.DrawLine((center.x+27),(center.y+15),center.x+10,center.y)
		surface.DrawLine((center.x+28),(center.y+15),center.x+11,center.y)

	end

	-- luacheck: globals g_ContextMenu
	function PLUGIN:PostDrawHUD()
		local client = LocalPlayer()
		if (!client:GetCharacter() or !client:Alive()) then
			return
		end

		local entity = Entity(client:GetLocalVar("ragdoll", 0))

		if (entity:IsValid()) then
			return
		end

		local wep = client:GetActiveWeapon()
		local bShouldDraw = hook.Run("ShouldDrawCrosshair", client, wep)

		if (bShouldDraw == false or !IsValid(wep) or wep.DrawCrosshair == false) then
			return
		end

		if (bShouldDraw == false or g_ContextMenu:IsVisible() or
			(IsValid(ix.gui.characterMenu) and !ix.gui.characterMenu:IsClosing())) then
			return
		end

		aimVector = client:EyeAngles()
		punchAngle = client:GetViewPunchAngles()
		ft = FrameTime()
		filter = {client}

		local vehicle = client:GetVehicle()
		if (vehicle and IsValid(vehicle)) then
			aimVector = aimVector + vehicle:GetAngles()
			table.insert(filter, vehicle)
		end

		local data = {}
			data.start = client:GetShootPos()
			data.endpos = data.start + (aimVector + punchAngle):Forward() * 65535
			data.filter = filter
		local trace = util.TraceLine(data)

		local drawTarget = self
		local drawFunction = self.DrawCrosshair

		-- we'll manually call this since CHudCrosshair is never drawn; checks are already performed
		if (wep.DoDrawCrosshair) then
			drawTarget = wep
			drawFunction = wep.DoDrawCrosshair
		end

		screen = trace.HitPos:ToScreen()
		drawFunction(drawTarget, screen.x, screen.y, trace)
	end
end
