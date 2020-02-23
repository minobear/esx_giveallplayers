Config = {}
Config.Locale = 'en' -- en, tw

Config.AllowAdminInGameCommand = true -- Commands: /giveallitem <item> <count>, /giveallweapon <weapon> <ammo amount>, /addallmoney <account> <amount>
Config.EnableServerCommand = true -- you can using command on console to give. but command prefix need change to "_", example: _giveallitem, _giveallweapon, _addallmoney

-- how many minutes to give. if don't want, you can type false
Config.TimeGiveItem = 30
Config.TimeGiveMoney = false 
Config.TimeGiveWeapon = false

Config.Items = {
	{name = 'water', count = 1},
--	{name = 'bread', count = 2}
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