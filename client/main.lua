if Config.Framework == "esx" then
    ESX = exports["es_extended"]:getSharedObject()
elseif Config.Framework == "qb" then
    QBcore = exports['qb-core']:GetCoreObject()
end


Target = function()
    if Config.Main.Target.Use then
        if Config.Main.Target.Type == "ox_target" then
            exports.ox_target:addBoxZone({
                coords = Config.Main.Target.Options.Position,
                size = vec3(2, 2, 2),
                rotation = 45,
                debug = Config.Main.Target.Options.Debug,
                drawSprite = true,
                options = {
                    {
                        name = "benzo:policenotify:openmenu",
                        onSelect = function()
                            Menu()
                        end,
                        icon = "fa-solid fa-circle-user",
                        label = "Benzo Police Notify",
                        distance = 2.0
                    }
                }
            })
        elseif Config.Main.Target.Type == "qb_target" then
            exports['qb-target']:AddCircleZone("benzo:policenotify:openmenu", Config.Main.Target.Options.Position, 1.5, {
                name = "benzo:policenotify:openmenu",
                debugPoly = Config.Main.Target.Options.Debug,
                useZ = true
            }, {
                options = {
                    {
                        num = 1,
                        icon = "fa-solid fa-circle-user",
                        label = "Open Armory",
                        targeticon = "fa-solid fa-circle-user",
                        action = function()
                            Menu()
                        end,
                        drawDistance = 10.0,
                        drawColor = { 255, 255, 255, 255 },
                        successDrawColor = { 0, 255, 0, 255 }
                    }
                },
                distance = 2.0
            })
        elseif Config.Main.Target.Type == "qtarget" then
            exports["qtarget"]:AddBoxZone("benzo:policenotify:openmenu", Config.Main.Target.Options.Position, 1, 1, {
                name = "benzo:policenotify:openmenu",
                heading = 300.0,
                debugPoly = Config.Main.Target.Options.Debug,
                minZ = -10.0,
                maxZ = 200.0,
            }, {
                options = {
                    {
                        action = function()
                            Menu()
                        end,
                        icon = "fa-solid fa-circle-user",
                        label = "Benzo Police Notify",
                    },
                },
                distance = 2.0

            })
        end
    end
end

ShowTextUI = function()
    if Config.Main.TextUI.Type == "esx" then
        exports['esx_textui']:TextUI(Config.Main.TextUI.Options.Text, Config.Main.TextUI.Options.Type)
    elseif Config.Main.TextUI.Type == "qb" then
        exports['qb-core']:DrawText(Config.Main.TextUI.Options.Text, Config.Main.TextUI.Options.Pos)
    elseif Config.Main.TextUI.Type == "ox" then
        lib.showTextUI(Config.Main.TextUI.Options.Text, {
            position = Config.Main.TextUI.Options.Pos or 'right-center',
            icon = 'hand',
            style = {
                borderRadius = 0,
                backgroundColor = '#48BB78',
                color = 'white'
            }
        })
    end
end

HideTextUI = function()
    if Config.Main.TextUI.Type == "esx" then
        exports['esx_textui']:HideUI()
    elseif Config.Main.TextUI.Type == "qb" then
        exports['qb-core']:HideText()
    elseif Config.Main.TextUI.Type == "ox" then
        lib.hideTextUI()
    end
end

QuickNotify = function()
    ESX.TriggerServerCallback("benzo:policenotify:quicknotify", function(cb)
        print("triggered")
    end)
end

Menu = function()
    if Config.Main.Menu.Type == "ox_context" then
        lib.registerContext({
            id = 'benzo:policenotify:menu',
            title = 'Benzo Police Notify',
            options = {
                {
                    title = "Quick Notify",
                    description =
                    "Send a quick notify to the police department that someone is at the front desk \n no text needed",
                    icon = 'fa-solid fa-bell',
                    onSelect = function()
                        QuickNotify()
                    end
                },
                {
                    title = 'Police Department',
                    description = 'Send an notify to all police officers \n / the whole department thats working',
                    icon = 'fa-solid fa-user',
                    onSelect = function()
                        print("Option 1 selected")
                    end
                },
                {
                    title = 'Specific Police Officer',
                    description = 'Send an notify to a specific police officer',
                    icon = 'fa-solid fa-users',
                    onSelect = function()
                        print("Option 2 selected")
                    end
                },
                {
                    title = "Cancel",
                    description = "Close the menu and cancel the notification",
                    icon = 'fa-solid fa-xmark',
                    onSelect = function()
                        lib.hideContext()
                    end
                }
            }
        })
        lib.showContext('benzo:policenotify:menu')
    elseif Config.Main.Menu.Type == "ox_menu" then
        local menu = {
            {
                label       = "Quick Notify",
                description =
                "Send a quick notify to the police department that someone is at the front desk \n no text needed",
                icon        = 'fa-solid fa-bell',
            },
            {
                label       = 'Police Department',
                description = 'Send an notify to all police officers \n / the whole department thats working',
                icon        = 'fa-solid fa-user',
            },
            {
                label       = 'Specific Police Officer',
                description = 'Send an notify to a specific police officer',
                icon        = 'fa-solid fa-users',
            },
            {
                label       = "Cancel",
                description = "Close the menu and cancel the notification",
                icon        = 'fa-solid fa-xmark',
            }
        }
        lib.registerMenu({
            id = 'benzo:policenotify:menu',
            title = 'Benzo Police Notify',
            position = 'top-right',
            options = menu,
        }, function(selected, scrollIndex, args)
            if selected == 1 then
                QuickNotify()
            elseif selected == 2 then
                print("Option 2 selected")
            elseif selected == 3 then
                print("Option 3 selected")
            elseif selected == 4 then
                lib.hideMenu()
            end
        end)
        lib.showMenu('benzo:policenotify:menu')
    elseif Config.Main.Menu.Type == "esx_menu_default" then
        local elements = {
            { label = "Quick Notify",            value = 'quicknotify',      description = "Send a quick notify to the police department that someone is at the front desk \n no text needed" },
            { label = 'Police Department',       value = 'policedepartment', description = 'Send an notify to all police officers \n / the whole department thats working' },
            { label = 'Specific Police Officer', value = 'specificofficer',  description = 'Send an notify to a specific police officer' },
            { label = "Cancel",                  value = 'cancel',           description = "Close the menu and cancel the notification" }
        }
        ESX.UI.Menu.CloseAll()
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'benzo:policenotify:menu', {
            title    = 'Benzo Police Notify',
            align    = 'top-right',
            elements = elements
        }, function(data, menu)
            if data.current.value == 'quicknotify' then
                QuickNotify()
                menu.close()
            elseif data.current.value == 'policedepartment' then
                print("Option 2 selected")
                menu.close()
            elseif data.current.value == 'specificofficer' then
                print("Option 3 selected")
                menu.close()
            elseif data.current.value == 'cancel' then
                menu.close()
            end
        end, function(data, menu)
            menu.close()
        end)
    elseif Config.Main.Menu.Type == "esx_context" then
        local formMenu = {
            {
                title = 'Benzo Police Notify',
                description = 'Select an option below to send a notification',
                icon = 'fa-solid fa-circle-user',
                value = 'header',
                unselectable = true
            },
            {
                title = "Quick Notify",
                description =
                "Send a quick notify to the police department that someone is at the front desk \n no text needed",
                icon = 'fa-solid fa-bell',
                value = 'quicknotify'
            },
            {
                title = 'Police Department',
                description = 'Send a notify to all police officers / the whole department that\'s working',
                icon = 'fa-solid fa-user',
                value = 'policedepartment'
            },
            {
                title = 'Specific Police Officer',
                description = 'Send a notify to a specific police officer',
                icon = 'fa-solid fa-users',
                value = 'specificofficer'
            },
            {
                title = "Cancel",
                description = "Close the menu and cancel the notification",
                icon = 'fa-solid fa-xmark',
                value = 'cancel'
            }
        }
        ESX.OpenContext('right', formMenu, function(menu, element)

            if element.value == 'quicknotify' then
                QuickNotify()
            elseif element.value == 'policedepartment' then
                print("Option 2 selected")
            elseif element.value == 'specificofficer' then
                print("Option 3 selected")
            end

    

            ESX.CloseContext()
        end, function()
        end)
    end
end


CreateThread(function()
    if Config.Main.Target.Use then
        Target()
    else
        if not Config.Main.TextUI.Use then return print("TextUI is set to false in the config") end
        local TextUI
        while true do
            local sleep = 500
            local coords = GetEntityCoords(PlayerPedId())
            local inDist = #(coords - Config.Main.TextUI.Options.Position) < 2.0
            if inDist then
                sleep = 5
                if IsControlJustPressed(0, 38) then
                    Menu()
                end
            end
            if inDist and not TextUI then
                ShowTextUI()
                TextUI = true
            elseif not inDist and TextUI then
                TextUI = false
                HideTextUI()
                sleep = 500
            end
            Wait(sleep)
        end
    end
end)
