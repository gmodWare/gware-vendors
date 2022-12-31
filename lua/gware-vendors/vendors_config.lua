table.Empty(GWARE_VENDORS)
////////////////////////
///// Add Vendors /////
//////////////////////

// Test Vendors
local testVendor = gWare.Vendors.CreateVendor("Test Vendor", "models/humans/group01/male_02.mdl")
testVendor:AddItem({
    name = "Normale Klinge",
    description = "Normale Klinge welche nicht zu scharf ist und auch nicht zu stumpf ist sondern einfach nur normal ist",
    price = 50,
    color = VoidUI.Colors.Green,
    model = "models/props_trainstation/trashcan_indoor001b.mdl",
    class = "cw_ak74",
})

testVendor:AddItem({
    name = "Scharfe Klinge",
    description = "Eine scharfe Klinge",
    price = 100,
    color = VoidUI.Colors.Red,
    model = "models/weapons/w_rif_ak47.mdl",
    class = "cw_l115",
})

testVendor:AddItem({
    name = "Epische Klinge",
    description = "Eine Klinge epischer Schärfe",
    price = 200,
    color = Color(124,22,207),
    model = "models/props_junk/cardboard_box004a.mdl",
    class = "weapon_357",
})

local testVendor1 = gWare.Vendors.CreateVendor("Legendärer Vendor", "models/humans/group01/male_02.mdl")
testVendor1:AddItem({
    name = "Super Legendäre Klinge",
    description = "Eine Klinge epischer Schärfe",
    price = 200,
    color = Color(230,196,46),
    model = "models/props_junk/cardboard_box004a.mdl",
    class = "weapon_357",
})