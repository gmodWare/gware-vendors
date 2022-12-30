local PANEL = {}

function PANEL:SetVendor(vendor)
    self.vendor = vendor
    self:SetTitle(self.vendor:GetName())
end

function PANEL:Init()
    self:SSetSize(850, 500)
    self:Center()
    self:MakePopup()
end

function PANEL:GetItems()
    local background = self:Add("VoidUI.BackgroundPanel")
    background:Dock(LEFT)
    background:SDockMargin(15, 15, 15, 15)
    background:SSetSize(450, 0)
    background:SetTitle("Angebot:")

    local scrollbar = background:Add("Voir.ScrollPanel")
    scrollbar:Dock(FILL)
    scrollBar:DockMargin(0, 40, 0, 0)
end

function PANEL:ItemDetail(item)
    local background = self:Add("VoidUI.BackgroundPanel")
    background:Dock(RIGHT)
    background:SDockMargin(15, 15, 15, 15)
    background:SSetSize(350, 0)
end

vgui.Register("gWare.Vendor", PANEL, "VoidUI.Frame")

concommand.Add("gv", function()
    local testVendor = gWare.Vendors.CreateVendor("Klingenverkäufer")

    local frame = vgui.Create("gWare.Vendor")
    frame:SetVendor(testVendor)
    frame:GetItems()
    frame:ItemDetail()
end)