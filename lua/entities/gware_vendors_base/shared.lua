ENT.Type = "ai"
ENT.Base = "base_ai"

ENT.PrintName = "Base Vendor"
ENT.AutomaticFrameAdvance = true
ENT.Spawnable = true
ENT.Category = "[gWare] Development"

function ENT:SetupDataTables()
    self:NetworkVar("Int", 0, "VendorID")
end