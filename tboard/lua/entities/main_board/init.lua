AddCSLuaFile("imgui.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")

local imgui = include("imgui.lua")
include("shared.lua")

util.AddNetworkString("PosttoBoard")


timer.Create("PosttoBoard", 5, 0, function()
    local Leaderboard = MySQLite.query ([[SELECT * FROM darkrp_player ORDER BY wallet DESC LIMIT 20]])
    local Index = 2
    for i = 2, 20, 2 do
        table.remove(Leaderboard, Index)
        Index = Index + 1
    end
    net.Start("PosttoBoard")
    net.WriteTable(Leaderboard)
    net.Broadcast()
end)


function ENT:Initialize()
    self:SetModel("models/hunter/plates/plate4x4.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    self:SetMaterial("Models/effects/vol_light001")
    self:SetAngles(Angle(90, 90, 0))
 
    local phys = self:GetPhysicsObject()
    if( phys:IsValid() ) then
        phys:Wake()
    end
 end
