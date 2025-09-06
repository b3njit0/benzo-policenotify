Config = {}

Config.Framework = "esx"


Config.Main = {
    Jobs = {
        "police", 
        "sheriff",
    },
    Target = {
        Use = false,
        Type = "ox_target", --- ox_target, qb_target, qtarget
        Options = {
            Position = vec3(441.03, -981.07, 30.67),
            Debug = true,
        },
    },
    TextUI = {
        Use = true,  --- Target needs to be set to false
        Type = "esx", --esx, qb, ox,
        Options = {
            Position = vec3(441.03, -981.07, 30.67),
            Text = "Press [E] to open notify menu",
            Type = "success",     -- Only ESX,
            Pos = "right-center", -- QB - left, right, ox - 'right-center' or 'left-center' or 'top-center' or 'bottom-center',  esx - none
        }
    },
    Notification = {
        Type = "ox", -- esx_notify, ox, qb_notify, lb-tablet, npwd, roadphone, cd_dispatch, custom
    },
    Menu = {
        Type = "ox_menu", -- ox_context, ox_menu
        Options = {
           
        },
    }
}

