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
    local activeItem

    self.itemsBackground = self:Add("VoidUI.BackgroundPanel")
    self.itemsBackground:Dock(LEFT)
    self.itemsBackground:SDockMargin(15, 15, 15, 15)
    self.itemsBackground:SSetSize(460, 0)
    self.itemsBackground:SetTitle("Angebot:")

    local scrollbar = self.itemsBackground:Add("VoidUI.ScrollPanel")
    scrollbar:Dock(FILL)
    scrollbar:DockMargin(0, 40, 0, 0)

    for itemIndex, itemData in ipairs(self.vendor:GetItems()) do
        local item = scrollbar:Add("gWare.Vendors.ItemPanel")
        item:Dock(TOP)
        item:SDockMargin(0, 5, 0, 0)
        item:SetItem(itemData)

        item.DoClick = function()
            self:ItemDetail(itemData, itemIndex)
            if IsValid(activeItem) then
                activeItem:SetActive(false)
            end

            item:SetActive(true)
            activeItem = item
        end
    end
end

function PANEL:ItemDetail(item, itemIndex)
    if IsValid(self.detailBackground) then
        self.detailBackground:Remove()
    end

    if not item then return end

    self.detailBackground = self:Add("VoidUI.BackgroundPanel")
    self.detailBackground:Dock(RIGHT)
    self.detailBackground:SDockMargin(15, 15, 15, 15)
    self.detailBackground:SSetSize(350, 0)
    self.detailBackground.Paint = function(s, w, h)
        draw.RoundedBox(12, 0, 0, w, h, VoidUI.Colors.InputDark)

        local panelX, panelY = self.detailBackground:GetPos()
        panelX = panelX + self:GetX()
        panelY = panelY + self:GetY()

        VoidUI.SimpleLinearGradient(panelX + 10, panelY + 17, 330, 40, item.color, VoidUI.Colors.Primary, false)

        // header
        draw.SimpleText(item.name, "VoidUI.R22", 175, 35, VoidUI.Colors.White, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        draw.RoundedBox(0, 10, 57, 330, 1, VoidUI.Colors.Black)

        // description
        draw.DrawText(VoidUI.TextWrap(item.description, "VoidUI.R20", w - 50), "VoidUI.R20", 25, 280, VoidUI.Colors.White, TEXT_ALIGN_LEFT)
    end

    self.model = self.detailBackground:Add("ModelImage")
    self.model:SSetSize(150, 150)
    self.model:SetPos(100, 100)
    self.model:SetModel(item.model)
    self.model:SetMouseInputEnabled(false)

    local canAfford = LocalPlayer():canAfford(item.price)

    self.buyButton = self.detailBackground:Add("VoidUI.Button")
    self.buyButton:SSetSize(225, 50)
    self.buyButton:SetPos(65, 350)
    self.buyButton:SetText("Kaufen " .. DarkRP.formatMoney(item.price))
    self.buyButton:SetColor(canAfford and VoidUI.Colors.Green or VoidUI.Colors.Red)

    self.buyButton.DoClick = function()
        if not canAfford then
            VoidLib.Notify("gWare Vendor", "Du hast nicht genug Geld um diesen Gegenstand zu kaufen!", VoidUI.Colors.Red, 5)
            return
        end

        net.Start("gWare.Vendors.BuyItem")
            net.WriteUInt(self.vendor:GetID(), 7)
            net.WriteUInt(itemIndex, 7)
        net.SendToServer()
    end
end

vgui.Register("gWare.Vendor", PANEL, "VoidUI.Frame")
