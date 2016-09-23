function EnemyManager:_update_queued_tasks(t)
	local n = 0
	for i_task, task_data in ipairs(self._queued_tasks) do
		if not task_data.t or t > task_data.t or task_data.asap then
			n = n + 1
			self:_execute_queued_task(i_task)
			if n > 50 then
				break
			end
		end
	end

	local all_clbks = self._delayed_clbks
	if all_clbks[1] and t > all_clbks[1][2] then
		local clbk = table.remove(all_clbks, 1)[3]
		clbk()
	end
end
