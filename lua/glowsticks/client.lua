if
	GetConVar('cl_language'):GetString() == 'russian' or
	GetConVar('gmod_language'):GetString() == 'ru'
then
	language.Add('glowsticks_ammo', 'Светопалочки')
	language.Add('cleanup_glowsticks', 'Светопалочки')
	language.Add('cleaned_glowsticks', 'Светопалочки удалены!')

	language.Add('glowsticks.menu.name', 'Настройки светопалочек')

	language.Add('glowsticks.menu.serversetting', '====== Серверные настройки ======')
	language.Add('glowsticks.menu.lifetimeinf', 'Отключить автоудаление светопалочек')
	language.Add('glowsticks.menu.lifetime', 'Время автоудаления')

	language.Add('glowsticks.menu.clientsetting', '====== Клиентские настройки ======')

	language.Add('glowsticks.menu.stickcolor', 'Цвет светопалочек')

	language.Add('glowsticks.spawnmenu.category', 'Световая палочка (ХИС)')
	language.Add('glowsticks.printname', 'ХИС')
	language.Add('glowsticks.base.printname', 'ХИС - Свой цвет')
	language.Add('glowsticks.instructions', 'ЛКМ - бросить, ПКМ - кинуть на расстояние')
else
	language.Add('cleanup_glowsticks', 'Glow Sticks')
	language.Add('cleaned_glowsticks', 'Glow Sticks are gone!')
	language.Add('glowsticks_ammo', 'Glow Sticks')

	language.Add('glowsticks.menu.name', 'Glow Sticks Options')

	language.Add('glowsticks.menu.serversetting', '====== Server Settings ======')
	language.Add('glowsticks.menu.lifetimeinf', 'Should glow sticks live forever?')
	language.Add('glowsticks.menu.lifetime', 'Glow Sticks Lifetime in seconds')

	language.Add('glowsticks.menu.clientsetting', '====== Client Settings ======')

	language.Add('glowsticks.menu.stickcolor', 'Glow Sticks Color')

	language.Add('glowsticks.spawnmenu.category', 'Glow Sticks')
	language.Add('glowsticks.printname', 'Glowstick')
	language.Add('glowsticks.base.printname', 'Glowstick - Custom')
	language.Add('glowsticks.instructions', 'Left Click to drop, Right Click to throw')
end

CreateClientConVar('gmod_glowsticks_red', '255', true, true)
CreateClientConVar('gmod_glowsticks_green', '255', true, true)
CreateClientConVar('gmod_glowsticks_blue', '255', true, true)
CreateClientConVar('gmod_glowsticks_alpha', '255', true, true)

local function openMenu(basePanel)
	do
		local logo = vgui.Create('DImage')
		logo:SetImage('vgui/gs_logo')
		logo:SetSize(300, 150)
		basePanel:AddPanel(logo)
	end

	-- Server settings
	basePanel:AddControl('Label', { Text = '#glowsticks.menu.serversetting' })

	basePanel:AddControl('CheckBox', {
		Label = '#glowsticks.menu.lifetimeinf',
		Command = 'gmod_glowsticks_lifetime_infinite',
	})

	basePanel:AddControl('Slider', {
		Label = '#glowsticks.menu.lifetime',
		Command = 'gmod_glowsticks_lifetime',
		Type = 'Integer',
		Min = '5',
		Max = '60',
	})

	-- Client settings
	basePanel:AddControl('Label', { Text = '#glowsticks.menu.clientsetting' })

	basePanel:AddControl('Color', {
		Label = '#glowsticks.menu.stickcolor',
		Red = 'gmod_glowsticks_red',
		Blue = 'gmod_glowsticks_blue',
		Green = 'gmod_glowsticks_green',
		Alpha = 'gmod_glowsticks_alpha',
		ShowHSV = 1,
		ShowRGB = 1,
		Multiplier = 255,
	})

	basePanel:AddControl('Label', { Text = 'Glow Sticks by Patrick Hunt (fixed ver. by Klen_list)' })
end

hook.Add('PopulateToolMenu', 'GlowSticks.LoadMenu', function()
	spawnmenu.AddToolMenuOption('Options', 'Player', 'Glowsticks', '#glowsticks.menu.name', '', '', openMenu)
end)