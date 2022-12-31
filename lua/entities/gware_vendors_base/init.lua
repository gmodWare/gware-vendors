AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

util.AddNetworkString("gWare.Vendor.SendVendor")

print(KXX.ItemShop.EntityModel)

function ENT:Initialize()
    local model = "models/humans/group01/male_02.mdl"

    self:SetModel(model)
    self:SetHullType( HULL_HUMAN )
    self:SetHullSizeNormal()
    self:SetNPCState( NPC_STATE_SCRIPT )
    self:SetSolid( SOLID_BBOX )
    bit.bor( CAP_ANIMATEDFACE , CAP_TURN_HEAD)
    self:SetUseType( SIMPLE_USE )
    self:DropToFloor()

    self:SetMaxYawSpeed(5000)

    local phys = self:GetPhysicsObject()
    if (phys:IsValid()) then
        phys:Wake()
    end

    self:AddFlags(FL_NOTARGET)
end

local cd = false

function ENT:Use(ply, activator)
    if not IsFirstTimePredicted() then return end

    if self:GetVendorID() <= 0 then
        VoidLib.Notify(ply, "gWare Vendor", "Du hast diesen Händler noch nicht initialisiert! /setvendor <vendor name>", VoidUI.Colors.Red, 5)
        return
    end

    if cd then return end
    cd = true

    net.Start("gWare.Vendor.SendVendor")
        net.WriteUInt(self:GetVendorID(), 7)
    net.Send(ply)

    timer.Simple(0.1, function() cd = false end)
end

function ENT:OnRemove()
    local json = file.Read("vendors.json", "DATA")

    if not json then return end

    local vendorTbl = util.JSONToTable(json)
    for index, vendorData in ipairs(vendorTbl[game.GetMap()]) do
        local posRoundJson = Vector(math.Round(vendorData.pos.x), math.Round(vendorData.pos.y), math.Round(vendorData.pos.z))
        local posRoundSelf = Vector(math.Round(self:GetPos().x), math.Round(self:GetPos().y), math.Round(self:GetPos().z))

        if posRoundJson != posRoundSelf then continue end

        table.remove(vendorTbl[game.GetMap()], index)
        break
    end

    //PrintTable(vendorTbl)

    file.Write("vendors.json", util.TableToJSON(vendorTbl, true))
end