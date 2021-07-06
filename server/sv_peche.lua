ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('n:fishing')
AddEventHandler('n:fishing', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem('poisson', 1)

end)

RegisterServerEvent('n:barquette')
AddEventHandler('n:barquette', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getInventoryItem('poisson') >= 2 then 
        xPlayer.removeInventoryItem('poisson', 2)
        Citizen.Wait(10)
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
        ESX.ShowNotification('Tu n\'as rien a vendre ')
        PlayerSelling[source] == false
    else 
        PlayerSelling[source] == true 
        ESX.ShowNotification('~g~Vente~s~ en cours... ')
        sellbarquette()
    end
end)


RegisterServerEvent('n:stopvente')
AddEventHandler('n:stopvente', function()
    if PlayerSelling[source] == true then 
        PlayerSelling[source] == false
    else 
        PlayerSelling[source] == false 
    end
end)




ESX.RegisterUsableItem('barquette'
, function()
end)

ESX.RegisterUsableItem('canne'
, function()
    TriggerClientEvent('n:startpeche')
end)
