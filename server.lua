RegisterServerEvent("kickas")
AddEventHandler("kickas", function()
	DropPlayer(source, Config.PlayerDroppedmsg)
end)  