net.Receive("gWare.Vendors.BuyItem", function(len, ply)
    local vendorIndex = net.ReadUInt(7)
    local itemIndex = net.ReadUInt(7)

    local vendor = GWARE_VENDORS[vendorIndex]
    local item = vendor.items[itemIndex]

    if not item then return end

    if not ply:canAfford(item.price) then
        VoidLib.Notify(ply, "gWare Vendor", "Du hast nicht genug Geld um diesen Gegenstand zu kaufen!", VoidUI.Colors.Red, 5)
        return
    end

    if vendor:GetJobWhitelist() then
        if not vendor:GetJobWhitelist()[ply:getJobTable().command] then
            VoidLib.Notify(ply, "gWare Vendor", "Du hast nicht die Berechtigung diesen Gegenstand zu kaufen!", VoidUI.Colors.Red, 5)
            return
        end

        ply:addMoney(-item.price)
        ply:Give(item.class)

        VoidLib.Notify(ply, "gWare Vendor", "Du hast erfolgreich " .. item.name .. " gekauft!", VoidUI.Colors.Green, 5)

        return
    end

    ply:addMoney(-item.price)
    ply:Give(item.class)

    VoidLib.Notify(ply, "gWare Vendor", "Du hast erfolgreich " .. item.name .. " gekauft!", VoidUI.Colors.Green, 5)
end)

hook.Add("PlayerSay", "gWare.Vendors.InitVendor", function(ply, text)
    local setVendor = text:StartWith("/setvendor" or "!setvendor")
    local removeVendor = text:StartWith("/removevendor" or "!removevendor")

    if setVendor then
        if not ply:IsSuperAdmin() then return end // TODO : add cami support

        local spacePos = text:find(" ")

        if not spacePos then
            VoidLib.Notify(ply, "gWare Vendor", "Du musst einen Vendor Namen angeben!", VoidUI.Colors.Red, 5)
            return
        end

        local vendorName = text:sub(spacePos + 1, #text)
        local vendor = gWare.Vendors.GetVendor(vendorName)

        if not vendor then
            VoidLib.Notify(ply, "gWare Vendor", "Dieser Vendor existiert nicht!", VoidUI.Colors.Red, 5)
            return
        end

        local ent = ply:GetEyeTrace().Entity

        if ent:GetClass() != "gware_vendors_base" then
            VoidLib.Notify(ply, "gWare Vendor", "Du musst auf einen Vendor angucken!", VoidUI.Colors.Red, 5)
            return
        end

        if ent:GetVendorID() > 0 then
            VoidLib.Notify(ply, "gWare Vendor", "Dieser Vendor ist bereits initialisiert!", VoidUI.Colors.Red, 5)
            return
        end

        local cachePos = ent:GetPos()
        local cacheAngle = ent:GetAngles()

        ent:Remove()

        // remove the ent and create a new, to set the parent to world and remove the ent from the undo list
        local newEnt = ents.Create("gware_vendors_base")
        newEnt:SetPos(cachePos)
        newEnt:SetAngles(Angle(cacheAngle))
        newEnt:SetVendorID(vendor:GetID())
        newEnt:Spawn()

        local json = file.Read("vendors.json", "DATA")
        local data = util.JSONToTable(json or "{}")

        data[game.GetMap()] = data[game.GetMap()] or {}

        table.insert(data[game.GetMap()], {
            id = vendor:GetID(),
            pos = newEnt:GetPos(),
            angles = newEnt:GetAngles(),
        })

        file.Write("vendors.json", util.TableToJSON(data, true))

        VoidLib.Notify(ply, "gWare Vendor", "Du hast erfolgreich den Vendor initialisiert!", VoidUI.Colors.Green, 5)
    end

    if removeVendor then
        if not ply:IsSuperAdmin() then return end // TODO : add cami support

        local ent = ply:GetEyeTrace().Entity

        if ent:GetClass() != "gware_vendors_base" then
            VoidLib.Notify(ply, "gWare Vendor", "Du musst auf einen Vendor angucken!", VoidUI.Colors.Red, 5)
            return
        end

        local json = file.Read("vendors.json", "DATA")

        if not json then return end

        local vendorTbl = util.JSONToTable(json)
        for index, vendorData in ipairs(vendorTbl[game.GetMap()]) do
            local posRoundJson = Vector(math.Round(vendorData.pos.x), math.Round(vendorData.pos.y), math.Round(vendorData.pos.z))
            local posRoundSelf = Vector(math.Round(ent:GetPos().x), math.Round(ent:GetPos().y), math.Round(ent:GetPos().z))

            if posRoundJson != posRoundSelf then continue end

            table.remove(vendorTbl[game.GetMap()], index)
            break
        end

        file.Write("vendors.json", util.TableToJSON(vendorTbl, true))

        ent:Remove()
    end
end)

hook.Add("InitPostEntity", "gWare.Vendors.Init", function()
    local json = file.Read("vendors.json", "DATA")
    local data = util.JSONToTable(json or "{}")

    if not data[game.GetMap()] then return end

    for _, vendor in ipairs(data[game.GetMap()]) do
        local ent = ents.Create("gware_vendors_base")
        ent:SetPos(vendor.pos)
        ent:SetAngles(Angle(vendor.angles))
        ent:SetVendorID(vendor.id)
        ent:Spawn()

        ent:SetModel(GWARE_VENDORS[vendor.id]:GetModel())
    end
end)
