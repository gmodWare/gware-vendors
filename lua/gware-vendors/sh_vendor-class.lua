local VENDOR_CLASS = {}
VENDOR_CLASS.__index = VENDOR_CLASS

function VENDOR_CLASS:Create(name)
    local newObject = setmetatable({}, VENDOR_CLASS)
    newObject.name = name
    newObject.items = {}

    return newObject
end

function VENDOR_CLASS:GetItems()
    return self.items
end

/* 
    dataTbl:
    - item_name: string
    - item_price: int
    - item_model: string
    - item_class: string
*/
function VENDOR_CLASS:AddItem(dataTbl)
    table.Add(dataTbl, self.items)
end

// public constructor
function gWare.Vendors.CreateVendor(name)
    return VENDOR_CLASS:Create(name)
end

