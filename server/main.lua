if Config.Framework == "esx" then
    ESX = exports["es_extended"]:getSharedObject()
elseif Config.Framework == "qb" then
    QBcore = exports['qb-core']:GetCoreObject()
end

jobs = {} -- global table

getJobs = function()
    for _, v in pairs(Config.Main.Jobs) do
        table.insert(jobs, v)
    end

    return jobs
end

ESX.RegisterServerCallback('benzo:policenotify:quicknotify', function(source, cb)
    local jobList = getJobs()
    for i, job in ipairs(jobList) do
        local sentfrom = ESX.GetPlayerFromId(source)

        local policeOfficers = ESX.GetExtendedPlayers('job', job)

        for i, xPlayer in ipairs(policeOfficers) do
            if Config.Main.Notification.Type == "esx_notify" then
                xPlayer.showNotification("[Police Department Notify]" ..
                    sentfrom.getName() .. " is in the lobby and needs assistance")
            else
                if Config.Main.Notification.Type == "ox" then
                    TriggerClientEvent('ox_lib:notify', xPlayer.source, {
                        title = "Police Department Notify",
                        description = sentfrom.getName() .. " is in the lobby and needs assistance",
                        type = "info",
                        duration = 5000,
                        position = "top"
                    })
                else
                    if Config.Main.Notification.Type == "qb_notify" then
                        TriggerClientEvent('QBCore:Notify', xPlayer.source,
                            sentfrom.getName() .. " is in the lobby and needs assistance", 'info', 5000)
                    else
                        if Config.Main.Notification.Type == "lb_tablet" then
                            exports["lb-tablet"]:AddDispatch({
                                job = job,
                                priority = "low",
                                title = "Police Department Notify",
                                description = sentfrom.getName() .. " is in the lobby and needs assistance",
                                time = 5000,
                                location = Config.Main.TextUI.Options.Position,
                            })
                        else
                            if Config.Main.Notification.Type == "npwd" then
                                exports.npwd:emitMessage({
                                    senderNumber = '911',
                                    targetNumber = '911',
                                    message = "Police Department Notify " ..
                                        sentfrom.getName() .. " is in the lobby and needs assistance",
                                    embed = {
                                        type = "location",
                                        coords = Config.Main.TextUI.Options.Position,
                                        phoneNumber = '911'
                                    }
                                })
                            else
                                if Config.Main.Notification.Type == "roadphone" then
                                    local job = job
                                    local title = "Police Department Notify"
                                    local message = sentfrom.getName() .. " is in the lobby and needs assistance"
                                    local coords = Config.Main.TextUI.Options.Position
                                    local image = nil --image

                                    exports['roadphone']:sendDispatchAnonym(job, title, message, coords, image)
                                else
                                    if Config.Main.Notification.Type == "cd_dispatch" then
                                        TriggerClientEvent('cd_dispatch:AddNotification', -1, {
                                            job_table = job,
                                            coords = Config.Main.TextUI.Options.Position,
                                            title = '10-15 - Robbery',
                                            message = "Police Department Notify " ..
                                                sentfrom.getName() .. " is in the lobby and needs assistance",
                                            unique_id = tostring(math.random(0000000, 9999999)),
                                            sound = 1,
                                        })
                                    else
                                        if Config.Main.Notification.Type == "custom" then
                                            -- Add your custom notify event here
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)
