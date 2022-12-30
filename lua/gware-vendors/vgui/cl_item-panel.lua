local PANEL = {}

function PANEL:SetItem(item)
    self.item = item
end

function PANEL:Init()
    self:SSetSize(420, 60)
    self:SetText("")
end

function PANEL:Paint(w, h)
    if self:IsHovered() || self.activePanel == self then
        draw.RoundedBox(4, 0, 0, w, h, VoidUI.Colors.Hover)
    else
        draw.RoundedBox(4, 0, 0, w, h, VoidUI.Colors.InputLight)
    end

    draw.SimpleText(self.item.name, "VoidUI.R22", 10, 10, VoidUI.Colors.White, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
    draw.SimpleText(self.item.description, "VoidUI.R18", 10, 35, VoidUI.Colors.GrayText, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

    draw.SimpleText(DarkRP.formatMoney(self.item.price), "VoidUI.R22", 340, 20, VoidUI.Colors.White, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT)
end

vgui.Register("gWare.Vendors.ItemPanel", PANEL, "DButton")