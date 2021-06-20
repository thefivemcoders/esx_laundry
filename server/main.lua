ESX 						   = nil
local CopsConnected       	   = 0
local PlayersHarvestingKoda    = {}
local PlayersTransformingKoda  = {}
local PlayersSellingKoda       = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function CountCops()
	local xPlayers = ESX.GetPlayers()

	CopsConnected = 0

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			CopsConnected = CopsConnected + 1
		end
	end

	SetTimeout(120 * 1000, CountCops)
end

CountCops()

--kodeina
local function HarvestKoda(source)

	SetTimeout(Config.TimeToWash, function()
		if PlayersHarvestingKoda[source] then
			local xPlayer = ESX.GetPlayerFromId(source)
			local koda = xPlayer.getInventoryItem('apple')

			if koda.limit ~= -1 and koda.count >= koda.limit then
				TriggerClientEvent('esx:showNotification', source, _U('machine_full'))
			else
				xPlayer.addInventoryItem('washed_clothes', 1)
				HarvestKoda(source)
			end
		end
	end)
end

RegisterServerEvent('esx_laundry:startHarvestKoda')
AddEventHandler('esx_laundry:startHarvestKoda', function()
	local _source = source

	if not PlayersHarvestingKoda[_source] then
		PlayersHarvestingKoda[_source] = true
		TriggerClientEvent('esx:showNotification', _source, _U('wash_cloth'))
		HarvestKoda(_source)
	else
		print(('esx_laundry: %s attempted to exploit the marker!'):format(GetPlayerIdentifiers(_source)[1]))
	end
end)

RegisterServerEvent('esx_laundry:stopHarvestKoda')
AddEventHandler('esx_laundry:stopHarvestKoda', function()
	local _source = source
	

	PlayersHarvestingKoda[_source] = false
end)

local function TransformKoda(source)

	SetTimeout(Config.TimeToIron, function()
		if PlayersTransformingKoda[source] then
			local xPlayer = ESX.GetPlayerFromId(source)
			local kodaQuantity = xPlayer.getInventoryItem('washed_clothes').count
			local pooch = xPlayer.getInventoryItem('ironed_clothes')

			if pooch.limit ~= -1 and pooch.count >= pooch.limit then
				TriggerClientEvent('esx:showNotification', source, _U('no_wahsed_cloths'))
			elseif kodaQuantity < 5 then
				TriggerClientEvent('esx:showNotification', source, _U('no_more_wahsed_cloths'))
			else
				xPlayer.removeInventoryItem('washed_clothes', 1)
				xPlayer.addInventoryItem('ironed_clothes', 1)

				TransformKoda(source)
			end
		end
	end)
end

RegisterServerEvent('esx_laundry:startTransformKoda')
AddEventHandler('esx_laundry:startTransformKoda', function()
	local _source = source

	if not PlayersTransformingKoda[_source] then
		PlayersTransformingKoda[_source] = true

		TriggerClientEvent('esx:showNotification', _source, _U('wait_iron_cloth'))
		TransformKoda(_source)
	else
		print(('esx_laundry: %s attempted to exploit the marker!'):format(GetPlayerIdentifiers(_source)[1]))
	end
end)

RegisterServerEvent('esx_laundry:stopTransformKoda')
AddEventHandler('esx_laundry:stopTransformKoda', function()
	local _source = source

	PlayersTransformingKoda[_source] = false
end)

local function SellKoda(source)

	SetTimeout(Config.TimeToSell, function()
		if PlayersSellingKoda[source] then
			local xPlayer = ESX.GetPlayerFromId(source)
			local poochQuantity = xPlayer.getInventoryItem('ironed_clothes').count

			if poochQuantity == 0 then
				TriggerClientEvent('esx:showNotification', source, _U('you_do_not_have_packed_cloth'))
			else
				xPlayer.removeInventoryItem('ironed_clothes', 1)
				if CopsConnected == 0 then
					xPlayer.addInventoryItem('packed_clothes', 1)
					TriggerClientEvent('esx:showNotification', source, _U('sell_cloth'))
				elseif CopsConnected == 1 then
					xPlayer.addInventoryItem('packed_clothes', 1)
					TriggerClientEvent('esx:showNotification', source, _U('sell_cloth'))
				elseif CopsConnected == 2 then
					xPlayer.addInventoryItem('packed_clothes', 1)
					TriggerClientEvent('esx:showNotification', source, _U('sell_cloth'))
				elseif CopsConnected == 3 then
					xPlayer.addInventoryItem('packed_clothes', 1)
					TriggerClientEvent('esx:showNotification', source, _U('sell_cloth'))
				elseif CopsConnected == 4 then
					xPlayer.addInventoryItem('packed_clothes', 1)
					TriggerClientEvent('esx:showNotification', source, _U('sell_cloth'))
				elseif CopsConnected >= 5 then
					xPlayer.addInventoryItem('packed_clothes', 1)
					TriggerClientEvent('esx:showNotification', source, _U('sell_cloth'))
				end

				SellKoda(source)
			end
		end
	end)
end

RegisterServerEvent('esx_laundry:startSellKoda')
AddEventHandler('esx_laundry:startSellKoda', function()
	local _source = source

	if not PlayersSellingKoda[_source] then
		PlayersSellingKoda[_source] = true

		TriggerClientEvent('esx:showNotification', _source, _U('sell_packed_cloths'))
		SellKoda(_source)
	else
		print(('esx_laundry: %s attempted to exploit the marker!'):format(GetPlayerIdentifiers(_source)[1]))
	end
end)

RegisterServerEvent('esx_laundry:stopSellKoda')
AddEventHandler('esx_laundry:stopSellKoda', function()
	local _source = source

	PlayersSellingKoda[_source] = false
end)

RegisterServerEvent('esx_laundry:GetUserInventory')
AddEventHandler('esx_laundry:GetUserInventory', function(currentZone)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	TriggerClientEvent('esx_laundry:ReturnInventory',
		_source,
		xPlayer.getInventoryItem('washed_clothes').count,
		xPlayer.getInventoryItem('ironed_clothes').count,
		xPlayer.job.name,
		currentZone
	)
end)

