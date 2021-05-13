net.Receive("connectWires",function()
    OpenWireConnectorMenu()

end)

local function DoDrop( self, panels, bDoDrop, Command, x, y )
	if ( bDoDrop ) then
		for k, v in pairs( panels ) do
            
            if(self.left and v:GetBackgroundColor()~=self:GetBackgroundColor()) then
                continue end
            if(self:GetChild(0)) then continue end
                v:SetParent(self)
                v:DockMargin(5,5,5,5)
                v:Dock(FILL)
                

		end
	end
end
local wave = Material( "models/rendertarget")
function OpenWireConnectorMenu()
    if(IsValid(ix.gui.openedWireConnector)) then
        ix.gui.openedWireConnector:Remove()
    end
	local frame = vgui.Create( "DPanel" )
    ix.gui.openedWireConnector = frame
	frame:SetSize( ScrW(), ScrH()*0.8)
	//frame:SetTitle( "Frame" )
	frame:MakePopup()
	frame:Center()
    frame:SetDrawBackground(false)
    
    function frame:OnKeyCodePressed(keyCode )
        if(keyCode==KEY_TAB) then self:Remove() ix.gui.openedWireConnector = nil end
    end
    frame.left = {}
    frame.drag = {}
    frame.right = {}
    function frame:CheckWires()
        for k,v in pairs(frame.right) do
            if(!(v:GetChild(0)) or (v:GetChild(0) and v:GetBackgroundColor()~=v:GetChild(0):GetBackgroundColor() )) then
                surface.PlaySound("ambient/energy/zap5.wav")
                return false
            end
            
        end
        surface.PlaySound("npc/scanner/scanner_electric1.wav")
        return true
    end

    function frame:PaintOver()
        for k,v in pairs(frame.left) do
            surface.SetDrawColor(255,255,255,255)
            local x1,y1 = v:LocalToScreen()
            y1=y1-v:GetTall()/2
            x1=x1+v:GetWide()/2
            local x2,y2 = frame.drag[k]:LocalToScreen()
            y2=y2-frame.drag[k]:GetTall()/2
            x2=x2+frame.drag[k]:GetWide()/2
            local CenterX = (x1+x2)/2
            local CenterY = (y1+y2)/2
            local distance = math.Distance(x1,y1,x2,y2)
            local b = x2-x1 
            local a = y2-y1

            local rotation =math.deg(math.atan2( a,b ))*-1
            //surface.SetMaterial(wave)
            draw.NoTexture()
            surface.SetDrawColor(v:GetBackgroundColor())
            surface.DrawTexturedRectRotated( CenterX, CenterY,distance, 10,rotation )
            surface.SetDrawColor(color_white)
            //surface.DrawLine( x1, y1-3, x2, y2-3 )
            
        end
    end

	local left = vgui.Create( "DPanel", frame )
	left:Dock( LEFT )
	left:SetWidth( frame:GetWide() / 5 )
    left:SetBackgroundColor(color_black)
	left:SetPaintBackground( true )
	left:DockMargin( 0, 0, 4, 0 )
    

	local right = vgui.Create( "DPanel", frame )
	right:Dock( RIGHT )
    right:SetWidth( frame:GetWide() / 5 )
    right:SetBackgroundColor(color_black)
	right:SetPaintBackground( true )
    local colors = {
        red = Color(255,0,0),
        yellow = Color(255,255,0),
        blue = Color(0,0,128),
        violet = Color(138,43,226)
    }
    colorsCopy = table.Copy(colors)
    for i = 1, 4 do
        local key,color = table.Random( colorsCopy )

        colorsCopy[color] = nil

		local but = right:Add( "DPanel" )
        frame.right[#frame.right+1] = but
		but:SetText( i )
		but:SetHeight(frame:GetTall()/10)
        but:DockMargin( 0,50, 0, 0 )
		but:Dock( TOP )
		but:Receiver("color",DoDrop) 
        but:SetBackgroundColor(key)
    end

    colorsCopy = table.Copy(colors)
    for i = 1, 4 do
        local key,color = table.Random( colorsCopy ) //returns value and key

        colorsCopy[color] = nil
    	local but = left:Add( "DPanel" )
        frame.left[color] = but
        but.left = true
		but:SetText( i )
		but:SetHeight(frame:GetTall()/10)
        but:DockMargin( 0,50, 0, 0 )
		but:Dock( TOP )
		but:Receiver("color",DoDrop) 
        but:SetBackgroundColor(key)
        but.color = color

		local but2 = but:Add( "DPanel" )
        frame.drag[color] = but2
		but2:SetText( i )
		but2:SetSize( 36, 24 )
        but2:DockMargin( 5, 5, 5, 5 )
        but2:Dock( FILL )
		but2:Droppable("color") 
        but2:SetBackgroundColor(key)
        but2.color = color
    end

    local labelLeft = left:Add("DLabel")
    labelLeft:Dock(FILL)
    labelLeft:SetFont("ixBigFont")
    labelLeft:SetText(L("connectWires"))
    labelLeft:SetWrap(true)
	//right:Receiver( "myDNDname", DoDrop )
    local switch = right:Add("DPanel")
    switch:DockMargin( 0,50,0,0 )
    switch:Dock(TOP)
    local switchRed = switch:Add("DPanel")
    switchRed:SetWidth(right:GetWide()/2)
    switchRed:SetPos(0,0)
    switchRed:SetBackgroundColor(Color(255,0,0))

    local switchGreen = switch:Add("DPanel")
    switchGreen:SetWidth(right:GetWide()/2)
    switchGreen:SetPos(right:GetWide()/2,0)
    //switchGreen:Dock(RIGHT)
    switchGreen:SetBackgroundColor(Color(0,255,0))

    local switchButton = switch:Add("DButton")
    switchButton:SetWidth(right:GetWide()/2)
    switchButton:SetHeight(switchRed:GetTall())
    switchButton:SetPos(0,0)
    switchButton:SetFont("ixMenuButtonFontThick")
    switchButton:SetText(L("switch").."->")
    switchButton:SetPaintBackground(false)
    local bgColor = Color(127, 140, 141)
    switchButton.Paint = function(this,w,h)
        surface.SetDrawColor(bgColor)
        surface.DrawRect(0,0,w,h)
    end
    switchButton.DoClick = function(this)
        if(this:GetX()==right:GetWide()/2) then
            this:MoveTo(0,0,0.4)
            this:SetText(L("switch").."->") 
            //this:SetX(0)
        else
            this:MoveTo(right:GetWide()/2,0,0.4)
            this:SetText("<-"..L("switch")) 
            local result = frame:CheckWires()
            if(result) then
                ix.gui.openedWireConnector = nil
                frame:Remove()
                net.Start("connectWires")
                net.WriteBool(true)
                net.SendToServer()
            else
                net.Start("connectWires")
                net.WriteBool(false)
                net.SendToServer()
            end
            //this:SetX(right:GetWide()/2)
        end
        surface.PlaySound("buttons/button1.wav")
    end

    local labelRight = right:Add("DLabel")
    labelRight:Dock(FILL)
    labelRight:SetFont("ixBigFont")
    labelRight:SetText("Toggle switch and check if everything works")
    labelRight:SetWrap(true)
end