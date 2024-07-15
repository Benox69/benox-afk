local prevPos = nil
local display = false

function SetDisplay(bool, pin)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool,
        pin = pin,
    })
end

local playerPed = PlayerPedId()

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        local playerPed = PlayerPedId()
        if NetworkIsPlayerActive(PlayerId()) and playerPed ~= 0 then
            local currentPos = GetEntityCoords(playerPed, true)
            if prevPos and currentPos == prevPos then
                if timeLeft > 0 then
                    print(timeLeft)
                    if timeLeft <= 5 and timeLeft >= 2 then
                        PlaySoundFrontend(-1, "TIMER", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0)
                    end
                    if timeLeft < 2 then
                        PlaySoundFrontend(-1, "CHARACTER_SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0)
                    end
                    timeLeft = timeLeft - 1
                    if timeLeft == 0 then
                        local pin = pinGeneration()
                        SetDisplay(true, pin)
                        playerEvents(true)
                    end
                end
            else
                timeLeft = Config.secondsUntilKick
            end
            prevPos = currentPos
        end
    end
end)



function playerEvents(bool)
    SetEntityAlpha(playerPed, bool and 190 or 255, false)
    FreezeEntityPosition(playerPed, bool)
    NetworkSetPlayerIsPassive(bool)
end


RegisterNUICallback("kick", function(data)
    SetDisplay(false)
    TriggerServerEvent('kickas')
end)

RegisterNUICallback("button", function(data)
    SetDisplay(false)
    local coords = GetEntityCoords(playerPed)
    timeLeft = Config.CountdownTime
    playerEvents(false)
    PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0)
end)
function pinGeneration()
    return math.random(1000, 9999)
end

Citizen.CreateThread(function()
    while display do
        Citizen.Wait(0)
        DisableControlAction(0, 1, display) -- LookLeftRight
        DisableControlAction(0, 2, display) -- LookUpDown
        DisableControlAction(0, 142, display) -- MeleeAttackAlternate
        DisableControlAction(0, 18, display) -- Enter
        DisableControlAction(0, 322, display) -- ESC
        DisableControlAction(0, 106, display) -- VehicleMouseControlOverride
    end
end)