Hooks:Add("NetworkManagerOnPeerAdded", "NetworkManagerOnPeerAdded_DW", function(peer, peer_id)
	if Network:is_server() then
		DelayedCalls:Add("DelayedWarnModBB" .. tostring(peer_id), 2, function()
			local message = "This is Hardcore lobby, a custom difficulty made for all hardcore heisters out there! It's suggested for everyone to have the mod installed to get the best experience. Enjoy the game!(V.3.7.9)"
			local peer2 = managers.network:session() and managers.network:session():peer(peer_id)
			if peer2 then
				peer2:send("send_chat_message", ChatManager.GAME, message)
			end
		end)
	end
end)
