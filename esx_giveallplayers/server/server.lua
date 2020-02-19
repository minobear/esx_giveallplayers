ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('es:addGroupCommand', 'giveallitem', 'admin', function(source, args, user)
	local xPlayers = ESX.GetPlayers()
	local item    = args[1]
	local count   = (args[2] == nil and 1 or tonumber(args[2]))
	
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

		xPlayer.addInventoryItem(item, count)
		TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('subject'), _U('subject2'), _U('item_msg', count, ESX.GetItemLabel(item)), 'CHAR_MP_MORS_MUTUAL', 9)
	end	
	
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = 'give all players item', params = {{name = "item", help = 'item name'}, {name = "amount", help = 'iteam amount'}}})


TriggerEvent('es:addGroupCommand', 'giveallweapon', 'admin', function(source, args, user)
	local xPlayers = ESX.GetPlayers()
	local weaponName = string.upper(args[1])
	local amount = (args[2] == nil and 1 or tonumber(args[2]))

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		
		if ESX.GetWeaponLabel(weaponName) ~= nil then
			xPlayer.addWeapon(weaponName, amount)
			TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('subject'), _U('subject2'), _U('weapon_msg', ESX.GetWeaponLabel(weaponName), amount), 'CHAR_MP_MORS_MUTUAL', 9)
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('unknown_weapon'))
		end
	end	
	
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = 'give all players weapon', params = {{name = "weapon", help = 'weapon name'}, {name = "ammo", help = 'ammo amount'}}})

TriggerEvent('es:addGroupCommand', 'addallmoney', 'admin', function(source, args, user)
	local _source = source
	local xPlayers = ESX.GetPlayers()
	local account = args[1]
	local amount  = tonumber(args[2])

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

		if amount ~= nil then
			if account == "money" then
				xPlayer.addMoney(amount)
				TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('subject'), _U('subject2'), _U('money_msg', amount), 'CHAR_MP_MORS_MUTUAL', 9)
			elseif account == 'bank' then
				xPlayer.addAccountMoney(account, amount)
				TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('subject'), _U('subject2'), _U('bank_msg', amount), 'CHAR_MP_MORS_MUTUAL', 9)
			elseif account == 'black_money' then
				xPlayer.addAccountMoney(account, amount)
				TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('subject'), _U('subject2'), _U('black_msg', amount), 'CHAR_MP_MORS_MUTUAL', 9)
			else
				TriggerClientEvent('esx:showNotification', _source, _U('unknown_account', 'money、bank、black_money'))
			end
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('unknown_amount'))
		end
	end	
	
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = 'give all players money', params = {{name = "account", help = 'money account'}, {name = "amount", help = 'money amount'}}})
