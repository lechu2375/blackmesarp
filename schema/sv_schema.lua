
-- Here is where all of your serverside functions should go.

-- Example server function that will slap the given player.



function CreateSpawnerParticle(position)
    local effect = ents.Create("bm_spawneffect")
    effect:SetPos(position)
    effect:Spawn()
    effect:EmitSound("npc/vort/attack_shoot.wav")
    ParticleEffectAttach("teleport_lambda_exit", 1,effect,1)
    timer.Simple(1, function()
        if(IsValid(effect))then
            effect:Remove()
        end
    
    end)
end

function SpawnWithEffect(class,position)
    local pos = position+Vector(0,0,50)
    CreateSpawnerParticle(pos)
    local npc = ents.Create(class)
    npc:SetPos(position)
    npc:Spawn()
end