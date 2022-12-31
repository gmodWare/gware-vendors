include("shared.lua")

function ENT:Draw()
    local name = "Base Vendor"

    if self:GetVendorID() > 0 then
        name = GWARE_VENDORS[self:GetVendorID()].name
    end

    self:DrawModel()

    local mins, maxs = self:WorldSpaceAABB()
    local height = maxs.z - mins.z

    local offset = Vector( 0, 0, height + 15)
    local ang = LocalPlayer():EyeAngles()
    local pos = self:GetPos() + offset + ang:Up()

    local myPos = LocalPlayer():GetPos()

    if myPos:Distance(pos) > 600 then return end

    ang:RotateAroundAxis(ang:Forward(), 90)
    ang:RotateAroundAxis(ang:Right(), 90)

    surface.SetFont("KXX.ItemShop.R28")
    local width, height = surface.GetTextSize(name)
    local br = 8 -- space outline for text
    local boxWidth = width + 20

    cam.Start3D2D( pos, ang, 0.25 )
        surface.SetDrawColor(Color(0, 0, 0, 160))
        surface.DrawOutlinedRect(-boxWidth / 2, -br, boxWidth, height + (2 * br))

        surface.DrawRect(-boxWidth / 2 + 2, -br + 2, boxWidth - 4, height + (2 * br) - 4)
        surface.SetDrawColor(255, 255, 255, 200)
        draw.DrawText(name, "VoidUI.R28", -boxWidth / 2 + 10, -1, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
    cam.End3D2D()
end

net.Receive("gWare.Vendor.SendVendor", function (len)
    local vendorID = net.ReadUInt(7)

    local vendorObj = GWARE_VENDORS[vendorID]

    local vendor = vgui.Create("gWare.Vendor")
    vendor:SetVendor(vendorObj)
    vendor:GetItems()
    vendor:ItemDetail()
end)