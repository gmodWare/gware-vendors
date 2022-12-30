gWare = gWare or {}
gWare.Vendors = gWare.Vendors or {}

include("gware-vendors/sh_vendor-class.lua")


if SERVER then
    include("gware-vendors/sv_vendor.lua")
end

if CLIENT then
    
end