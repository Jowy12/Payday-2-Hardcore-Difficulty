function EnemyManager:_init_enemy_data()
	local enemy_data = {}
	local unit_data = {}
	self._enemy_data = enemy_data
	enemy_data.unit_data = unit_data
	enemy_data.nr_units = 0
	enemy_data.nr_active_units = 0
	enemy_data.nr_inactive_units = 0
	enemy_data.inactive_units = {}
	enemy_data.max_nr_active_units = 1000
	enemy_data.corpses = {}
	enemy_data.nr_corpses = 0
	self._civilian_data = {
		unit_data = {}
	}
	self._queued_tasks = {}
	self._queued_task_executed = nil
	self._delayed_clbks = {}
	self._t = 0
	self._gfx_lod_data = {}
	self._gfx_lod_data.enabled = true
	self._gfx_lod_data.prio_i = {}
	self._gfx_lod_data.prio_weights = {}
	self._gfx_lod_data.next_chk_prio_i = 1
	self._gfx_lod_data.entries = {}
	local lod_entries = self._gfx_lod_data.entries
	lod_entries.units = {}
	lod_entries.states = {}
	lod_entries.move_ext = {}
	lod_entries.trackers = {}
	lod_entries.com = {}
	self._corpse_disposal_enabled = 0
end