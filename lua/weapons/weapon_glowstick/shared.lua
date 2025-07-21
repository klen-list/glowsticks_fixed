AddCSLuaFile()
AddCSLuaFile('cl_init.lua')

SWEP.Spawnable = true

SWEP.ViewModel = 'models/weapons/c_glowstick.mdl'
SWEP.WorldModel = 'models/glowstick/stick.mdl'

SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom	= false
SWEP.Slot = 1
SWEP.SlotPos = 1

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 5
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = 'glowsticks'

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = 'none'

function SWEP:Initialize()
	self:SetWeaponHoldType('slam')
end

do
	local defaultColor = Color(0, 255, 0)
	local customColor = Color(0, 255, 0)

	function SWEP:GetStickColor()
		local ply = self:GetOwner()

		local color = customColor

		if ply:IsBot() then
			color = defaultColor
		else
			customColor.r = ply:GetInfoNum('gmod_glowsticks_red', 255)
			customColor.g = ply:GetInfoNum('gmod_glowsticks_green', 255)
			customColor.b = ply:GetInfoNum('gmod_glowsticks_blue', 255)
			color = customColor
		end

		return color
	end
end

function SWEP:Think()
	self:SetColor(self:GetStickColor())

	if CLIENT then
		self:DrawLocalLight()
	end
end

function SWEP:Deploy()
	self:SendWeaponAnim(ACT_VM_DRAW)
	self:SetNextPrimaryFire(CurTime() + 1.75)

	return true
end

function SWEP:DoStickThrow(isPrimary)
	if self:Ammo1() <= 0 then return end

	self:SendWeaponAnim(isPrimary and ACT_VM_SECONDARYATTACK or ACT_VM_THROW)

	self:TakePrimaryAmmo(1)

	timer.Simple(0.5, function()
		if not IsValid(self) then return end

		local ply = self:GetOwner()
		if not IsValid(ply) then return end

		ply:SetAnimation(PLAYER_ATTACK1)

		if SERVER then
			local ent = ents.Create('ent_glowstick_new')
			if not IsValid(ent) then return end

			ent:SetPos(ply:EyePos() + (ply:GetAimVector() * 16))
			ent:SetAngles(ply:EyeAngles())
			ent:Spawn()
			ent:Activate()
			ent:SetColor(self:GetStickColor())

			ply:AddCleanup('glowsticks', ent)

			local phys = ent:GetPhysicsObject()
			if not IsValid(phys) then return end

			phys:SetVelocity(ply:GetAimVector() * (isPrimary and 125 or 600))
			phys:AddAngleVelocity(Vector(
				math.random(-1000, 1000),
				math.random(-1000, 1000),
				math.random(-1000, 1000))
			)
		end

		self:EmitSound('Glowstick.Snap')
	end)

	timer.Simple(1, function()
		if not IsValid(self) then return end
		self:SendWeaponAnim(ACT_VM_DRAW)
	end)
end

function SWEP:PrimaryAttack()
	self:DoStickThrow(true)
	self:SetNextPrimaryFire(CurTime() + 2)
end

function SWEP:SecondaryAttack()
	self:DoStickThrow(false)
	self:SetNextSecondaryFire(CurTime() + 2)
end

function SWEP:PreDrawViewModel()
	local col = self:GetColor()

	Material('models/glowstick/glow'):SetVector('$color2', Vector(
		col.r / 255,
		col.g / 255,
		col.b / 255
	))
end

do
	local vecOne = Vector(1, 1, 1)
	function SWEP:PostDrawViewModel()
		Material('models/glowstick/glow'):SetVector('$color2', vecOne)
	end
end