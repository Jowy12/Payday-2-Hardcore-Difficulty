function PlayerDamage:recover_health()
	if managers.platform:presence() == "Playing" and (self:arrested() or self:need_revive()) then
		self:revive(true)
	end
	self:_regenerated(true)
	managers.hud:set_player_health({
		current = self:get_real_health(),
		total = math.max(self:_max_health() * 10),
		revives = Application:digest_value(self._revives, false)
	})
end