if SERVER then
	AddCSLuaFile('glowsticks/client.lua')
	include('glowsticks/server.lua')
else
	include('glowsticks/client.lua')
end

sound.Add({
	name = 'Glowstick.Snap',
	channel = CHAN_USER_BASE + 1,
	volume = 0.1,
	pitch = { 95, 110 },
	soundlevel = SNDLVL_IDLE,
	sound = 'glowstick/glowstick_snap.wav',
})

game.AddAmmoType({
	name = 'glowsticks',
	dmgtype = DMG_CRUSH,
	tracer = TRACER_NONE,
	plydmg = 0,
	npcdmg = 0,
	force = 0,
	maxcarry = 5,
})

cleanup.Register('glowsticks')

local function addStickColorWep(colorPrefix, color)
	local swep = {}

	swep.Base = 'weapon_glowstick'
	swep.Spawnable = true

	if CLIENT then
		swep.PrintName = language.GetPhrase('#glowsticks.printname') .. ' - ' .. string.gsub(colorPrefix, '^%l', string.upper)
		swep.Category = '#glowsticks.spawnmenu.category'
	end

	function swep:GetStickColor()
		return color
	end

	weapons.Register(swep, 'weapon_glowstick_' .. colorPrefix)
end

addStickColorWep('aqua', Color(0, 255, 255))
addStickColorWep('blue', Color(0, 0, 255))
addStickColorWep('green', Color(0, 255, 0))
addStickColorWep('purple', Color(255, 0, 255))
addStickColorWep('red', Color(255, 0, 0))
addStickColorWep('yellow', Color(255, 255, 0))