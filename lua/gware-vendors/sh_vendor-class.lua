GWARE_VENDORS = {}

local VENDOR_CLASS = {}
VENDOR_CLASS.__index = VENDOR_CLASS

function VENDOR_CLASS:Create(name)
    local newObject = setmetatable({}, VENDOR_CLASS)
    newObject.name = name
    newObject.items = {}
    newObject.id = #GWARE_VENDORS + 1

    table.insert(GWARE_VENDORS, newObject)

    return newObject
end

function VENDOR_CLASS:GetName()
    return self.name
end

function VENDOR_CLASS:GetID()
    return self.id
end

function VENDOR_CLASS:GetItems()
    return self.items
end

/* 
    dataTbl:
    - name: string
    - description: string
    - price: int
    - model: string
    - class: string
*/
function VENDOR_CLASS:AddItem(dataTbl)
    table.insert(self.items, dataTbl)
end

// public constructor
function gWare.Vendors.CreateVendor(name)
    return VENDOR_CLASS:Create(name)
end
