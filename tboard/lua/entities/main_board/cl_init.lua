AddCSLuaFile("imgui.lua")
local imgui = include("imgui.lua")
include("shared.lua")

surface.CreateFont("Billboard Font", {
    font = "Impact",
    size = 150
})

surface.CreateFont("Billboard Title Font", {
   font = "Impact",
    size = 250
})

local MoneyLeaderboard = {}

local List = {"#1", "#2", "#3", "#4", "#5", "#6", "#7", "#8", "#9", "#10"}


net.Receive("PosttoBoard", function()
    MoneyLeaderboard = net.ReadTable()
end)



function ENT:DrawTranslucent()
    if imgui.Entity3D2D(self, Vector(-120, -150, 0), Angle(0, 90, 0), 0.1) then
      -- Border Box
      surface.SetDrawColor(TBoardConfig.BorderBoxColor)
      surface.DrawOutlinedRect(480, 150, 2100, 2100, TBoardConfig.BorderBoxThickness)
      -- Main BG
      surface.SetDrawColor(TBoardConfig.MainBGColor)
      surface.DrawRect(505, 175, 2050, 2050)
      -- Top Earner Header
      draw.SimpleText(TBoardConfig.TitleText, "Billboard Title Font", 1500, 300, TBoardConfig.TitleColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
      -- Player and Money Print
      for k, v in pairs(MoneyLeaderboard) do
        draw.DrawText( ( string.sub( v.rpname , 0 , 10 ) ), "Billboard Font", 1200, 500 + k * 150, TBoardConfig.RPColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        draw.DrawText("$" .. string.Comma(v.wallet), "Billboard Font", 2000, 500 + k * 150, TBoardConfig.MoneyColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    -- Number Placement List
    for k,v in pairs( List ) do
    draw.DrawText(v, "Billboard Font", 600, 500 + k * 150, TBoardConfig.PlacementText, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    if TBoardConfig.Underline == "true" then
      surface.SetDrawColor(TBoardConfig.UnderlineColor)
      surface.DrawRect(505, TBoardConfig.UnderlineY, 2050, TBoardConfig.UnderlineThickness)
      imgui.End3D2D()
    else
    imgui.End3D2D()
    end
  end
end