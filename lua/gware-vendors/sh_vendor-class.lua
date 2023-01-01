GWARE_VENDORS = {}

local VENDOR_CLASS = {}
VENDOR_CLASS.__index = VENDOR_CLASS

function VENDOR_CLASS:Create(name, model)
    local newObject = setmetatable({}, VENDOR_CLASS)
    newObject.name = name
    newObject.id = #GWARE_VENDORS + 1
    newObject.model = model
    newObject.items = {}
    newObject.jobwhitelist = nil

    table.insert(GWARE_VENDORS, newObject)

    return newObject
end

function VENDOR_CLASS:GetName()
    return self.name
end

function VENDOR_CLASS:GetID()
    return self.id
end

function VENDOR_CLASS:GetModel()
    return self.model
end

function VENDOR_CLASS:GetItems()
    return self.items
end

function VENDOR_CLASS:GetJobWhitelist()
    return self.jobwhitelist
end

/* 
    dataTbl:
    - name: string
    - description: string
    - price: int
    - color: Color
    - model: string
    - class: string
*/
function VENDOR_CLASS:AddItem(dataTbl)
    table.insert(self.items, dataTbl)
end

/* 
    dataTbl:
    - ["job_command"] = true
*/
function VENDOR_CLASS:SetJobWhitelist(dataTbl)
    self.jobwhitelist = dataTbl
end

// public constructor
function gWare.Vendors.CreateVendor(name, model)
    return VENDOR_CLASS:Create(name, model)
end

function gWare.Vendors.GetVendor(str)
    for _, vendor in ipairs(GWARE_VENDORS) do
        if vendor:GetName() != str then continue end

        return vendor
    end

    return false
end
