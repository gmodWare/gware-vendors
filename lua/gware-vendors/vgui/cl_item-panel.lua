local PANEL = {}
local sc = VoidUI.Scale

function PANEL:SetItem(item)
    self.item = item
end

function PANEL:SetActive(bool)
    self.active = bool
end

function PANEL:Init()
    self:SSetSize(420, 60)
    self:SetText("")

    self.gradientEnd = VoidUI.Colors.Primary
end

function PANEL:Paint(w, h)
    if self:IsHovered() or self.active == true then
        draw.RoundedBox(4, 0, 0, w, h, VoidUI.Colors.Hover)
    else
        draw.RoundedBox(4, 0, 0, w, h, VoidUI.Colors.InputLight)
    end

    local x, y = self:LocalToScreen(0, 0)

    local baseX = sc(340)
    local verts = {
        {x = baseX + sc(15), y = 0},
        {x = baseX + sc(30), y = 0},
        {x = baseX + sc(15) - sc(30), y = h},
        {x = baseX - sc(30), y = h}
    }
    baseX = baseX + sc(25)
    local verts2 = {
        {x = baseX + sc(15), y = 0},
        {x = baseX + sc(40), y = 0},
        {x = baseX + sc(25) - sc(30), y = h},
        {x = baseX - sc(30), y = h}
    }

    VoidUI.StencilMaskStart()
        surface.SetDrawColor(VoidUI.Colors.White)
        draw.NoTexture()
        surface.DrawPoly(verts)
        surface.DrawPoly(verts2)
    VoidUI.StencilMaskApply()
        VoidUI.SimpleLinearGradient(x + sc(100), y, w-sc(100), h, self.item.color, self.gradientEnd)
    VoidUI.StencilMaskEnd()

    draw.SimpleText(self.item.name, "VoidUI.R22", 10, 10, VoidUI.Colors.White, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
    draw.SimpleText("» " .. DarkRP.formatMoney(self.item.price), "VoidUI.R18", 10, 35, VoidUI.Colors.GrayText, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
end

vgui.Register("gWare.Vendors.ItemPanel", PANEL, "DButton")