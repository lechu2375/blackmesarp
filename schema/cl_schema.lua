COLOR_HALFLIFE = Color(251,126,20)


local function DoDrop( self, panels, bDoDrop, Command, x, y )
	if ( bDoDrop ) then
		for k, v in pairs( panels ) do
			v:SetParent(self)
            v:DockMargin(5,5,5,5)
            v:Dock(FILL)
		end
	end
end

concommand.Add( "test2", function()

	local frame = vgui.Create( "DPanel" )
	frame:SetSize( ScrW(), ScrH()*0.8)
	//frame:SetTitle( "Frame" )
	frame:MakePopup()
	frame:Center()
    frame:SetDrawBackground(false)
    
    function frame:OnKeyCodePressed(keyCode )
        if(keyCode==KEY_TAB) then self:Remove() end
    end
    frame.left = {}
    frame.drag = {}
    frame.right = {}
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
                //surface.DrawRect(x1, y1, 50, 50)
                //surface.DrawRect(x2, y2, 50, 50)
                draw.NoTexture()
                surface.SetDrawColor(v:GetBackgroundColor())
                surface.DrawTexturedRectRotated( CenterX, CenterY,distance, 10,rotation )
                //surface.DrawLine( x1, y1-3, x2, y2-3 )
            
        end
    end

	local left = vgui.Create( "DPanel", frame )
	left:Dock( LEFT )
	left:SetWidth( frame:GetWide() / 5 )
	left:SetPaintBackground( true )
	left:DockMargin( 0, 0, 4, 0 )
    

	local right = vgui.Create( "DPanel", frame )
	right:Dock( RIGHT )
    right:SetWidth( frame:GetWide() / 5 )
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
		but:SetHeight(frame:GetTall()/8)
        but:DockMargin( 0,50, 0, 0 )
		but:Dock( TOP )
		but:Receiver("color",DoDrop) 
        but:SetBackgroundColor(key)
    end

    colorsCopy = table.Copy(colors)
    for i = 1, 4 do
        local key,color = table.Random( colorsCopy )

        colorsCopy[color] = nil
    	local but = left:Add( "DPanel" )
        frame.left[color] = but
		but:SetText( i )
		but:SetHeight(frame:GetTall()/8)
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
	//right:Receiver( "myDNDname", DoDrop )



end )