Config = {}
Config.Locale = 'tw' -- en, tw

Config.AllowAdminInGameCommand = true -- Commands: /giveallitem <item> <count>, /giveallweapon <weapon> <ammo amount>, /addallmoney <account> <amount>
Config.EnableServerCommand = true -- you can using command on console to give

-- how many minutes to give. if don't want, you can type false
Config.TimeGiveItem = 30
Config.TimeGiveMoney = 10 
Config.TimeGiveWeapon = false

Config.Items = {
	{name = 'fixkit', count = 2},
--	{name = 'bread', count = 1}
}

Config.Money = {
	{account = 'bank', amount = 500},
 	{account = 'money', amount = 500},
--	{account = 'black_money', amount = 100}
}

Config.Weapon = {
	{weaponName = 'WEAPON_PISTOL', amount = 10}, -- amount is ammo count
--	{weaponName = 'WEAPON_FIREEXTINGUISHER', amount = 2000}
}