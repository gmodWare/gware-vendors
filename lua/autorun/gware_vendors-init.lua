gWare = gWare or {}
gWare.Vendors = gWare.Vendors or {}

include("gware-vendors/sh_vendor-class.lua")

if SERVER then
    include("gware-vendors/sv_vendor.lua")

    AddCSLuaFile("gware-vendors/sh_vendor-class.lua")
    AddCSLuaFile("gware-vendors/vgui/cl_vendor.lua")
end

if CLIENT then
    include("gware-vendors/vgui/cl_vendor.lua")
end