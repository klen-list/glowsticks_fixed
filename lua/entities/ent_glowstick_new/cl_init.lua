include('shared.lua')

ENT.PrintName = '#glowsticks.spawnmenu.category'
ENT.Category = '#glowsticks.spawnmenu.category'
ENT.Author = 'Patrick Hunt & Klen_list'
ENT.IconOverride = 'vgui/entities/weapon_glowstick'

function ENT:Draw(fl)
	self:DrawModel(fl)
end

function ENT:Think()
	local color = self:GetColor()

	local dlight = DynamicLight(self:EntIndex())
	if dlight then
		dlight.Pos = self:GetPos()
		dlight.r = color.r
		dlight.g = color.g
		dlight.b = color.b
		dlight.Brightness = 0
		dlight.Size = 256
		dlight.Decay = 0
		dlight.DieTime = CurTime() + 0.05
	end
end