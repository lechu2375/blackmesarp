
-- The shared init file. You'll want to fill out the info for your schema and include any other files that you need.

-- Schema info
Schema.name = "Black Mesa RP"
Schema.author = "Lechu2375"
Schema.description = "Odkrywaj i huj."

-- Additional files that aren't auto-included should be included here. Note that ix.util.Include will take care of properly
-- using AddCSLuaFile, given that your files have the proper naming scheme.

-- You could technically put most of your schema code into a couple of files, but that makes your code a lot harder to manage -
-- especially once your project grows in size. The standard convention is to have your miscellaneous functions that don't belong
-- in a library reside in your cl/sh/sv_schema.lua files. Your gamemode hooks should reside in cl/sh/sv_hooks.lua. Logical
-- groupings of functions should be put into their own libraries in the libs/ folder. Everything in the libs/ folder is loaded
-- automatically.
ix.util.Include("cl_schema.lua")
ix.util.Include("sv_schema.lua")

ix.util.Include("cl_hooks.lua")
ix.util.Include("sh_hooks.lua")
ix.util.Include("sv_hooks.lua")

-- You'll need to manually include files in the meta/ folder, however.
ix.util.Include("meta/sh_character.lua")
ix.util.Include("meta/sh_player.lua")


//anim class
ix.anim.SetModelClass("models/humans/bms_cwork.mdl", "player")

game.AddParticles( "particles/teleporters.pcf" )
PrecacheParticleSystem( "teleport_lambda_exit")

if ( SERVER ) then
	-- A test console command to see if the particle works, spawns the particle where the player is looking at. 
	concommand.Add( "particleitup", function( ply, cmd, args )
		local pos = ply:GetEyeTrace().HitPos
		SpawnWithEffect("npc_vj_bmsn_bullsquid",pos)
	end )
end