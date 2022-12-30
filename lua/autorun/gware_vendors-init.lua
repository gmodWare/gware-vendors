gWare = gWare or {}
gWare.Vendors = gWare.Vendors or {}

function gWare.Vendors.LoadAll()
    include("gware-vendors/sh_vendor-class.lua")
    include("gware-vendors/vendors_config.lua")

    if SERVER then
        util.AddNetworkString("gWare.Vendors.BuyItem")

        include("gware-vendors/sv_vendors.lua")

        AddCSLuaFile("gware-vendors/sh_vendor-class.lua")
        AddCSLuaFile("gware-vendors/vgui/cl_vendor.lua")
        AddCSLuaFile("gware-vendors/vgui/cl_item-panel.lua")
        AddCSLuaFile("gware-vendors/vendors_config.lua")
    end

    if CLIENT then
        include("gware-vendors/vgui/cl_vendor.lua")
        include("gware-vendors/vgui/cl_item-panel.lua")
    end
end

hook.Add("VoidLib.Loaded", "gWare.Init.WaitForVoidLib", function ()
    gWare.Vendors.LoadAll()
end)