include('shared.lua')

SWEP.PrintName = '#glowsticks.base.printname'
SWEP.Author = 'Patrick Hunt & Klen_list'
SWEP.Instructions = '#glowsticks.instructions'
SWEP.Category = '#glowsticks.spawnmenu.category'

SWEP.DrawAmmo = true
SWEP.ViewModelFOV = 35
SWEP.WepSelectIcon = surface.GetTextureID('vgui/entities/glowstick')

function SWEP:DrawLocalLight()
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

function SWEP:DrawWorldModel(fl)
	self:DrawLocalLight()
	self:DrawModel(fl)
end