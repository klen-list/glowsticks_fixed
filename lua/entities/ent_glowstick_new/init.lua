AddCSLuaFile('cl_init.lua')
include('shared.lua')

function ENT:Initialize()
	self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	self:SetModel('models/glowstick/stick.mdl')
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:DrawShadow(false)
	self:PhysWake()

	self:SetColor(color_white)

	if not GetConVar('gmod_glowsticks_lifetime_infinite'):GetBool() then
		SafeRemoveEntityDelayed(self, GetConVar('gmod_glowsticks_lifetime'):GetFloat())
	end
end

function ENT:SpawnFunction(ply, tr, className)
	if not tr.Hit then return end

	local ent = ents.Create(className)
	ent:SetPos(tr.HitPos + tr.HitNormal * 16)
	ent:Spawn()
	ent:Activate()

	ply:AddCleanup('glowsticks', ent)

	return ent
end