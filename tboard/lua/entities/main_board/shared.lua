ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Tboard"

ENT.Category = "Testing Terry"
ENT.Spawnable = true

if SERVER then
    AddCSLuaFile("sh_tboardconfig.lua")
    AddCSLuaFile("imgui.lua")
end


if CLIENT then
    include("sh_tboardconfig.lua") 
    include("imgui.lua")
end