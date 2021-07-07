ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

PlayerSelling = {}

RegisterServerEvent('n:fishing')
AddEventHandler('n:fishing', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem('poisson', 1)

end)

RegisterServerEvent('n:barquette')
AddEventHandler('n:barquette', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local Barq = xPlayer.getInventoryItem('poisson').count
    if Barq >= 2 then 
        local xPlayer = ESX.GetPlayerFromId(source)
        xPlayer.removeInventoryItem('poisson', 2)
        xPlayer.removeInventoryItem('barquette', 1)
        xPlayer.addInventoryItem('poissonbarquette', 1)
    end 
end)

PlayerSelling = {}

local function sellbarquette()
    local xPlayer = ESX.GetPlayerFromId(source)
    local Barquette = xPlayer.getInventoryItem('poissonbarquette').count
    if PlayerSelling[source] == true then 
        if Barquette >= 1 then 
            local payement = 10
            payement = math.random(10,20)
            xPlayer.removeInventoryItem("poissonbarquette", 1)
            xPlayer.addMoney(payement)
        end 
    end 
end 

RegisterServerEvent('n:ventepeche')
AddEventHandler('n:ventepeche', function()
    if PlayerSelling[source] == false then 
        PlayerSelling[source] = false
    else 
        PlayerSelling[source] = true 
        sellbarquette()
    end
end)


RegisterServerEvent('n:stopvente')
AddEventHandler('n:stopvente', function()
    if PlayerSelling[source] == true then 
        PlayerSelling[source] = false
    else 
        PlayerSelling[source] = false 
    end
end)




ESX.RegisterUsableItem('canne', function(source)
	TriggerClientEvent('n:startpeche', source)
    Citizen.Wait(2000)
end)
ESX.RegisterUsableItem('barquette', function(source)
	TriggerClientEvent('n:startbarquette', source)
end)
