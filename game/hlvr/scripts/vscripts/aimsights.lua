------------------------------
--##########Config##########--
------------------------------
local sights_zoom = 30
local sights_vm_x = -5.15 -- viewmodel offset for aiming down sights
local sights_vm_y = 3 -- viewmodel offset for aiming down sights
local sights_vm_z = 2 -- viewmodel offset for aiming down sights
local sights_move_speed = 20 -- speed diff for aiming sights
local sights_sensitivity = 10 -- sensitivity for aiming sights
local normal_sensitivity = 50 -- sensitivity default


function aimsights()
    local player = Entities:GetLocalPlayer()
    OldFOV = cvar_getf("fov_desired");


    -- Toggle Commands
    SendToConsole("bind mouse2 \"unaimsights\"")

    -- Set Fov to zoom
    cvar_setf("fov_desired", cvar_getf("fov_desired") - sights_zoom);

    -- Set viewmodel offsets
    cvar_setf("viewmodel_offset_x", sights_vm_x);
    cvar_setf("viewmodel_offset_y", sights_vm_y);
    cvar_setf("viewmodel_offset_z", sights_vm_z);

    -- Set Move Speeds
    cvar_setf("cl_forwardspeed", cvar_getf("cl_forwardspeed") - sights_move_speed)
    cvar_setf("cl_backspeed", cvar_getf("cl_backspeed") - sights_move_speed)
    cvar_setf("cl_sidespeed", cvar_getf("cl_sidespeed") - sights_move_speed)

    -- Reset Sensitivity (For some reason, doesnt notice InputService CVars and throws mysterious errors)
    -- Convars:setFloat("mouse_pitchyaw_sensitivity", Convars:GetFloat("mouse_pitchyaw_sensitivity") - sights_sensitivity)
    SendToConsole("mouse_pitchyaw_sensitivity " .. sights_sensitivity)
end

function unaimsights()

    -- Toggle Commands
    SendToConsole("bind mouse2 \"aimsights\"")

    -- Reset FOV
    cvar_setf("fov_desired", cvar_getf("fov_desired") + sights_zoom);
    
    -- Reset Viewmodel Offsets
    cvar_setf("viewmodel_offset_x", 0);
    cvar_setf("viewmodel_offset_y", 0);
    cvar_setf("viewmodel_offset_z", 0);

    -- Reset Move Speeds
    cvar_setf("cl_forwardspeed", cvar_getf("cl_forwardspeed") + sights_move_speed)
    cvar_setf("cl_backspeed", cvar_getf("cl_backspeed") + sights_move_speed)
    cvar_setf("cl_sidespeed", cvar_getf("cl_sidespeed") + sights_move_speed)

    -- Reset Sensitivity
    SendToConsole("mouse_pitchyaw_sensitivity " .. normal_sensitivity)

end

Convars:RegisterCommand("aimsights", aimsights, "Toggle aiming down sights", 0)
Convars:RegisterCommand("unaimsights", unaimsights, "Toggle returning to normal view", 0)

player_spawn_ev = ListenToGameEvent('player_activate', function(info)
    SendToConsole("bind mouse2 \"aimsights\"")
end)