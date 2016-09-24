GroupAIStateBesiege = GroupAIStateBesiege or class(GroupAIStateBase)
GroupAIStateBesiege._MAX_SIMULTANEOUS_SPAWNS = 10000

function GroupAIStateBesiege:_upd_assault_task()
	local task_data = self._task_data.assault
	if not task_data.active then
		return
	end
	local t = self._t
	self:_assign_recon_groups_to_retire()
	local force_pool = self:_get_difficulty_dependent_value(tweak_data.group_ai.besiege.assault.force_pool) * self:_get_balancing_multiplier(tweak_data.group_ai.besiege.assault.force_pool_balance_mul)
	local task_spawn_allowance = force_pool - (self._hunt_mode and 0 or task_data.force_spawned)
	if task_data.phase == "anticipation" then
		if task_spawn_allowance <= 0 then
			task_data.phase = "fade"
			task_data.phase_end_t = t + tweak_data.group_ai.besiege.assault.fade_duration
		elseif t > task_data.phase_end_t or self._drama_data.zone == "high" then
			managers.mission:call_global_event("start_assault")
			managers.hud:start_assault()
			self:_set_rescue_state(false)
			task_data.phase = "build"
			task_data.phase_end_t = self._t + tweak_data.group_ai.besiege.assault.build_duration
			task_data.is_hesitating = nil
			self:set_assault_mode(true)
			managers.trade:set_trade_countdown(false)
		else
			managers.hud:check_anticipation_voice(task_data.phase_end_t - t)
			managers.hud:check_start_anticipation_music(task_data.phase_end_t - t)
			if task_data.is_hesitating and self._t > task_data.voice_delay then
				if 0 < self._hostage_headcount then
					local best_group
					for _, group in pairs(self._groups) do
						if not best_group or group.objective.type == "reenforce_area" then
							best_group = group
						elseif best_group.objective.type ~= "reenforce_area" and group.objective.type ~= "retire" then
							best_group = group
						end
					end
					if best_group and self:_voice_delay_assault(best_group) then
						task_data.is_hesitating = nil
					end
				else
					task_data.is_hesitating = nil
				end
			end
		end
	elseif task_data.phase == "build" then
		if task_spawn_allowance <= 0 then
			task_data.phase = "fade"
			task_data.phase_end_t = t + tweak_data.group_ai.besiege.assault.fade_duration
		elseif t > task_data.phase_end_t or self._drama_data.zone == "high" then
			task_data.phase = "sustain"
			task_data.phase_end_t = t + math.lerp(self:_get_difficulty_dependent_value(tweak_data.group_ai.besiege.assault.sustain_duration_min), self:_get_difficulty_dependent_value(tweak_data.group_ai.besiege.assault.sustain_duration_max), math.random()) * self:_get_balancing_multiplier(tweak_data.group_ai.besiege.assault.sustain_duration_balance_mul)
		end
	elseif task_data.phase == "sustain" then
		if task_spawn_allowance <= 0 then
			task_data.phase = "fade"
			task_data.phase_end_t = t + tweak_data.group_ai.besiege.assault.fade_duration
		elseif t > task_data.phase_end_t and not self._hunt_mode then
			task_data.phase = "fade"
			task_data.phase_end_t = t + tweak_data.group_ai.besiege.assault.fade_duration
		end
	else
		local end_assault = true
		local enemies_left = self:_count_police_force("assault")
		if not self._hunt_mode then
			local min_enemies_left = 10
			if enemies_left < min_enemies_left or t > task_data.phase_end_t + 350 then
				if t > task_data.phase_end_t - 8 and not task_data.said_retreat then
					if self._drama_data.amount < tweak_data.drama.assault_fade_end then
						task_data.said_retreat = true
						self:_police_announce_retreat()
					end
				elseif t > task_data.phase_end_t and self._drama_data.amount < tweak_data.drama.assault_fade_end and self:_count_criminals_engaged_force(4) <= 3 then
					end_assault = true
				end
			else
				print("kill more enemies to end fade phase: ", min_enemies_left - enemies_left)
			end
			if task_data.force_end or end_assault then
				print("assault task clear")
				task_data.active = nil
				task_data.phase = nil
				task_data.said_retreat = nil
				if self._draw_drama then
					self._draw_drama.assault_hist[#self._draw_drama.assault_hist][2] = t
				end
				managers.mission:call_global_event("end_assault")
				self:_begin_regroup_task()
				return
			end
		else
			print("disable hunt mode to end fade phase")
		end
	end
	if self._drama_data.amount <= tweak_data.drama.low then
		for criminal_key, criminal_data in pairs(self._player_criminals) do
			self:criminal_spotted(criminal_data.unit)
			for group_id, group in pairs(self._groups) do
				if group.objective.charge then
					for u_key, u_data in pairs(group.units) do
						u_data.unit:brain():clbk_group_member_attention_identified(nil, criminal_key)
					end
				end
			end
		end
	end
	local primary_target_area = task_data.target_areas[1]
	if self:is_area_safe_assault(primary_target_area) then
		local target_pos = primary_target_area.pos
		local nearest_area, nearest_dis
		for criminal_key, criminal_data in pairs(self._player_criminals) do
			if not criminal_data.status then
				local dis = mvector3.distance_sq(target_pos, criminal_data.m_pos)
				if not nearest_dis or nearest_dis > dis then
					nearest_dis = dis
					nearest_area = self:get_area_from_nav_seg_id(criminal_data.tracker:nav_segment())
				end
			end
		end
		if nearest_area then
			primary_target_area = nearest_area
			task_data.target_areas[1] = nearest_area
		end
	end
	local nr_wanted = task_data.force - self:_count_police_force("assault")
	if task_data.phase == "anticipation" then
		nr_wanted = nr_wanted - 5
	end
	if self:_count_police_force("assault") >= 50 then
		nr_wanted = nr_wanted - 100000000
	end
	if nr_wanted > 0 and task_data.phase ~= "fade" then
		local used_event
		if task_data.use_spawn_event and task_data.phase ~= "anticipation" then
			task_data.use_spawn_event = false
			if self:_try_use_task_spawn_event(t, primary_target_area, "assault") then
				used_event = true
			end
		end
		if used_event or next(self._spawning_groups) then
		else
			local spawn_group, spawn_group_type = self:_find_spawn_group_near_area(primary_target_area, tweak_data.group_ai.besiege.assault.groups, nil, nil, nil)
			if spawn_group then
				local grp_objective = {
					type = "assault_area",
					area = spawn_group.area,
					coarse_path = {
						{
							spawn_group.area.pos_nav_seg,
							spawn_group.area.pos
						}
					},
					attitude = "avoid",
					pose = "crouch",
					stance = "hos"
				}
				self:_spawn_in_group(spawn_group, spawn_group_type, grp_objective, task_data)
			end
		end
	end
	if task_data.phase ~= "anticipation" then
		if t > task_data.use_smoke_timer then
			task_data.use_smoke = true
		end
		if self._smoke_grenade_queued and task_data.use_smoke and not self:is_smoke_grenade_active() then
			self:detonate_smoke_grenade(self._smoke_grenade_queued[1], self._smoke_grenade_queued[1], self._smoke_grenade_queued[2], self._smoke_grenade_queued[4])
			if self._smoke_grenade_queued[3] then
				self._smoke_grenade_ignore_control = true
			end
		end
	end
	self:_assign_enemy_groups_to_assault(task_data.phase)
end
function GroupAIStateBesiege:_upd_recon_tasks()
	local task_data = self._task_data.recon.tasks[1]
	self:_assign_enemy_groups_to_recon()
	if not task_data then
		return
	end
	local t = self._t
	self:_assign_assault_groups_to_retire()
	local target_pos = task_data.target_area.pos
	local nr_wanted = self:_get_difficulty_dependent_value(tweak_data.group_ai.besiege.recon.force) - self:_count_police_force("recon")
	if nr_wanted <= 0 then
		return
	end
	if self:_count_police_force("recon") >= 10 then
		nr_wanted = nr_wanted - 100000000
	end
	local used_event, used_spawn_points, reassigned
	if task_data.use_spawn_event then
		task_data.use_spawn_event = false
		if self:_try_use_task_spawn_event(t, task_data.target_area, "recon") then
			used_event = true
		end
	end
	if not used_event then
		local used_group
		if next(self._spawning_groups) then
			used_group = true
		else
			local spawn_group, spawn_group_type = self:_find_spawn_group_near_area(task_data.target_area, tweak_data.group_ai.besiege.recon.groups, nil, nil, callback(self, self, "_verify_anticipation_spawn_point"))
			if spawn_group then
				local grp_objective = {
					type = "recon_area",
					area = spawn_group.area,
					target_area = task_data.target_area,
					attitude = "avoid",
					stance = "hos",
					scan = true
				}
				self:_spawn_in_group(spawn_group, spawn_group_type, grp_objective)
				used_group = true
			end
		end
	end
	if used_event or used_spawn_points or reassigned then
		table.remove(self._task_data.recon.tasks, 1)
		self._task_data.recon.next_dispatch_t = t + math.ceil(self:_get_difficulty_dependent_value(tweak_data.group_ai.besiege.recon.interval)) + math.random() * tweak_data.group_ai.besiege.recon.interval_variation
	end
end

fs_groupaistatebase_converthostagetocriminal = GroupAIStateBase.convert_hostage_to_criminal
function GroupAIStateBase:convert_hostage_to_criminal(unit, ...)
	local ret = fs_groupaistatebase_converthostagetocriminal(self, unit, ...)
	self:on_AI_attention_changed(unit:key())
	return ret
end

local function _requires_attention(cat_filter, att_info)
	local function _is_civ(ctg)
		return ctg and ctg:sub(1, 3) == "civ"
	end

	local function _is_cop(ctg)
		return ctg == "swat"
			or ctg == "city_swat"
			or ctg == "fbi_swat"
			or ctg == "heavy_swat"
			or ctg == "fbi_heavy_swat"
			or ctg == "fbi"
			or ctg == "cop"
			or ctg == "shield"
			or ctg == "taser"
			or ctg == "murky"
			or ctg == "spooc"
			or ctg == "sniper"
			or ctg == "security"
			or ctg == "tank"
			or ctg == "gensec"
			or ctg == "phalanx_minion"
			or ctg == "phalanx_vip"
	end

	local function _cop_is_ignorable(ctg, unit)
		if _is_cop(ctg) then
			return not unit:brain()._logic_data.is_converted
		end
		return false
	end

	local aiub = att_info and att_info.unit and att_info.unit:base()
	if not aiub then
		return false
	end

	return not (_is_cop(cat_filter) and (_cop_is_ignorable(aiub._tweak_table, att_info.unit) or _is_civ(aiub._tweak_table)))
end

function GroupAIStateBase:on_AI_attention_changed(unit_key)
	local att_info = self._attention_objects.all[unit_key]
	local whisper_mode = managers.groupai:state():whisper_mode()

	for cat_filter, list in pairs(self._attention_objects) do
		if cat_filter ~= "all" then
			local cat_filter_num = managers.navigation:convert_access_filter_to_number({cat_filter})
			if not att_info or att_info.handler:get_attention(cat_filter_num, nil, nil, nil) then
				if not whisper_mode and not _requires_attention(cat_filter, att_info) then
					list[unit_key] = nil
				else
					list[unit_key] = att_info
				end
			else
				list[unit_key] = nil
			end
		end
	end
end

function GroupAIStateBase:get_AI_attention_objects_by_filter(filter, team)
	filter = team and type(team) == "table" and team.id == "converted_enemy" and "teamAI1" or filter

	if not self._attention_objects[filter] then
		local whisper_mode = managers.groupai:state():whisper_mode()
		local filter_num = managers.navigation:convert_access_filter_to_number({filter})
		local new_attention_set = {}
		for u_key, attention_info in pairs(self._attention_objects.all) do
			if attention_info.handler:get_attention(filter_num, nil, nil, nil) then
				local aiub = attention_info and attention_info.unit and attention_info.unit:base()
				if whisper_mode or _requires_attention(filter, attention_info) then
					new_attention_set[u_key] = attention_info
				end
			end
		end
		self._attention_objects[filter] = new_attention_set
	end

	return self._attention_objects[filter]
end
