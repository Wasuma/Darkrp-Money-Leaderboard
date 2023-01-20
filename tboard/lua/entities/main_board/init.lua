AddCSLuaFile("imgui.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("sh_tboardconfig.lua")

local imgui = include("imgui.lua")
include("shared.lua")
require("mysqloo")

util.AddNetworkString("PosttoBoard")


if TBoardConfig.SQL == "SQLlite" then
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
    elseif TBoardConfig.SQL == "MySQL" then
        local db = mysqloo.connect(TBoardConfig.Host, TBoardConfig.User, TBoardConfig.Password, TBoardConfig.Database, 3306)
        db:connect()
        function db:onConnectionFailed()
            print("TBoard failed to connect to SQL!")
        end
        function db:onConnected()
            print("TBoard connected to SQL!")
            timer.Create("PosttoBoard", 5, 0, function()
                local query = db:query("SELECT * FROM darkrp_player ORDER BY wallet DESC LIMIT 20")
                function query:onSuccess(data)
                    local Leaderboard = data
                    local Index = 2
                    for i = 2, 20, 2 do
                        table.remove(Leaderboard, Index)
                        Index = Index + 1
                    end
                    net.Start("PosttoBoard")
                    net.WriteTable(Leaderboard)
                    net.Broadcast()
                end
                query:start()
            end)
        end
    end



function ENT:Initialize()
    self:SetModel("models/hunter/plates/plate4x4.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    self:SetMaterial("Models/effects/vol_light001")
 
    local phys = self:GetPhysicsObject()
    if( phys:IsValid() ) then
        phys:Wake()
    end
 end
