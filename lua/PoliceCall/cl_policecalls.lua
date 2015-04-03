surface.CreateFont("SpennyRoboto", {
	font = "Roboto",
	size = 22,
	weight = 400,
	blursize = 0,
	scanlines = 0,
	antialias = true,
})

surface.CreateFont("SpennyRobotoSmall", {
	font = "Roboto",
	size = 16,
	weight = 400,
	blursize = 0,
	scanlines = 0,
	antialias = true,
})

local RadioSound = {
	"ambient/levels/prison/radio_random1.wav",
	"ambient/levels/prison/radio_random10.wav",
	"ambient/levels/prison/radio_random11.wav",
	"ambient/levels/prison/radio_random12.wav",
	"ambient/levels/prison/radio_random13.wav",
	"ambient/levels/prison/radio_random14.wav",
	"ambient/levels/prison/radio_random15.wav",
	"ambient/levels/prison/radio_random2.wav",
	"ambient/levels/prison/radio_random3.wav",
	"ambient/levels/prison/radio_random4.wav",
	"ambient/levels/prison/radio_random5.wav",
	"ambient/levels/prison/radio_random6.wav",
	"ambient/levels/prison/radio_random7.wav",
	"ambient/levels/prison/radio_random8.wav",
	"ambient/levels/prison/radio_random9.wav",
}

net.Receive( "PoliceCallNet", function()
	for _,team in pairs( PPC.AllowedTeams ) do
		if _G[team] != nil and LocalPlayer():Team() == _G[team] then
			local msg = net.ReadString()
			local ply = net.ReadEntity()

			local base = vgui.Create( "DFrame" )
			ply:EmitSound( RadioSound[math.random(#RadioSound)], 100, 100 )
			base:SetPos( ScrW() - 340, 100 )
			base:SetSize( 250, 115 )
			base:SetVisible( true )
			base:SetTitle( PPC:Translate( "panelTitle" ) )
			base:ShowCloseButton( false )
		
			function base:Paint( w, h )
				draw.RoundedBox(0, 0, 0, w, h, PPC.Base)
				draw.RoundedBox(0,0,0, w, h - 95, PPC.Basetopmain)
				draw.RoundedBox(0,0,15, w, h - 110, PPC.Basetopbot)
				surface.DrawOutlinedRect( 2, 2, w - 4 , h - 4 )
			end

			local label1 = vgui.Create( "DLabel" )
			label1:SetParent( base )
			label1:SetPos( 25, 35 )
			label1:SetSize( 200, 50 )
			label1:SetText( msg )
			label1:SetFont( "SpennyRobotoSmall" )

			local label2 = vgui.Create( "DLabel" )
			label2:SetParent( base )
			label2:SetPos( 25, 15 )
			label2:SetSize( 200, 50 )
			label2:SetText( PPC:Translate( "reportLabel", ply:Nick() ) )
			label2:SetFont( "SpennyRoboto" )

			local label3 = vgui.Create( "DLabel" )
			label3:SetParent( base )
			label3:SetPos( 25, 65 )
			label3:SetSize( 200, 50 )
			label3:SetText( PPC:Translate( "respondLabel" ) )
			label3:SetFont( "SpennyRoboto" )

			local btn1 = vgui.Create( "DButton" )
			btn1:SetParent( base )
			btn1:SetPos( 140, 80 )
			btn1:SetSize( 40, 20 )
			btn1:SetText( PPC:Translate( "acceptCall" ) )
			btn1.DoClick = function()
				net.Start( "CallP" )
					net.WriteEntity(ply)
					net.WriteBit(true)
				net.SendToServer()
				base:Close()
			end
			function btn1:Paint( w, h )
				draw.RoundedBox(0, 0, 0, w, h, PPC.Buttontop)
				draw.RoundedBox(0, 0, 0, w, h/2,PPC.Buttonbottom)
			end

			local btn2 = vgui.Create( "DButton" )
			btn2:SetParent( base )
			btn2:SetPos( 190, 80 )
			btn2:SetSize( 40, 20 )
			btn2:SetText( PPC:Translate( "declineCall" ) )
			btn2.DoClick = function()
				net.Start( "CallP" )
					net.WriteEntity(ply)
					net.WriteBit(false)
				net.SendToServer()
				base:Close()
			end
			function btn2:Paint( w, h )
				draw.RoundedBox(0, 0, 0, w, h, PPC.Buttontop)
				draw.RoundedBox(0, 0, 0, w, h/2,PPC.Buttonbottom)
			end
		end
	end
end )