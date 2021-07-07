ESX = nil 

Citizen.CreateThread(function()
    while ESX == nil do
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	Citizen.Wait(0)
    end
end)


RegisterNetEvent('n:startpeche')
AddEventHandler('n:startpeche', function()
    peche()
end)

RegisterNetEvent('n:startbarquette')
AddEventHandler('n:startbarquette', function()
    TriggerServerEvent('n:barquette')
end)
function peche()
    local ped = GetPlayerPed(-1)
    local pProps=GetHashKey("prop_fishing_rod_01")
    local time = 12000
    if pechetime and pechetime > GetGameTimer() then 
		if notifCass then 
			RemoveNotification(notifCass) 
		end
		notifCass = ESX.ShowNotification(string.format("~r~Veuillez patienter encore %s seconde(s) avant de re-utiliser votre canne à pêche.", math.floor((pechetime - GetGameTimer()) / 1000))) return 
	end

	local treeeeTime = 0 + time
	pechetime = GetGameTimer() + treeeeTime
    if IsEntityInWater(ped) then 
        TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_STAND_FISHING", 0, true)
        Citizen.Wait(12000)
        TriggerServerEvent('n:fishing')
    elseif not IsEntityInWater(ped) then 
        ESX.ShowNotification('Tu es loin de l\'eau')
    end 
    ClearPedTasks(GetPlayerPed(-1))
    Citizen.Wait(2000)
end 

local vente = { {x = -68.52, y = 213.801 , z = 97.22 } }

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k in pairs(vente) do
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, vente[k].x, vente[k].y, vente[k].z)

            if dist <= 2 then
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_PICKUP~ pour vendre vos ~b~poissons~s~")
				if IsControlJustPressed(1,38) then 
					TriggerServerEvent('n:ventepeche')
				end
            end
		end
    end
end) 
local garagepeche = { {x = -3236.01 ,y = 952.411 ,z = 13.7 } }


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
				spawnCar("burrito3")
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
    local vehicle = CreateVehicle(car, -3231.83, 940.10, 13.53, 288.7, true, false)
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

local del = {
    {x = -3234.27 , y = 946.58, z = 13.73}
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

		for k in pairs(del) do
			
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, del[k].x, del[k].y, del[k].z)

            if dist <= 3 and IsPedInAnyVehicle(PlayerPedId(-1), false) then
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_PICKUP~ pour rentrer votre à ~b~vehicule~s~ dans le ~b~garage~s~")
				if IsControlJustPressed(1,38) then 			
					TriggerEvent('esx:deleteVehicle')
				end
            end
		end
	end
end)

Citizen.CreateThread(function()
    Citizen.Wait(50)
	for i=1, 1 do
		
		local blip = AddBlipForCoord(vente[i].x, vente[i].y, vente[i].z)
		SetBlipSprite (blip, 1)
		SetBlipDisplay(blip, 4)
		SetBlipColour (blip, 3)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Vente de Poissons')
		EndTextCommandSetBlipName(blip)
	end

end)

Citizen.CreateThread(function()
	Citizen.Wait(50)
	for i=1, 1 do
		
		local blip = AddBlipForCoord(garagepeche[i].x, garagepeche[i].y, garagepeche[i].z)
		SetBlipSprite (blip, 1)
		SetBlipDisplay(blip, 4)
		SetBlipColour (blip, 3)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Garage Pecheur')
		EndTextCommandSetBlipName(blip)
	end

end)

Citizen.CreateThread(function()
    local hash = GetHashKey("cs_jimmyboston")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(20)
    end
    ped = CreatePed("PED_TYPE_CIVFEMALE", "cs_jimmyboston", -3236.01 , 952.411 , 12.2 , 275.1554794, false, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetEntityInvincible(ped, true)
    FreezeEntityPosition(ped, true)
end)
