ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Citizen.CreateThread(function()
	if Config.TimeGiveItem ~= false then		
		SetTimeout(Config.TimeGiveItem * 60000, TimeGiveItems)
	end
	if Config.TimeGiveMoney ~= false then
		SetTimeout(Config.TimeGiveMoney * 60000, TimeGiveMoney)
	end
	if Config.TimeGiveWeapon ~= false then
		SetTimeout(Config.TimeGiveWeapon * 60000, TimeGiveWeapon)
	end	
end)

function TimeGiveItems()
	local xPlayers = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])			
		for i=1, #Config.Items, 1 do
			xPlayer.addInventoryItem(Config.Items[i].name, Config.Items[i].count)	
			TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('subject'), _U('subject2'), _U('item_msg', Config.Items[i].count, ESX.GetItemLabel(Config.Items[i].name)), 'CHAR_MP_MORS_MUTUAL', 9)
		end						
	end
	SetTimeout(Config.TimeGiveItem * 60000, TimeGiveItems)
end

function TimeGiveMoney()
	local xPlayers = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])			
		for i=1, #Config.Money, 1 do
			if Config.Money[i].account == 'money' then
				xPlayer.addMoney(Config.Money[i].amount)
				TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('subject'), _U('subject2'), _U('money_msg', Config.Money[i].amount), 'CHAR_MP_MORS_MUTUAL', 9)
			elseif Config.Money[i].account == 'bank' then
				xPlayer.addAccountMoney(Config.Money[i].account, Config.Money[i].amount)
				TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('subject'), _U('subject2'), _U('bank_msg', Config.Money[i].amount), 'CHAR_MP_MORS_MUTUAL', 9)				
			elseif Config.Money[i].account == 'black_money' then
				xPlayer.addAccountMoney(Config.Money[i].account, Config.Money[i].amount)
				TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('subject'), _U('subject2'), _U('black_msg', Config.Money[i].amount), 'CHAR_MP_MORS_MUTUAL', 9)						
			end
		end						
	end
	SetTimeout(Config.TimeGiveMoney * 60000, TimeGiveMoney)	
end

function TimeGiveWeapon()
	local xPlayers = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])			
		for i=1, #Config.Weapon, 1 do
			xPlayer.addWeapon(Config.Weapon[i].weaponName, Config.Weapon[i].amount)
			TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('subject'), _U('subject2'), _U('weapon_msg', ESX.GetWeaponLabel(Config.Weapon[i].weaponName), Config.Weapon[i].amount), 'CHAR_MP_MORS_MUTUAL', 9)			
		end						
	end
	SetTimeout(Config.TimeGiveWeapon * 60000, TimeGiveWeapon)	
end

TriggerEvent('es:addGroupCommand', 'giveallitem', 'admin', function(source, args, user)
	if Config.AllowAdminInGameCommand then
		if source ~= 0 then
			local _source = source
			local xPlayers = ESX.GetPlayers()
			local item    = args[1]
			local count   = (args[2] == nil and 1 or tonumber(args[2]))
			
			for i=1, #xPlayers, 1 do
				local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

				if ESX.GetItemLabel(item) ~= nil then
					xPlayer.addInventoryItem(item, count)
					TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('subject'), _U('subject2'), _U('item_msg', count, ESX.GetItemLabel(item)), 'CHAR_MP_MORS_MUTUAL', 9)
				else
					TriggerClientEvent('esx:showNotification', _source, _U('unknown_item'))
				end	
			end		
		end
	end
	
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = 'give all players item', params = {{name = "item", help = 'item name'}, {name = "amount", help = 'iteam amount'}}})

RegisterCommand('_giveallitem', function(source, args)
	if Config.EnableServerCommand then
		if source == 0 then
			local xPlayers = ESX.GetPlayers()
			local item    = args[1]
			local count   = (args[2] == nil and 1 or tonumber(args[2]))
			
			for i=1, #xPlayers, 1 do
				local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

				if ESX.GetItemLabel(item) ~= nil then
					xPlayer.addInventoryItem(item, count)
					TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('subject'), _U('subject2'), _U('item_msg', count, ESX.GetItemLabel(item)), 'CHAR_MP_MORS_MUTUAL', 9)
					print('You give all players ' ..count.. 'x ' ..item)
				else
					print(_U('unknown_item'))
				end	
			end		
		end
	end
end)

TriggerEvent('es:addGroupCommand', 'giveallweapon', 'admin', function(source, args, user)
	if Config.AllowAdminInGameCommand then
		if source ~= 0 then
			local _source = source
			local xPlayers = ESX.GetPlayers()
			local weaponName = string.upper(args[1])
			local amount = (args[2] == nil and 1 or tonumber(args[2]))

			for i=1, #xPlayers, 1 do
				local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
				
				if ESX.GetWeaponLabel(weaponName) ~= nil then
					xPlayer.addWeapon(weaponName, amount)
					TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('subject'), _U('subject2'), _U('weapon_msg', ESX.GetWeaponLabel(weaponName), amount), 'CHAR_MP_MORS_MUTUAL', 9)
				else
					TriggerClientEvent('esx:showNotification', _source, _U('unknown_weapon'))
				end
			end	
		end
	end
	
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = 'give all players weapon', params = {{name = "weapon", help = 'weapon name'}, {name = "ammo", help = 'ammo amount'}}})

RegisterCommand('_giveallweapon', function(source, args)
	if Config.EnableServerCommand then
		if source == 0 then
			local xPlayers = ESX.GetPlayers()
			local weaponName = string.upper(args[1])
			local amount = (args[2] == nil and 1 or tonumber(args[2]))

			for i=1, #xPlayers, 1 do
				local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
				
				if ESX.GetWeaponLabel(weaponName) ~= nil then
					xPlayer.addWeapon(weaponName, amount)
					TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('subject'), _U('subject2'), _U('weapon_msg', ESX.GetWeaponLabel(weaponName), amount), 'CHAR_MP_MORS_MUTUAL', 9)
					print('You give all players ' ..amount.. 'x ' ..weaponName)
				else
					print(_U('unknown_weapon'))
				end
			end	
		end
	end	
end)

TriggerEvent('es:addGroupCommand', 'addallmoney', 'admin', function(source, args, user)
	if Config.AllowAdminInGameCommand then
		if source ~= 0 then
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
					TriggerClientEvent('esx:showNotification', _source, _U('unknown_amount'))
				end
			end	
		end
	end
	
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = 'give all players money', params = {{name = "account", help = 'money account'}, {name = "amount", help = 'money amount'}}})

RegisterCommand('_addallmoney', function(source, args)
	if Config.EnableServerCommand then
		if source == 0 then
			local xPlayers = ESX.GetPlayers()
			local account = args[1]
			local amount  = tonumber(args[2])

			for i=1, #xPlayers, 1 do
				local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

				if amount ~= nil then
					if account == "money" then
						xPlayer.addMoney(amount)
						TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('subject'), _U('subject2'), _U('money_msg', amount), 'CHAR_MP_MORS_MUTUAL', 9)
						print('You give all players $' ..amount.. ' money')
					elseif account == 'bank' then
						xPlayer.addAccountMoney(account, amount)
						TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('subject'), _U('subject2'), _U('bank_msg', amount), 'CHAR_MP_MORS_MUTUAL', 9)
						print('You give all players $' ..amount.. ' into bank')
					elseif account == 'black_money' then
						xPlayer.addAccountMoney(account, amount)
						TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('subject'), _U('subject2'), _U('black_msg', amount), 'CHAR_MP_MORS_MUTUAL', 9)
						print('You give all players $' ..amount.. ' black money')
					else
						print(_U('unknown_account', 'money、bank、black_money'))
					end
				else
					print(_U('unknown_amount'))
				end
			end	
		end
	end
end)
