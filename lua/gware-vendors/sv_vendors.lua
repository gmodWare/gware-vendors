net.Receive("gWare.Vendors.BuyItem", function(len, ply)
    local vendorIndex = net.ReadUInt(7)
    local itemIndex = net.ReadUInt(7)

    local item = GWARE_VENDORS[vendorIndex].items[itemIndex]

    if not item then return end

    if not ply:canAfford(item.price) then
        VoidLib.Notify(ply, "Händler", "Du hast nicht genug Geld um diesen Gegenstand zu kaufen!", VoidUI.Colors.Red, 5)
        return
    end

    ply:addMoney(-item.price)
    ply:Give(item.class)

    VoidLib.Notify(ply, "Händler", "Du hast erfolgreich " .. item.name .. " gekauft!", VoidUI.Colors.Green, 5)
end)