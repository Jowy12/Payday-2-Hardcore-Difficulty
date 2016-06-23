    local ENABLE_CUSTOM_FL = true --Enabled aced fully loaded for mods with custom ammo pickup values
    local ENABLE_SPILLOVER = true --Stack fractional pickups instead of rounding
     
    function RaycastWeaponBase:add_ammo(ratio, add_amount_override)
    	if self:ammo_max() then
    		return false, 0
    	end
    	if not add_amount_override and math.max(self._ammo_pickup[1], self._ammo_pickup[2]) < 0.5 then
    		return false, 0
    	end
    	
    	local add_amount = add_amount_override
    	
    	if not add_amount then
    		local multiplier_min = 1.525
    		local multiplier_max = 1.525
    		local skill_multiplier = managers.player:upgrade_value("player", "pick_up_ammo_multiplier", 1) + managers.player:upgrade_value("player", "pick_up_ammo_multiplier_2", 1) - 1
    		
    		if self._ammo_data and self._ammo_data.ammo_pickup_min_mul then
    			multiplier_min = multiplier_min * self._ammo_data.ammo_pickup_min_mul
    		end
    		if ENABLE_CUSTOM_FL or not (self._ammo_data and self._ammo_data.ammo_pickup_min_mul) then
    			multiplier_min = multiplier_min * skill_multiplier
    		end
     
    		if self._ammo_data and self._ammo_data.ammo_pickup_max_mul then
    			multiplier_max = multiplier_max * self._ammo_data.ammo_pickup_max_mul
    		end
    		if ENABLE_CUSTOM_FL or not (self._ammo_data and self._ammo_data.ammo_pickup_max_mul) then
    			multiplier_max = multiplier_max * skill_multiplier
    		end
    		
    		local rng_ammo = math.lerp(self._ammo_pickup[1] * multiplier_min, self._ammo_pickup[2] * multiplier_max, math.random())
    		add_amount = math.max(0, ENABLE_SPILLOVER and rng_ammo or math.round(rng_ammo))
    	end
    	
    	add_amount = add_amount * (ratio or 1)
    	if not ENABLE_SPILLOVER then
    		self._pickup_spillover = 0
    		add_amount = math.floor(add_amount)
    	end
    	
    	self._pickup_spillover = (self._pickup_spillover or 0) + add_amount
    	local real_add_amount = math.floor(self._pickup_spillover)
    	self._pickup_spillover = self._pickup_spillover - real_add_amount
    	self:set_ammo_total(math.clamp(self:get_ammo_total() + real_add_amount, 0, self:get_ammo_max()))
     
    	return true, add_amount
    end
