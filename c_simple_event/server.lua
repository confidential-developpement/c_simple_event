print('^3########^7                                    ^3########^7')
print('^3####^7           ^3Auteur^7 : .Fluuxx#6667            ^3####^7')
print('^3#^7##                                              ##^3#^7')
print('^3#^7#  ^3c_simple_event^7 by CONFIDENTIAL Développement  #^3#^7')
print('^3#^7#                                                #^3#^7')
print('^3#^7#         ^4https://discord.gg/kwy3pPFwJz^7          #^3#^7')
print('^3#^7##                                              ##^3#^7')
print('^3####^7          ^3Version 1.0^7 - ^320/05/2021^7          ^3####^7')
print('^3########^7                                    ^3########^7')

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local eventActif = true -- si true alors l'event se lance tout seul, si false l'event est désactivé
local timerStart = 120*60000 -- temps avant que l'event commence (par default : 6 heures)
local timerEnd = 30*60000 -- temps entre le 'timerStart' et la fin de l'event (par default : 30 minutes)

CreateThread(function()
    while eventActif == true do
        Wait(timerStart)
        SetTimeout(0, function()
            TriggerClientEvent("swt_notifications:Info",-1,"LOS SANTON EVENT","Début de l'event, les pépites d'or sont à vous ! Allez-y vite","bottom",10000,false)
            print('^3[LOS SANTOS EVENT] ^7: la chasse aux pépites d\'or est ^2lancée^7 !')
            TriggerClientEvent('eventStart', -1)
        end)
        Wait(timerEnd)
        TriggerClientEvent("swt_notifications:Info",-1,"LOS SANTON EVENT","Fin de l'event, le prochain aura lieu dans 6 heures !","bottom",10000,false)
        print('^3[LOS SANTOS EVENT] ^7: la chasse aux pépites d\'or est ^1stoppée^7 !')
        TriggerClientEvent('eventStop', -1)
    end
end)

local function Recolte(source)

    local xPlayer  = ESX.GetPlayerFromId(source)
	local gold = xPlayer.getInventoryItem('gold')
	if gold.limit ~= -1 and gold.count >= gold.limit then
		TriggerClientEvent("swt_notifications:Negative",source,"LOS SANTON EVENT","Tes poches sont blindées","bottom",2500,false)
	else
		xPlayer.addInventoryItem('gold', 1)
	end

end

RegisterServerEvent('c_simple_event:recolte')
AddEventHandler('c_simple_event:recolte', function()

	local _source = source
    Recolte(_source)

end)

local function VenteParUn(source)

    local xPlayer  = ESX.GetPlayerFromId(source)
	local gold = xPlayer.getInventoryItem('gold')
	if gold.limit ~= -1 and gold.count <= 0 then
		TriggerClientEvent("swt_notifications:Negative",source,"LOS SANTON EVENT","Tes poches sont vides","bottom",2500,false)
	else
        xPlayer.removeInventoryItem('gold', 1)
		xPlayer.addMoney(Config.PrixPour1)
	end

end

RegisterServerEvent('c_simple_event:venteparun')
AddEventHandler('c_simple_event:venteparun', function()

	local _source = source
    VenteParUn(_source)

end)

local function VenteParDix(source)

    local xPlayer  = ESX.GetPlayerFromId(source)
	local gold = xPlayer.getInventoryItem('gold')
	if gold.limit ~= -1 and gold.count < 10 then
		TriggerClientEvent("swt_notifications:Negative",source,"LOS SANTON EVENT","Tu n'en possède pas autant","bottom",2500,false)
	else
        xPlayer.removeInventoryItem('gold', 10)
		xPlayer.addMoney(Config.PrixPour10)
	end

end

RegisterServerEvent('c_simple_event:ventepardix')
AddEventHandler('c_simple_event:ventepardix', function()

	local _source = source
    VenteParDix(_source)

end)