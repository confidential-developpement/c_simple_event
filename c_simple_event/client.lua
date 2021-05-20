local eventEnCours = false

RegisterNetEvent('eventStart')
AddEventHandler('eventStart', function()
    eventEnCours = true
end)

RegisterNetEvent('eventStop')
AddEventHandler('eventStop', function()
    eventEnCours = false
end)

CreateThread(function()
    while true do
        if eventEnCours == true then
            Wait(15*60000)
            exports['swt_notifications']:Warning("LOS SANTOS EVENT","Fin de l'event dans 15 minutes","bottom",2500,false)
            Wait(10*60000)
            exports['swt_notifications']:Warning("LOS SANTOS EVENT","Fin de l'event dans 5 minutes","bottom",2500,false)
            Wait(3*60000)
            exports['swt_notifications']:Warning("LOS SANTOS EVENT","Fin de l'event dans 2 minutes","bottom",2500,false)
            Wait(2*60000)
        else
            Wait(10000)
        end
    end
end)

CreateThread(function()
    while true do 
        Wait(0)
        if eventEnCours == true then
            local playerCoords = GetEntityCoords(PlayerPedId())
            for k,v in pairs(Config.GoldLocations) do
                for i=1, #v.Pos, 1 do
                    local distance = #(playerCoords - v.Pos[i])
                    if distance < Config.DistanceRecolte then
                        AddTextEntry("HELP", "Appuyez sur ~INPUT_CONTEXT~ pour ~y~récolter une pépite d'or")
                        DisplayHelpTextThisFrame("HELP", false)
                        if IsControlJustPressed(0, 38) then
                            FreezeEntityPosition(PlayerPedId(), true)
                            ExecuteCommand('e pickup')
                            Wait(1800)
                            TriggerServerEvent('c_simple_event:recolte')
                            FreezeEntityPosition(PlayerPedId(), false)
                        end
                    end
                end
            end

            for k,v in pairs(Config.GoldLocations) do
                for i=1, #v.VentePos, 1 do
                    local distance = #(playerCoords - v.VentePos[i])
                    if distance < 2 then
                        Draw3DText( -1466.9000, -245.9757, 50.9493, 'Orfèvre\n\n\n\n\n[~b~E~w~] Vendre ~y~x1 pépite d\'or~w~ \n [~b~G~w~] Vendre ~y~x10 pépites d\'or',0.5)
                        if IsControlJustPressed(0, 38) then
                            FreezeEntityPosition(PlayerPedId(), true)
                            ExecuteCommand('e pointdown')
                            Wait(1800)
                            TriggerServerEvent('c_simple_event:venteparun')
                            FreezeEntityPosition(PlayerPedId(), false)
                            TriggerEvent('showNotify', "Voici ~g~100$~s~ pour toi !")
                        elseif IsControlJustPressed(0, 47) then
                            FreezeEntityPosition(PlayerPedId(), true)
                            ExecuteCommand('e pointdown')
                            Wait(1800)
                            TriggerServerEvent('c_simple_event:ventepardix')
                            FreezeEntityPosition(PlayerPedId(), false)
                            TriggerEvent('showNotify', "Voici ~g~1000$~s~ pour toi !")
                        end
                    end
                end
            end
        else
            Wait(10000)
        end
    end
end)

CreateThread(function()
    local hash = GetHashKey("csb_abigail")
    while not HasModelLoaded(hash) do
        RequestModel(hash)
        Wait(20)
    end
    ped = CreatePed("PED_TYPE_CIVMALE", "csb_abigail", -1467.0518, -245.9757, 49.9493 -0.98, 50.1644, true, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetEntityInvincible(ped, true)
    FreezeEntityPosition(ped, true)
end)

function Draw3DText(x,y,z,text,scale)
    local onScreen, _x, _y = World3dToScreen2d(x,y,z)
    local pX,pY,pZ = table.unpack(GetGameplayCamCoords())
    SetTextScale(scale, scale)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextEntry("STRING")
    SetTextCentre(true)
    SetTextColour(255, 255, 255, 255)
    AddTextComponentString(text)
    DrawText(_x,_y)
end

RegisterNetEvent('showNotify')

AddEventHandler('showNotify', function(notify)
    ShowAboveRadarMessage(notify)
end)

function ShowAboveRadarMessage(message)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(message)
    DrawNotification(0,1)
end