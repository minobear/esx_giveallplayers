This is a simple plugin
You can give all players item or weapon or money with command

also you can setting auto give time in config to all players

**Commands:**
```
/giveallitem <item> <count>

/giveallweapon <weapon> <amount>

/addallmoney <account> <amount>
```

**Config:**
```
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
```

https://forum.cfx.re/t/release-esx-give-all-players-item-or-money/1027386
