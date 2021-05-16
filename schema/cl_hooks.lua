
-- Here is where all of your clientside hooks should go.
local TraceData
function Schema:PostDrawHUD()
    TraceData = LocalPlayer():GetEyeTraceNoCursor()
    local x,y = 0,ScrH()/2
    surface.SetFont("ixMediumFont")
    surface.SetDrawColor(color_white)
    local Apply = draw.GetFontHeight("ixMediumFont")
    surface.SetTextPos(x,y) 
    surface.DrawText(tostring(TraceData.Entity))
    if(TraceData.Entity) then
        surface.SetTextPos(x,y-Apply) 
        surface.DrawText("Class:"..TraceData.Entity:GetClass())
    end

end
