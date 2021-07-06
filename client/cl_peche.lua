ESX = nil 

Citizen.CreateThread(function()
    while ESX == nil do
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	Citizen.Wait(0)
    end
end)


RegisterNetEvent('n:startpeche')
AddEventHandler('n:startpeche', function()
    local ped = GetPlayerPed(-1)
    if IsEntityInWater(ped) then 
        TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_STAND_FISHING", 0, true)
        TriggerServerEvent('n:fishing')
    else 
        ESX.ShowNotification('Tu es loin de l\'eau')
    end
end)

local vente = {x = ,y = ,z = }

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)
        local ped = GetPlayerPed(-1)
        ESX.ShowNotification('Appuyez sur ~g~E~s~ pour commencer à vendre')
        if IsEntityInZone(ped, vente) and IsControlJustPressed(1, 38) then 
            Citizen.Wait(10)
            TriggerServerEvent('n:ventepeche')
            ESX.ShowNotification('Appuyez sur ~g~E~s~ pour arreter de vendre')
            if IsControlJustPressed(1, 38) then 
                TriggerServerEvent('n:stopvente')
            end 
        else 
            ESX.ShowNotification('Tu n\'as rien a vendre')
        end 
    end 
end)

local garagepeche = {x = ,y = ,z = }


local garagepecheur = {
	Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {255, 255, 255}, Title = "Garage Pecheur - Véhicule" },
	Data = { currentMenu = "Garage Pecheur", "Test" },
	Events = {
		onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
			PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
			local slide = btn.slidenum
			local btn = btn.name
			local check = btn.unkCheckbox
			if btn == "Burrito" then
				SetVehicleWindowTint(vehicle, 5)
				Citizen.Wait(1)
				spawnCar("burrito")
				CloseMenu(garagepecheur)
		end
	end,
},
	Menu = {
		["Garage Pecheur"] = {
			b = {
				{name = "Burrito", ask = ">", askX = true},
			}
		}
	}
}

function spawnCar(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(50)
    end

    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
    local vehicle = CreateVehicle(car, 294.62, -607.61, 43.11, 72.33, true, false)
    SetPedIntoVehicle(PlayerPedId(), vehicle, -1)
    
    SetEntityAsNoLongerNeeded(vehicle)
	SetModelAsNoLongerNeeded(vehicleName)
	SetVehicleWindowTint(vehicle, 3)
	SetVehicleNumberPlateText(vehicle, "PECHEUR")
        
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k in pairs(garagepeche) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, garagepeche[k].x, garagepeche[k].y, garagepeche[k].z)

            if dist <= 1.2 then
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_PICKUP~ pour accéder au ~b~garage~s~")
				if IsControlJustPressed(1,38) then 
					CreateMenu(garagepecheur)
				end
            end
		end
    end
end) 