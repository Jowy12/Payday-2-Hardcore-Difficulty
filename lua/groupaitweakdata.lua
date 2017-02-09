GroupAITweakData = GroupAITweakData or class()
function GroupAITweakData:init(tweak_data)
	local difficulty = Global.game_settings and Global.game_settings.difficulty or "normal"
	local difficulty_index = tweak_data:difficulty_to_index(difficulty)
	print("[GroupAITweakData:init] difficulty", difficulty, "difficulty_index", difficulty_index)
	self:_read_mission_preset(tweak_data)
	self:_create_table_structure()
	self:_init_task_data(difficulty_index)
	self:_init_chatter_data()
	self:_init_unit_categories(difficulty_index)
	self:_init_enemy_spawn_groups(difficulty_index)
end
function GroupAITweakData:_init_chatter_data()
	self.enemy_chatter = {}
	self.enemy_chatter.aggressive = {
		radius = 700,
		max_nr = 20,
		duration = {2, 4},
		interval = {0.75, 1.5},
		group_min = 0,
		queue = "g90"
	}
	self.enemy_chatter.retreat = {
		radius = 900,
		max_nr = 20,
		duration = {2, 4},
		interval = {0.75, 1.5},
		group_min = 0,
		queue = "mov"
	}
	self.enemy_chatter.contact = {
		radius = 700,
		max_nr = 5,
		duration = {1, 3},
		interval = {0.75, 1.5},
		group_min = 2,
		queue = "c01"
	}
	self.enemy_chatter.clear = {
		radius = 1000,
		max_nr = 0,
		duration = {0, 0},
		interval = {0.75, 1.5},
		group_min = 0,
		queue = "clr"
	}
	self.enemy_chatter.go_go = {
		radius = 1000,
		max_nr = 0,
		duration = {10, 10},
		interval = {0.75, 1.2},
		group_min = 0,
		queue = "mov"
	}
	self.enemy_chatter.ready = {
		radius = 700,
		max_nr = 0,
		duration = {10, 10},
		interval = {0.75, 1.2},
		group_min = 0,
		queue = "rdy"
	}
	self.enemy_chatter.smoke = {
		radius = 1000,
		max_nr = 0,
		duration = {0, 0},
		interval = {0, 0},
		group_min = 0,
		queue = "d01"
	}
	self.enemy_chatter.flash_grenade = {
		radius = 1000,
		max_nr = 0,
		duration = {10, 10},
		interval = {0, 0},
		group_min = 0,
		queue = "d02"
	}
	self.enemy_chatter.incomming_tank = {
		radius = 1500,
		max_nr = 0,
		duration = {10, 10},
		interval = {0.5, 1},
		group_min = 0,
		queue = "bdz"
	}
	self.enemy_chatter.incomming_spooc = {
		radius = 1200,
		max_nr = 0,
		duration = {10, 10},
		interval = {0.5, 1},
		group_min = 0,
		queue = "clk"
	}
	self.enemy_chatter.incomming_shield = {
		radius = 1500,
		max_nr = 0,
		duration = {10, 10},
		interval = {0.5, 1},
		group_min = 0,
		queue = "shd"
	}
	self.enemy_chatter.incomming_taser = {
		radius = 1500,
		max_nr = 0,
		duration = {60, 60},
		interval = {0.5, 1},
		group_min = 0,
		queue = "tsr"
	}
end
function GroupAITweakData:_init_unit_categories(difficulty_index)
	local access_type_walk_only = {walk = true}
	local access_type_all = {walk = true, acrobatic = true}
	if difficulty_index <= 2 then
		self.special_unit_spawn_limits = {
			tank = 8,
			taser = 8,
			spooc = 8,
			shield = 8,
			medic = 8
		}
	elseif difficulty_index == 3 then
		self.special_unit_spawn_limits = {
			tank = 8,
			taser = 8,
			spooc = 8,
			shield = 8,
			medic = 8
		}
	elseif difficulty_index == 4 then
		self.special_unit_spawn_limits = {
			tank = 8,
			taser = 8,
			spooc = 8,
			shield = 8,
			medic = 8
		}
	elseif difficulty_index == 5 then
		self.special_unit_spawn_limits = {
			tank = 8,
			taser = 8,
			spooc = 8,
			shield = 8,
			medic = 8
		}
	else
		self.special_unit_spawn_limits = {
			tank = 8,
			taser = 8,
			spooc = 8,
			shield = 8,
			medic = 8
		}
	end
	self.unit_categories = {}
	if difficulty_index == 8 then
		self.unit_categories.spooc = {
			unit_types = {
				america = {
					Idstring("units/pd2_dlc_gitgud/characters/ene_zeal_cloaker/ene_zeal_cloaker")
				},
				russia = {
					Idstring("units/pd2_dlc_mad/characters/ene_akan_fbi_spooc_asval_smg/ene_akan_fbi_spooc_asval_smg")
				}
			},
			access = access_type_all,
			special_type = "spooc"
		}
	else
		self.unit_categories.spooc = {
			unit_types = {
				america = {
					Idstring("units/payday2/characters/ene_spook_1/ene_spook_1")
				},
				russia = {
					Idstring("units/pd2_dlc_mad/characters/ene_akan_fbi_spooc_asval_smg/ene_akan_fbi_spooc_asval_smg")
				}
			},
			access = access_type_all,
			special_type = "spooc"
		}
	end
	self.unit_categories.CS_cop_C45_R870 = {
		unit_types = {
			america = {
				Idstring("units/payday2/characters/ene_cop_1/ene_cop_1"),
				Idstring("units/payday2/characters/ene_cop_3/ene_cop_3"),
				Idstring("units/payday2/characters/ene_cop_4/ene_cop_4")
			},
			russia = {
				Idstring("units/pd2_dlc_mad/characters/ene_akan_cs_cop_r870/ene_akan_cs_cop_r870")
			}
		},
		access = access_type_walk_only
	}
	self.unit_categories.CS_cop_stealth_MP5 = {
		unit_types = {
			america = {
				Idstring("units/payday2/characters/ene_cop_2/ene_cop_2")
			},
			russia = {
				Idstring("units/pd2_dlc_mad/characters/ene_akan_cs_cop_akmsu_smg/ene_akan_cs_cop_akmsu_smg")
			}
		},
		access = access_type_walk_only
	}
	if difficulty_index == 8 then
		self.unit_categories.CS_swat_MP5 = {
			unit_types = {
				america = {
					Idstring("units/pd2_dlc_gitgud/characters/ene_zeal_swat/ene_zeal_swat")
				},
				russia = {
					Idstring("units/pd2_dlc_mad/characters/ene_akan_cs_swat_ak47_ass/ene_akan_cs_swat_ak47_ass")
				}
			},
			access = access_type_all
		}
		self.unit_categories.CS_swat_R870 = {
			unit_types = {
				america = {
					Idstring("units/pd2_dlc_gitgud/characters/ene_zeal_swat/ene_zeal_swat")
				},
				russia = {
					Idstring("units/pd2_dlc_mad/characters/ene_akan_cs_swat_r870/ene_akan_cs_swat_r870")
				}
			},
			access = access_type_all
		}
	else
		self.unit_categories.CS_swat_MP5 = {
			unit_types = {
				america = {
					Idstring("units/payday2/characters/ene_swat_1/ene_swat_1")
				},
				russia = {
					Idstring("units/pd2_dlc_mad/characters/ene_akan_cs_swat_ak47_ass/ene_akan_cs_swat_ak47_ass")
				}
			},
			access = access_type_all
		}
		self.unit_categories.CS_swat_R870 = {
			unit_types = {
				america = {
					Idstring("units/payday2/characters/ene_swat_2/ene_swat_2")
				},
				russia = {
					Idstring("units/pd2_dlc_mad/characters/ene_akan_cs_swat_r870/ene_akan_cs_swat_r870")
				}
			},
			access = access_type_all
		}
	end
	if difficulty_index == 8 then
		self.unit_categories.CS_heavy_M4 = {
			unit_types = {
				america = {
					Idstring("units/pd2_dlc_gitgud/characters/ene_zeal_swat_heavy/ene_zeal_swat_heavy")
				},
				russia = {
					Idstring("units/pd2_dlc_mad/characters/ene_akan_cs_heavy_ak47_ass/ene_akan_cs_heavy_ak47_ass")
				}
			},
			access = access_type_all
		}
		self.unit_categories.CS_heavy_R870 = {
			unit_types = {
				america = {
					Idstring("units/pd2_dlc_gitgud/characters/ene_zeal_swat_heavy/ene_zeal_swat_heavy")
				},
				russia = {
					Idstring("units/pd2_dlc_mad/characters/ene_akan_cs_heavy_r870/ene_akan_cs_heavy_r870")
				}
			},
			access = access_type_all
		}
		self.unit_categories.CS_heavy_M4_w = {
			unit_types = {
				america = {
					Idstring("units/pd2_dlc_gitgud/characters/ene_zeal_swat_heavy/ene_zeal_swat_heavy")
				},
				russia = {
					Idstring("units/pd2_dlc_mad/characters/ene_akan_cs_heavy_ak47_ass/ene_akan_cs_heavy_ak47_ass")
				}
			},
			access = access_type_walk_only
		}
	else
		self.unit_categories.CS_heavy_M4 = {
			unit_types = {
				america = {
					Idstring("units/payday2/characters/ene_swat_heavy_1/ene_swat_heavy_1")
				},
				russia = {
					Idstring("units/pd2_dlc_mad/characters/ene_akan_cs_heavy_ak47_ass/ene_akan_cs_heavy_ak47_ass")
				}
			},
			access = access_type_all
		}
		self.unit_categories.CS_heavy_R870 = {
			unit_types = {
				america = {
					Idstring("units/payday2/characters/ene_swat_heavy_r870/ene_swat_heavy_r870")
				},
				russia = {
					Idstring("units/pd2_dlc_mad/characters/ene_akan_cs_heavy_r870/ene_akan_cs_heavy_r870")
				}
			},
			access = access_type_all
		}
		self.unit_categories.CS_heavy_M4_w = {
			unit_types = {
				america = {
					Idstring("units/payday2/characters/ene_swat_heavy_1/ene_swat_heavy_1")
				},
				russia = {
					Idstring("units/pd2_dlc_mad/characters/ene_akan_cs_heavy_ak47_ass/ene_akan_cs_heavy_ak47_ass")
				}
			},
			access = access_type_walk_only
		}
	end
	self.unit_categories.CS_tazer = {
		unit_types = {
			america = {
				Idstring("units/payday2/characters/ene_tazer_1/ene_tazer_1")
			},
			russia = {
				Idstring("units/pd2_dlc_mad/characters/ene_akan_cs_tazer_ak47_ass/ene_akan_cs_tazer_ak47_ass")
			}
		},
		access = access_type_all,
		special_type = "taser"
	}
	if difficulty_index == 8 then
		self.unit_categories.CS_shield = {
			unit_types = {
				america = {
					Idstring("units/pd2_dlc_gitgud/characters/ene_zeal_swat_shield/ene_zeal_swat_shield")
				},
				russia = {
					Idstring("units/pd2_dlc_mad/characters/ene_akan_cs_shield_c45/ene_akan_cs_shield_c45")
				}
			},
			access = access_type_walk_only,
			special_type = "shield"
		}
	else
		self.unit_categories.CS_shield = {
			unit_types = {
				america = {
					Idstring("units/payday2/characters/ene_shield_2/ene_shield_2")
				},
				russia = {
					Idstring("units/pd2_dlc_mad/characters/ene_akan_cs_shield_c45/ene_akan_cs_shield_c45")
				}
			},
			access = access_type_walk_only,
			special_type = "shield"
		}
	end
	self.unit_categories.FBI_suit_C45_M4 = {
		unit_types = {
			america = {
				Idstring("units/payday2/characters/ene_fbi_1/ene_fbi_1"),
				Idstring("units/payday2/characters/ene_fbi_2/ene_fbi_2")
			},
			russia = {
				Idstring("units/pd2_dlc_mad/characters/ene_akan_cs_cop_ak47_ass/ene_akan_cs_cop_ak47_ass"),
				Idstring("units/pd2_dlc_mad/characters/ene_akan_cs_cop_ak47_ass/ene_akan_cs_cop_ak47_ass")
			}
		},
		access = access_type_all
	}
	self.unit_categories.FBI_suit_M4_MP5 = {
		unit_types = {
			america = {
				Idstring("units/payday2/characters/ene_fbi_2/ene_fbi_2"),
				Idstring("units/payday2/characters/ene_fbi_3/ene_fbi_3")
			},
			russia = {
				Idstring("units/pd2_dlc_mad/characters/ene_akan_cs_cop_asval_smg/ene_akan_cs_cop_asval_smg"),
				Idstring("units/pd2_dlc_mad/characters/ene_akan_cs_cop_asval_smg/ene_akan_cs_cop_asval_smg")
			}
		},
		access = access_type_all
	}
	self.unit_categories.FBI_suit_stealth_MP5 = {
		unit_types = {
			america = {
				Idstring("units/payday2/characters/ene_fbi_3/ene_fbi_3")
			},
			russia = {
				Idstring("units/pd2_dlc_mad/characters/ene_akan_cs_cop_asval_smg/ene_akan_cs_cop_asval_smg")
			}
		},
		access = access_type_all
	}
	if difficulty_index < 6 then
		self.unit_categories.FBI_swat_M4 = {
			unit_types = {
				america = {
					Idstring("units/payday2/characters/ene_fbi_swat_1/ene_fbi_swat_1")
				},
				russia = {
					Idstring("units/pd2_dlc_mad/characters/ene_akan_fbi_swat_ak47_ass/ene_akan_fbi_swat_ak47_ass")
				}
			},
			access = access_type_all
		}
	elseif difficulty_index < 8 then
		self.unit_categories.FBI_swat_M4 = {
			unit_types = {
				america = {
					Idstring("units/payday2/characters/ene_city_swat_1/ene_city_swat_1")
				},
				russia = {
					Idstring("units/pd2_dlc_mad/characters/ene_akan_fbi_swat_dw_ak47_ass/ene_akan_fbi_swat_dw_ak47_ass")
				}
			},
			access = access_type_all
		}
	else
		self.unit_categories.FBI_swat_M4 = {
			unit_types = {
				america = {
					Idstring("units/pd2_dlc_gitgud/characters/ene_zeal_swat/ene_zeal_swat")
				},
				russia = {
					Idstring("units/pd2_dlc_mad/characters/ene_akan_fbi_swat_dw_ak47_ass/ene_akan_fbi_swat_dw_ak47_ass")
				}
			},
			access = access_type_all
		}
	end
	if difficulty_index < 6 then
		self.unit_categories.FBI_swat_R870 = {
			unit_types = {
				america = {
					Idstring("units/payday2/characters/ene_fbi_swat_2/ene_fbi_swat_2")
				},
				russia = {
					Idstring("units/pd2_dlc_mad/characters/ene_akan_fbi_swat_r870/ene_akan_fbi_swat_r870")
				}
			},
			access = access_type_all
		}
	elseif difficulty_index < 8 then
		self.unit_categories.FBI_swat_R870 = {
			unit_types = {
				america = {
					Idstring("units/payday2/characters/ene_fbi_swat_2/ene_fbi_swat_2")
				},
				russia = {
					Idstring("units/pd2_dlc_mad/characters/ene_akan_fbi_swat_dw_r870/ene_akan_fbi_swat_dw_r870")
				}
			},
			access = access_type_all
		}
	else
		self.unit_categories.FBI_swat_R870 = {
			unit_types = {
				america = {
					Idstring("units/pd2_dlc_gitgud/characters/ene_zeal_swat/ene_zeal_swat")
				},
				russia = {
					Idstring("units/pd2_dlc_mad/characters/ene_akan_fbi_swat_dw_r870/ene_akan_fbi_swat_dw_r870")
				}
			},
			access = access_type_all
		}
	end
	if difficulty_index < 6 then
		self.unit_categories.FBI_heavy_G36 = {
			unit_types = {
				america = {
					Idstring("units/payday2/characters/ene_fbi_heavy_1/ene_fbi_heavy_1")
				},
				russia = {
					Idstring("units/pd2_dlc_mad/characters/ene_akan_fbi_heavy_g36/ene_akan_fbi_heavy_g36")
				}
			},
			access = access_type_all
		}
	elseif difficulty_index < 8 then
		self.unit_categories.FBI_heavy_G36 = {
			unit_types = {
				america = {
					Idstring("units/payday2/characters/ene_city_heavy_g36/ene_city_heavy_g36")
				},
				russia = {
					Idstring("units/pd2_dlc_mad/characters/ene_akan_fbi_heavy_g36/ene_akan_fbi_heavy_g36")
				}
			},
			access = access_type_all
		}
	else
		self.unit_categories.FBI_heavy_G36 = {
			unit_types = {
				america = {
					Idstring("units/pd2_dlc_gitgud/characters/ene_zeal_swat_heavy/ene_zeal_swat_heavy")
				},
				russia = {
					Idstring("units/pd2_dlc_mad/characters/ene_akan_fbi_heavy_g36/ene_akan_fbi_heavy_g36")
				}
			},
			access = access_type_all
		}
	end
	if difficulty_index < 6 then
		self.unit_categories.FBI_heavy_R870 = {
			unit_types = {
				america = {
					Idstring("units/payday2/characters/ene_fbi_heavy_r870/ene_fbi_heavy_r870")
				},
				russia = {
					Idstring("units/pd2_dlc_mad/characters/ene_akan_fbi_heavy_r870/ene_akan_fbi_heavy_r870")
				}
			},
			access = access_type_all
		}
	elseif difficulty_index < 8 then
		self.unit_categories.FBI_heavy_R870 = {
			unit_types = {
				america = {
					Idstring("units/payday2/characters/ene_city_heavy_r870/ene_city_heavy_r870")
				},
				russia = {
					Idstring("units/pd2_dlc_mad/characters/ene_akan_fbi_heavy_r870/ene_akan_fbi_heavy_r870")
				}
			},
			access = access_type_all
		}
	else
		self.unit_categories.FBI_heavy_R870 = {
			unit_types = {
				america = {
					Idstring("units/pd2_dlc_gitgud/characters/ene_zeal_swat_heavy/ene_zeal_swat_heavy")
				},
				russia = {
					Idstring("units/pd2_dlc_mad/characters/ene_akan_fbi_heavy_r870/ene_akan_fbi_heavy_r870")
				}
			},
			access = access_type_all
		}
	end
	if difficulty_index < 8 then
		self.unit_categories.FBI_heavy_G36_w = {
			unit_types = {
				america = {
					Idstring("units/payday2/characters/ene_fbi_heavy_1/ene_fbi_heavy_1")
				},
				russia = {
					Idstring("units/pd2_dlc_mad/characters/ene_akan_fbi_heavy_g36/ene_akan_fbi_heavy_g36")
				}
			},
			access = access_type_walk_only
		}
	else
		self.unit_categories.FBI_heavy_G36_w = {
			unit_types = {
				america = {
					Idstring("units/pd2_dlc_gitgud/characters/ene_zeal_swat_heavy/ene_zeal_swat_heavy")
				},
				russia = {
					Idstring("units/pd2_dlc_mad/characters/ene_akan_fbi_heavy_g36/ene_akan_fbi_heavy_g36")
				}
			},
			access = access_type_walk_only
		}
	end
	if difficulty_index < 6 then
		self.unit_categories.FBI_shield = {
			unit_types = {
				america = {
					Idstring("units/payday2/characters/ene_shield_1/ene_shield_1")
				},
				russia = {
					Idstring("units/pd2_dlc_mad/characters/ene_akan_fbi_shield_sr2_smg/ene_akan_fbi_shield_sr2_smg")
				}
			},
			access = access_type_walk_only,
			special_type = "shield"
		}
	elseif difficulty_index < 8 then
		self.unit_categories.FBI_shield = {
			unit_types = {
				america = {
					Idstring("units/payday2/characters/ene_city_shield/ene_city_shield")
				},
				russia = {
					Idstring("units/pd2_dlc_mad/characters/ene_akan_fbi_shield_dw_sr2_smg/ene_akan_fbi_shield_dw_sr2_smg")
				}
			},
			access = access_type_walk_only,
			special_type = "shield"
		}
	else
		self.unit_categories.FBI_shield = {
			unit_types = {
				america = {
					Idstring("units/pd2_dlc_gitgud/characters/ene_zeal_swat_shield/ene_zeal_swat_shield")
				},
				russia = {
					Idstring("units/pd2_dlc_mad/characters/ene_akan_fbi_shield_dw_sr2_smg/ene_akan_fbi_shield_dw_sr2_smg")
				}
			},
			access = access_type_walk_only,
			special_type = "shield"
		}
	end
	if difficulty_index < 5 then
		self.unit_categories.FBI_tank = {
			unit_types = {
				america = {
					Idstring("units/payday2/characters/ene_bulldozer_1/ene_bulldozer_1")
				},
				russia = {
					Idstring("units/pd2_dlc_mad/characters/ene_akan_fbi_tank_r870/ene_akan_fbi_tank_r870")
				}
			},
			access = access_type_all,
			special_type = "tank"
		}
	elseif difficulty_index <= 6 then
		self.unit_categories.FBI_tank = {
			unit_types = {
				america = {
					Idstring("units/payday2/characters/ene_bulldozer_1/ene_bulldozer_1"),
					Idstring("units/payday2/characters/ene_bulldozer_2/ene_bulldozer_2")
				},
				russia = {
					Idstring("units/pd2_dlc_mad/characters/ene_akan_fbi_tank_saiga/ene_akan_fbi_tank_saiga"),
					Idstring("units/pd2_dlc_mad/characters/ene_akan_fbi_tank_r870/ene_akan_fbi_tank_r870")
				}
			},
			access = access_type_all,
			special_type = "tank"
		}
	elseif difficulty_index <= 7 then
		self.unit_categories.FBI_tank = {
			unit_types = {
				america = {
					Idstring("units/payday2/characters/ene_bulldozer_1/ene_bulldozer_1"),
					Idstring("units/payday2/characters/ene_bulldozer_2/ene_bulldozer_2"),
					Idstring("units/payday2/characters/ene_bulldozer_3/ene_bulldozer_3")
				},
				russia = {
					Idstring("units/pd2_dlc_mad/characters/ene_akan_fbi_tank_r870/ene_akan_fbi_tank_r870"),
					Idstring("units/pd2_dlc_mad/characters/ene_akan_fbi_tank_saiga/ene_akan_fbi_tank_saiga"),
					Idstring("units/pd2_dlc_mad/characters/ene_akan_fbi_tank_rpk_lmg/ene_akan_fbi_tank_rpk_lmg")
				}
			},
			access = access_type_all,
			special_type = "tank"
		}
	else
		self.unit_categories.FBI_tank = {
			unit_types = {
				america = {
					Idstring("units/pd2_dlc_gitgud/characters/ene_zeal_bulldozer/ene_zeal_bulldozer"),
					Idstring("units/pd2_dlc_gitgud/characters/ene_zeal_bulldozer_2/ene_zeal_bulldozer_2"),
					Idstring("units/pd2_dlc_gitgud/characters/ene_zeal_bulldozer_3/ene_zeal_bulldozer_3")
				},
				russia = {
					Idstring("units/pd2_dlc_mad/characters/ene_akan_fbi_tank_r870/ene_akan_fbi_tank_r870"),
					Idstring("units/pd2_dlc_mad/characters/ene_akan_fbi_tank_saiga/ene_akan_fbi_tank_saiga"),
					Idstring("units/pd2_dlc_mad/characters/ene_akan_fbi_tank_rpk_lmg/ene_akan_fbi_tank_rpk_lmg")
				}
			},
			access = access_type_all,
			special_type = "tank"
		}
	end
	self.unit_categories.medic_M4 = {
		unit_types = {
			america = {
				Idstring("units/payday2/characters/ene_medic_m4/ene_medic_m4")
			},
			russia = {
				Idstring("units/payday2/characters/ene_medic_m4/ene_medic_m4")
			}
		},
		access = access_type_all,
		special_type = "medic"
	}
	self.unit_categories.medic_R870 = {
		unit_types = {
			america = {
				Idstring("units/payday2/characters/ene_medic_r870/ene_medic_r870")
			},
			russia = {
				Idstring("units/payday2/characters/ene_medic_r870/ene_medic_r870")
			}
		},
		access = access_type_all,
		special_type = "medic"
	}
	self.unit_categories.Phalanx_minion = {
		unit_types = {
			america = {
				Idstring("units/pd2_dlc_vip/characters/ene_phalanx_1/ene_phalanx_1")
			},
			russia = {
				Idstring("units/pd2_dlc_vip/characters/ene_phalanx_1/ene_phalanx_1")
			}
		},
		access = access_type_walk_only,
		special_type = "shield",
		is_captain = true
	}
	self.unit_categories.Phalanx_vip = {
		unit_types = {
			america = {
				Idstring("units/pd2_dlc_vip/characters/ene_vip_1/ene_vip_1")
			},
			russia = {
				Idstring("units/pd2_dlc_vip/characters/ene_vip_1/ene_vip_1")
			}
		},
		access = access_type_walk_only,
		special_type = "shield",
		is_captain = true
	}
end
function GroupAITweakData:_init_enemy_spawn_groups(difficulty_index)
	self._tactics = {
		Phalanx_minion = {
			"smoke_grenade",
			"charge",
			"provide_coverfire",
			"provide_support",
			"shield",
			"deathguard"
		},
		Phalanx_vip = {
			"smoke_grenade",
			"charge",
			"provide_coverfire",
			"provide_support",
			"shield",
			"deathguard"
		},
		swat_shotgun_rush = {
			"charge",
			"provide_coverfire",
			"provide_support",
			"deathguard",
			"flash_grenade"
		},
		swat_shotgun_flank = {
			"charge",
			"provide_coverfire",
			"provide_support",
			"flank",
			"deathguard",
			"flash_grenade"
		},
		swat_rifle = {
			"ranged_fire",
			"provide_coverfire",
			"provide_support"
		},
		swat_rifle_flank = {
			"ranged_fire",
			"provide_coverfire",
			"provide_support",
			"flank",
			"flash_grenade"
		},
		shield_wall_ranged = {
			"shield",
			"ranged_fire",
			"provide_support "
		},
		shield_support_ranged = {
			"shield_cover",
			"ranged_fire",
			"provide_coverfire"
		},
		shield_wall_charge = {
			"shield",
			"charge",
			"provide_support "
		},
		shield_support_charge = {
			"shield_cover",
			"charge",
			"provide_coverfire",
			"flash_grenade"
		},
		shield_wall = {
			"shield",
			"ranged_fire",
			"provide_support",
			"murder",
			"deathguard"
		},
		tazer_flanking = {
			"flanking",
			"charge",
			"provide_coverfire",
			"smoke_grenade",
			"murder"
		},
		tazer_charge = {
			"charge",
			"provide_coverfire",
			"murder"
		},
		tank_rush = {
			"charge",
			"provide_coverfire",
			"murder"
		},
		spooc = {
			"charge",
			"shield_cover",
			"smoke_grenade"
		}
	}
	self.enemy_spawn_groups = {}
	if difficulty_index <= 2 then
		self.enemy_spawn_groups.tac_swat_shotgun_rush = {
			amount = {3, 3},
			spawn = {
				{
					unit = "CS_swat_R870",
					freq = 1,
					amount_min = 2,
					amount_max = 2,
					tactics = self._tactics.swat_shotgun_rush,
					rank = 2
				},
				{
					unit = "CS_heavy_R870",
					freq = 1,
					amount_min = 1,
					amount_max = 1,
					tactics = self._tactics.swat_shotgun_rush,
					rank = 3
				}
			}
		}
	elseif difficulty_index == 3 then
		self.enemy_spawn_groups.tac_swat_shotgun_rush = {
			amount = {4, 4},
			spawn = {
				{
					unit = "CS_swat_R870",
					freq = 1,
					amount_min = 2,
					amount_max = 2,
					tactics = self._tactics.swat_shotgun_rush,
					rank = 2
				},
				{
					unit = "CS_heavy_R870",
					freq = 1,
					amount_min = 2,
					amount_max = 2,
					tactics = self._tactics.swat_shotgun_rush,
					rank = 3
				}
			}
		}
	elseif difficulty_index == 4 then
		self.enemy_spawn_groups.tac_swat_shotgun_rush = {
			amount = {4, 4},
			spawn = {
				{
					unit = "FBI_swat_R870",
					freq = 1,
					amount_min = 3,
					amount_max = 3,
					tactics = self._tactics.swat_shotgun_rush,
					rank = 2
				},
				{
					unit = "FBI_heavy_R870",
					freq = 1,
					amount_min = 1,
					amount_max = 1,
					tactics = self._tactics.swat_shotgun_rush,
					rank = 3
				}
			}
		}
	elseif difficulty_index == 5 then
		self.enemy_spawn_groups.tac_swat_shotgun_rush = {
			amount = {4, 5},
			spawn = {
				{
					unit = "FBI_swat_R870",
					freq = 2,
					amount_min = 2,
					amount_max = 2,
					tactics = self._tactics.swat_shotgun_rush,
					rank = 2
				},
				{
					unit = "FBI_heavy_R870",
					freq = 2,
					amount_min = 2,
					amount_max = 2,
					tactics = self._tactics.swat_shotgun_rush,
					rank = 3
				},
				{
					unit = "medic_R870",
					freq = 0.2,
					amount_min = 1,
					amount_max = 1,
					tactics = self._tactics.swat_shotgun_rush,
					rank = 2
				}
			}
		}
	elseif difficulty_index == 6 then
		self.enemy_spawn_groups.tac_swat_shotgun_rush = {
			amount = {4, 5},
			spawn = {
				{
					unit = "FBI_swat_R870",
					freq = 3,
					amount_min = 3,
					amount_max = 3,
					tactics = self._tactics.swat_shotgun_rush,
					rank = 2
				},
				{
					unit = "FBI_heavy_R870",
					freq = 1,
					amount_min = 1,
					amount_max = 1,
					tactics = self._tactics.swat_shotgun_rush,
					rank = 3
				},
				{
					unit = "medic_R870",
					freq = 0.35,
					amount_min = 1,
					amount_max = 1,
					tactics = self._tactics.swat_shotgun_rush,
					rank = 2
				}
			}
		}
	elseif difficulty_index == 7 then
		self.enemy_spawn_groups.tac_swat_shotgun_rush = {
			amount = {4, 5},
			spawn = {
				{
					unit = "FBI_swat_R870",
					freq = 2,
					amount_min = 2,
					amount_max = 2,
					tactics = self._tactics.swat_shotgun_rush,
					rank = 2
				},
				{
					unit = "FBI_heavy_R870",
					freq = 2,
					amount_min = 2,
					amount_max = 2,
					tactics = self._tactics.swat_shotgun_rush,
					rank = 3
				},
				{
					unit = "medic_R870",
					freq = 0.35,
					amount_min = 1,
					amount_max = 1,
					tactics = self._tactics.swat_shotgun_rush,
					rank = 2
				}
			}
		}
	else
		self.enemy_spawn_groups.tac_swat_shotgun_rush = {
			amount = {4, 5},
			spawn = {
				{
					unit = "FBI_swat_R870",
					freq = 1,
					amount_min = 1,
					amount_max = 1,
					tactics = self._tactics.swat_shotgun_rush,
					rank = 2
				},
				{
					unit = "FBI_heavy_R870",
					freq = 3,
					amount_min = 3,
					amount_max = 3,
					tactics = self._tactics.swat_shotgun_rush,
					rank = 3
				},
				{
					unit = "medic_R870",
					freq = 0.35,
					amount_min = 1,
					amount_max = 1,
					tactics = self._tactics.swat_shotgun_rush,
					rank = 2
				}
			}
		}
	end
	self.enemy_spawn_groups = {}
	if difficulty_index <= 2 then
		self.enemy_spawn_groups.tac_swat_shotgun_flank = {
			amount = {3, 3},
			spawn = {
				{
					unit = "CS_swat_R870",
					freq = 1,
					amount_min = 2,
					amount_max = 2,
					tactics = self._tactics.swat_shotgun_flank,
					rank = 2
				},
				{
					unit = "CS_heavy_R870",
					freq = 1,
					amount_min = 1,
					amount_max = 1,
					tactics = self._tactics.swat_shotgun_flank,
					rank = 3
				}
			}
		}
	elseif difficulty_index == 3 then
		self.enemy_spawn_groups.tac_swat_shotgun_flank = {
			amount = {4, 4},
			spawn = {
				{
					unit = "CS_swat_R870",
					freq = 1,
					amount_min = 2,
					amount_max = 2,
					tactics = self._tactics.swat_shotgun_flank,
					rank = 2
				},
				{
					unit = "CS_heavy_R870",
					freq = 1,
					amount_min = 2,
					amount_max = 2,
					tactics = self._tactics.swat_shotgun_flank,
					rank = 3
				}
			}
		}
	elseif difficulty_index == 4 then
		self.enemy_spawn_groups.tac_swat_shotgun_flank = {
			amount = {4, 4},
			spawn = {
				{
					unit = "FBI_swat_R870",
					freq = 1,
					amount_min = 3,
					amount_max = 3,
					tactics = self._tactics.swat_shotgun_flank,
					rank = 2
				},
				{
					unit = "FBI_heavy_R870",
					freq = 1,
					amount_min = 1,
					amount_max = 1,
					tactics = self._tactics.swat_shotgun_flank,
					rank = 3
				}
			}
		}
	elseif difficulty_index == 5 then
		self.enemy_spawn_groups.tac_swat_shotgun_flank = {
			amount = {4, 5},
			spawn = {
				{
					unit = "FBI_swat_R870",
					freq = 2,
					amount_min = 2,
					amount_max = 2,
					tactics = self._tactics.swat_shotgun_flank,
					rank = 2
				},
				{
					unit = "FBI_heavy_R870",
					freq = 2,
					amount_min = 2,
					amount_max = 2,
					tactics = self._tactics.swat_shotgun_flank,
					rank = 3
				},
				{
					unit = "medic_R870",
					freq = 0.2,
					amount_min = 0,
					amount_max = 1,
					tactics = self._tactics.swat_shotgun_flank,
					rank = 2
				}
			}
		}
	elseif difficulty_index == 6 then
		self.enemy_spawn_groups.tac_swat_shotgun_flank = {
			amount = {4, 5},
			spawn = {
				{
					unit = "FBI_swat_R870",
					freq = 3,
					amount_min = 3,
					amount_max = 3,
					tactics = self._tactics.swat_shotgun_flank,
					rank = 2
				},
				{
					unit = "FBI_heavy_R870",
					freq = 1,
					amount_min = 1,
					amount_max = 1,
					tactics = self._tactics.swat_shotgun_flank,
					rank = 3
				},
				{
					unit = "medic_R870",
					freq = 0.35,
					amount_min = 0,
					amount_max = 1,
					tactics = self._tactics.swat_shotgun_flank,
					rank = 2
				}
			}
		}
	elseif difficulty_index == 7 then
		self.enemy_spawn_groups.tac_swat_shotgun_flank = {
			amount = {4, 5},
			spawn = {
				{
					unit = "FBI_swat_R870",
					freq = 2,
					amount_min = 2,
					amount_max = 2,
					tactics = self._tactics.swat_shotgun_flank,
					rank = 2
				},
				{
					unit = "FBI_heavy_R870",
					freq = 2,
					amount_min = 2,
					amount_max = 2,
					tactics = self._tactics.swat_shotgun_flank,
					rank = 3
				},
				{
					unit = "medic_R870",
					freq = 0.35,
					amount_min = 0,
					amount_max = 1,
					tactics = self._tactics.swat_shotgun_flank,
					rank = 2
				}
			}
		}
	else
		self.enemy_spawn_groups.tac_swat_shotgun_flank = {
			amount = {4, 5},
			spawn = {
				{
					unit = "FBI_swat_R870",
					freq = 1,
					amount_min = 1,
					amount_max = 1,
					tactics = self._tactics.swat_shotgun_flank,
					rank = 2
				},
				{
					unit = "FBI_heavy_R870",
					freq = 3,
					amount_min = 3,
					amount_max = 3,
					tactics = self._tactics.swat_shotgun_flank,
					rank = 3
				},
				{
					unit = "medic_R870",
					freq = 0.5,
					amount_min = 0,
					amount_max = 1,
					tactics = self._tactics.swat_shotgun_flank,
					rank = 2
				}
			}
		}
	end
	self.enemy_spawn_groups = {}
	if difficulty_index <= 2 then
		self.enemy_spawn_groups.tac_swat_rifle = {
			amount = {3, 3},
			spawn = {
				{
					unit = "CS_swat_MP5",
					freq = 1,
					amount_min = 2,
					amount_max = 2,
					tactics = self._tactics.swat_rifle,
					rank = 2
				},
				{
					unit = "CS_heavy_M4",
					freq = 1,
					amount_min = 1,
					amount_max = 1,
					tactics = self._tactics.swat_rifle,
					rank = 3
				}
			}
		}
	elseif difficulty_index == 3 then
		self.enemy_spawn_groups.tac_swat_rifle = {
			amount = {4, 4},
			spawn = {
				{
					unit = "CS_swat_MP5",
					freq = 1,
					amount_min = 2,
					amount_max = 2,
					tactics = self._tactics.swat_rifle,
					rank = 2
				},
				{
					unit = "CS_heavy_M4",
					freq = 1,
					amount_min = 2,
					amount_max = 2,
					tactics = self._tactics.swat_rifle,
					rank = 3
				}
			}
		}
	elseif difficulty_index == 4 then
		self.enemy_spawn_groups.tac_swat_rifle = {
			amount = {4, 4},
			spawn = {
				{
					unit = "FBI_swat_M4",
					freq = 1,
					amount_min = 3,
					amount_max = 3,
					tactics = self._tactics.swat_rifle,
					rank = 2
				},
				{
					unit = "FBI_heavy_G36",
					freq = 1,
					amount_min = 1,
					amount_max = 1,
					tactics = self._tactics.swat_rifle,
					rank = 3
				}
			}
		}
	elseif difficulty_index == 5 then
		self.enemy_spawn_groups.tac_swat_rifle = {
			amount = {4, 5},
			spawn = {
				{
					unit = "FBI_swat_M4",
					freq = 2,
					amount_min = 2,
					amount_max = 2,
					tactics = self._tactics.swat_rifle,
					rank = 2
				},
				{
					unit = "FBI_heavy_G36",
					freq = 2,
					amount_min = 2,
					amount_max = 2,
					tactics = self._tactics.swat_rifle,
					rank = 3
				},
				{
					unit = "medic_M4",
					freq = 0.2,
					amount_min = 0,
					amount_max = 1,
					tactics = self._tactics.swat_rifle,
					rank = 2
				}
			}
		}
	elseif difficulty_index == 6 then
		self.enemy_spawn_groups.tac_swat_rifle = {
			amount = {4, 5},
			spawn = {
				{
					unit = "FBI_swat_M4",
					freq = 3,
					amount_min = 3,
					amount_max = 3,
					tactics = self._tactics.swat_rifle,
					rank = 2
				},
				{
					unit = "FBI_heavy_G36",
					freq = 1,
					amount_min = 1,
					amount_max = 1,
					tactics = self._tactics.swat_rifle,
					rank = 3
				},
				{
					unit = "medic_M4",
					freq = 0.35,
					amount_min = 0,
					amount_max = 1,
					tactics = self._tactics.swat_rifle,
					rank = 2
				}
			}
		}
	elseif difficulty_index == 7 then
		self.enemy_spawn_groups.tac_swat_rifle = {
			amount = {4, 5},
			spawn = {
				{
					unit = "FBI_swat_M4",
					freq = 2,
					amount_min = 2,
					amount_max = 2,
					tactics = self._tactics.swat_rifle,
					rank = 2
				},
				{
					unit = "FBI_heavy_G36",
					freq = 2,
					amount_min = 2,
					amount_max = 2,
					tactics = self._tactics.swat_rifle,
					rank = 3
				},
				{
					unit = "medic_M4",
					freq = 0.35,
					amount_min = 0,
					amount_max = 1,
					tactics = self._tactics.swat_rifle,
					rank = 2
				}
			}
		}
	else
		self.enemy_spawn_groups.tac_swat_rifle = {
			amount = {4, 5},
			spawn = {
				{
					unit = "FBI_swat_M4",
					freq = 1,
					amount_min = 1,
					amount_max = 1,
					tactics = self._tactics.swat_rifle,
					rank = 2
				},
				{
					unit = "FBI_heavy_G36",
					freq = 3,
					amount_min = 3,
					amount_max = 3,
					tactics = self._tactics.swat_rifle,
					rank = 3
				},
				{
					unit = "medic_M4",
					freq = 0.5,
					amount_min = 0,
					amount_max = 1,
					tactics = self._tactics.swat_rifle,
					rank = 2
				}
			}
		}
	end
	self.enemy_spawn_groups = {}
	if difficulty_index <= 2 then
		self.enemy_spawn_groups.tac_swat_rifle_flank = {
			amount = {3, 3},
			spawn = {
				{
					unit = "CS_swat_MP5",
					freq = 1,
					amount_min = 2,
					amount_max = 2,
					tactics = self._tactics.swat_rifle_flank,
					rank = 2
				},
				{
					unit = "CS_heavy_M4",
					freq = 1,
					amount_min = 1,
					amount_max = 1,
					tactics = self._tactics.swat_rifle_flank,
					rank = 3
				}
			}
		}
	elseif difficulty_index == 3 then
		self.enemy_spawn_groups.tac_swat_rifle_flank = {
			amount = {4, 4},
			spawn = {
				{
					unit = "CS_swat_MP5",
					freq = 1,
					amount_min = 2,
					amount_max = 2,
					tactics = self._tactics.swat_rifle_flank,
					rank = 2
				},
				{
					unit = "CS_heavy_M4",
					freq = 1,
					amount_min = 2,
					amount_max = 2,
					tactics = self._tactics.swat_rifle_flank,
					rank = 3
				}
			}
		}
	elseif difficulty_index == 4 then
		self.enemy_spawn_groups.tac_swat_rifle_flank = {
			amount = {4, 4},
			spawn = {
				{
					unit = "FBI_swat_M4",
					freq = 1,
					amount_min = 3,
					amount_max = 3,
					tactics = self._tactics.swat_rifle_flank,
					rank = 2
				},
				{
					unit = "FBI_heavy_G36",
					freq = 1,
					amount_min = 1,
					amount_max = 1,
					tactics = self._tactics.swat_rifle_flank,
					rank = 3
				}
			}
		}
	elseif difficulty_index == 5 then
		self.enemy_spawn_groups.tac_swat_rifle_flank = {
			amount = {4, 5},
			spawn = {
				{
					unit = "FBI_swat_M4",
					freq = 2,
					amount_min = 2,
					amount_max = 2,
					tactics = self._tactics.swat_rifle_flank,
					rank = 2
				},
				{
					unit = "FBI_heavy_G36",
					freq = 2,
					amount_min = 2,
					amount_max = 2,
					tactics = self._tactics.swat_rifle_flank,
					rank = 3
				},
				{
					unit = "medic_M4",
					freq = 0.2,
					amount_min = 0,
					amount_max = 1,
					tactics = self._tactics.swat_rifle_flank,
					rank = 2
				}
			}
		}
	elseif difficulty_index == 6 then
		self.enemy_spawn_groups.tac_swat_rifle_flank = {
			amount = {4, 5},
			spawn = {
				{
					unit = "FBI_swat_M4",
					freq = 3,
					amount_min = 3,
					amount_max = 3,
					tactics = self._tactics.swat_rifle_flank,
					rank = 2
				},
				{
					unit = "FBI_heavy_G36",
					freq = 1,
					amount_min = 1,
					amount_max = 1,
					tactics = self._tactics.swat_rifle_flank,
					rank = 3
				},
				{
					unit = "medic_M4",
					freq = 0.35,
					amount_min = 0,
					amount_max = 1,
					tactics = self._tactics.swat_rifle_flank,
					rank = 2
				}
			}
		}
	elseif difficulty_index == 7 then
		self.enemy_spawn_groups.tac_swat_rifle_flank = {
			amount = {4, 5},
			spawn = {
				{
					unit = "FBI_swat_M4",
					freq = 2,
					amount_min = 2,
					amount_max = 2,
					tactics = self._tactics.swat_rifle_flank,
					rank = 2
				},
				{
					unit = "FBI_heavy_G36",
					freq = 2,
					amount_min = 2,
					amount_max = 2,
					tactics = self._tactics.swat_rifle_flank,
					rank = 3
				},
				{
					unit = "medic_M4",
					freq = 0.35,
					amount_min = 0,
					amount_max = 1,
					tactics = self._tactics.swat_rifle_flank,
					rank = 2
				}
			}
		}
	else
		self.enemy_spawn_groups.tac_swat_rifle_flank = {
			amount = {4, 5},
			spawn = {
				{
					unit = "FBI_swat_M4",
					freq = 1,
					amount_min = 1,
					amount_max = 1,
					tactics = self._tactics.swat_rifle_flank,
					rank = 2
				},
				{
					unit = "FBI_heavy_G36",
					freq = 3,
					amount_min = 3,
					amount_max = 3,
					tactics = self._tactics.swat_rifle_flank,
					rank = 3
				},
				{
					unit = "medic_M4",
					freq = 0.35,
					amount_min = 0,
					amount_max = 1,
					tactics = self._tactics.swat_rifle_flank,
					rank = 2
				}
			}
		}
	end
	if difficulty_index <= 2 then
		self.enemy_spawn_groups.tac_shield_wall_ranged = {
			amount = {4, 4},
			spawn = {
				{
					unit = "CS_swat_MP5",
					freq = 1,
					amount_min = 2,
					amount_max = 2,
					tactics = self._tactics.shield_support_ranged,
					rank = 2
				},
				{
					unit = "CS_shield",
					freq = 1,
					amount_min = 2,
					amount_max = 2,
					tactics = self._tactics.shield_wall_ranged,
					rank = 3
				}
			}
		}
	elseif difficulty_index == 3 then
		self.enemy_spawn_groups.tac_shield_wall_ranged = {
			amount = {4, 4},
			spawn = {
				{
					unit = "CS_heavy_M4",
					freq = 1,
					amount_min = 2,
					amount_max = 2,
					tactics = self._tactics.shield_support_ranged,
					rank = 2
				},
				{
					unit = "CS_shield",
					freq = 1,
					amount_min = 2,
					amount_max = 2,
					tactics = self._tactics.shield_wall_ranged,
					rank = 3
				}
			}
		}
	elseif difficulty_index == 4 then
		self.enemy_spawn_groups.tac_shield_wall_ranged = {
			amount = {4, 4},
			spawn = {
				{
					unit = "FBI_swat_M4",
					freq = 1,
					amount_min = 2,
					amount_max = 2,
					tactics = self._tactics.shield_support_ranged,
					rank = 2
				},
				{
					unit = "FBI_shield",
					freq = 1,
					amount_min = 2,
					amount_max = 2,
					tactics = self._tactics.shield_wall_ranged,
					rank = 3
				}
			}
		}
	elseif difficulty_index == 5 then
		self.enemy_spawn_groups.tac_shield_wall_ranged = {
			amount = {4, 5},
			spawn = {
				{
					unit = "FBI_heavy_G36",
					freq = 2,
					amount_min = 2,
					amount_max = 2,
					tactics = self._tactics.shield_support_ranged,
					rank = 2
				},
				{
					unit = "FBI_shield",
					freq = 2,
					amount_min = 2,
					amount_max = 2,
					tactics = self._tactics.shield_wall_ranged,
					rank = 3
				},
				{
					unit = "medic_M4",
					freq = 0.2,
					amount_min = 0,
					amount_max = 1,
					tactics = self._tactics.shield_support_charge,
					rank = 2
				}
			}
		}
	elseif difficulty_index == 6 then
		self.enemy_spawn_groups.tac_shield_wall_ranged = {
			amount = {4, 5},
			spawn = {
				{
					unit = "FBI_swat_M4",
					freq = 2,
					amount_min = 2,
					amount_max = 2,
					tactics = self._tactics.shield_support_ranged,
					rank = 2
				},
				{
					unit = "FBI_shield",
					freq = 2,
					amount_min = 2,
					amount_max = 2,
					tactics = self._tactics.shield_wall_ranged,
					rank = 3
				},
				{
					unit = "medic_M4",
					freq = 0.35,
					amount_min = 0,
					amount_max = 1,
					tactics = self._tactics.shield_support_charge,
					rank = 2
				}
			}
		}
	elseif difficulty_index == 7 then
		self.enemy_spawn_groups.tac_shield_wall_ranged = {
			amount = {4, 5},
			spawn = {
				{
					unit = "FBI_heavy_G36",
					freq = 2,
					amount_min = 2,
					amount_max = 2,
					tactics = self._tactics.shield_support_ranged,
					rank = 2
				},
				{
					unit = "FBI_shield",
					freq = 2,
					amount_min = 2,
					amount_max = 2,
					tactics = self._tactics.shield_wall_ranged,
					rank = 3
				},
				{
					unit = "medic_M4",
					freq = 0.35,
					amount_min = 0,
					amount_max = 1,
					tactics = self._tactics.shield_support_charge,
					rank = 2
				}
			}
		}
	else
		self.enemy_spawn_groups.tac_shield_wall_ranged = {
			amount = {4, 5},
			spawn = {
				{
					unit = "FBI_heavy_G36",
					freq = 2,
					amount_min = 2,
					amount_max = 2,
					tactics = self._tactics.shield_support_ranged,
					rank = 2
				},
				{
					unit = "FBI_shield",
					freq = 2,
					amount_min = 2,
					amount_max = 2,
					tactics = self._tactics.shield_wall_ranged,
					rank = 3
				},
				{
					unit = "medic_M4",
					freq = 0.5,
					amount_min = 0,
					amount_max = 1,
					tactics = self._tactics.shield_support_charge,
					rank = 2
				}
			}
		}
	end
	if difficulty_index <= 2 then
		self.enemy_spawn_groups.tac_shield_wall_charge = {
			amount = {4, 4},
			spawn = {
				{
					unit = "CS_swat_R870",
					freq = 1,
					amount_min = 2,
					amount_max = 2,
					tactics = self._tactics.shield_support_charge,
					rank = 2
				},
				{
					unit = "CS_shield",
					freq = 1,
					amount_min = 2,
					amount_max = 2,
					tactics = self._tactics.shield_wall_charge,
					rank = 3
				}
			}
		}
	elseif difficulty_index == 3 then
		self.enemy_spawn_groups.tac_shield_wall_charge = {
			amount = {4, 4},
			spawn = {
				{
					unit = "CS_heavy_R870",
					freq = 1,
					amount_min = 2,
					amount_max = 2,
					tactics = self._tactics.shield_support_charge,
					rank = 2
				},
				{
					unit = "CS_shield",
					freq = 1,
					amount_min = 2,
					amount_max = 2,
					tactics = self._tactics.shield_wall_charge,
					rank = 3
				}
			}
		}
	elseif difficulty_index == 4 then
		self.enemy_spawn_groups.tac_shield_wall_charge = {
			amount = {4, 4},
			spawn = {
				{
					unit = "FBI_swat_R870",
					freq = 1,
					amount_min = 2,
					amount_max = 2,
					tactics = self._tactics.shield_support_charge,
					rank = 2
				},
				{
					unit = "FBI_shield",
					freq = 1,
					amount_min = 2,
					amount_max = 2,
					tactics = self._tactics.shield_wall_charge,
					rank = 3
				}
			}
		}
	elseif difficulty_index == 5 then
		self.enemy_spawn_groups.tac_shield_wall_charge = {
			amount = {4, 5},
			spawn = {
				{
					unit = "FBI_heavy_R870",
					freq = 2,
					amount_min = 2,
					amount_max = 2,
					tactics = self._tactics.shield_support_charge,
					rank = 2
				},
				{
					unit = "FBI_shield",
					freq = 2,
					amount_min = 2,
					amount_max = 2,
					tactics = self._tactics.shield_wall_charge,
					rank = 3
				},
				{
					unit = "medic_R870",
					freq = 0.2,
					amount_min = 0,
					amount_max = 1,
					tactics = self._tactics.shield_support_charge,
					rank = 2
				}
			}
		}
	elseif difficulty_index == 6 then
		self.enemy_spawn_groups.tac_shield_wall_charge = {
			amount = {4, 5},
			spawn = {
				{
					unit = "FBI_swat_R870",
					freq = 2,
					amount_min = 2,
					amount_max = 2,
					tactics = self._tactics.shield_support_charge,
					rank = 2
				},
				{
					unit = "FBI_shield",
					freq = 2,
					amount_min = 2,
					amount_max = 2,
					tactics = self._tactics.shield_wall_charge,
					rank = 3
				},
				{
					unit = "medic_R870",
					freq = 0.35,
					amount_min = 0,
					amount_max = 1,
					tactics = self._tactics.shield_support_charge,
					rank = 2
				}
			}
		}
	elseif difficulty_index == 7 then
		self.enemy_spawn_groups.tac_shield_wall_charge = {
			amount = {4, 5},
			spawn = {
				{
					unit = "FBI_heavy_R870",
					freq = 2,
					amount_min = 2,
					amount_max = 2,
					tactics = self._tactics.shield_support_charge,
					rank = 2
				},
				{
					unit = "FBI_shield",
					freq = 2,
					amount_min = 2,
					amount_max = 2,
					tactics = self._tactics.shield_wall_charge,
					rank = 3
				},
				{
					unit = "medic_R870",
					freq = 0.35,
					amount_min = 0,
					amount_max = 1,
					tactics = self._tactics.shield_support_charge,
					rank = 2
				}
			}
		}
	else
		self.enemy_spawn_groups.tac_shield_wall_charge = {
			amount = {4, 5},
			spawn = {
				{
					unit = "FBI_heavy_R870",
					freq = 2,
					amount_min = 2,
					amount_max = 2,
					tactics = self._tactics.shield_support_charge,
					rank = 2
				},
				{
					unit = "FBI_shield",
					freq = 2,
					amount_min = 2,
					amount_max = 2,
					tactics = self._tactics.shield_wall_charge,
					rank = 3
				},
				{
					unit = "medic_R870",
					freq = 0.5,
					amount_min = 0,
					amount_max = 1,
					tactics = self._tactics.shield_support_charge,
					rank = 2
				}
			}
		}
	end
	if difficulty_index <= 2 then
		self.enemy_spawn_groups.tac_shield_wall = {
			amount = {4, 4},
			spawn = {
				{
					unit = "FBI_shield",
					freq = 1,
					amount_min = 4,
					amount_max = 4,
					tactics = self._tactics.shield_wall,
					rank = 3
				}
			}
		}
	elseif difficulty_index == 3 then
		self.enemy_spawn_groups.tac_shield_wall = {
			amount = {4, 4},
			spawn = {
				{
					unit = "FBI_shield",
					freq = 1,
					amount_min = 4,
					amount_max = 4,
					tactics = self._tactics.shield_wall,
					rank = 3
				}
			}
		}
	elseif difficulty_index == 4 then
		self.enemy_spawn_groups.tac_shield_wall = {
			amount = {4, 4},
			spawn = {
				{
					unit = "FBI_shield",
					freq = 1,
					amount_min = 4,
					amount_max = 4,
					tactics = self._tactics.shield_wall,
					rank = 3
				}
			}
		}
	elseif difficulty_index == 5 then
		self.enemy_spawn_groups.tac_shield_wall = {
			amount = {4, 5},
			spawn = {
				{
					unit = "FBI_shield",
					freq = 4,
					amount_min = 4,
					amount_max = 4,
					tactics = self._tactics.shield_wall,
					rank = 3
				},
				{
					unit = "medic_M4",
					freq = 0.2,
					amount_min = 0,
					amount_max = 1,
					tactics = self._tactics.shield_wall,
					rank = 3
				}
			}
		}
	elseif difficulty_index == 6 then
		self.enemy_spawn_groups.tac_shield_wall = {
			amount = {4, 5},
			spawn = {
				{
					unit = "FBI_shield",
					freq = 4,
					amount_min = 4,
					amount_max = 4,
					tactics = self._tactics.shield_wall,
					rank = 3
				},
				{
					unit = "medic_M4",
					freq = 0.35,
					amount_min = 0,
					amount_max = 1,
					tactics = self._tactics.shield_wall,
					rank = 3
				}
			}
		}
	elseif difficulty_index == 7 then
		self.enemy_spawn_groups.tac_shield_wall = {
			amount = {4, 5},
			spawn = {
				{
					unit = "FBI_shield",
					freq = 4,
					amount_min = 4,
					amount_max = 4,
					tactics = self._tactics.shield_wall,
					rank = 3
				},
				{
					unit = "medic_M4",
					freq = 0.35,
					amount_min = 0,
					amount_max = 1,
					tactics = self._tactics.shield_wall,
					rank = 3
				}
			}
		}
	else
		self.enemy_spawn_groups.tac_shield_wall = {
			amount = {4, 5},
			spawn = {
				{
					unit = "FBI_shield",
					freq = 4,
					amount_min = 4,
					amount_max = 4,
					tactics = self._tactics.shield_wall,
					rank = 3
				},
				{
					unit = "medic_M4",
					freq = 0.5,
					amount_min = 0,
					amount_max = 1,
					tactics = self._tactics.shield_wall,
					rank = 3
				}
			}
		}
	end
	if difficulty_index <= 2 then
		self.enemy_spawn_groups.tac_tazer_flanking = {
			amount = {1, 1},
			spawn = {
				{
					unit = "CS_tazer",
					freq = 1,
					amount_min = 1,
					amount_max = 1,
					tactics = self._tactics.tazer_flanking,
					rank = 3
				}
			}
		}
	elseif difficulty_index == 3 then
		self.enemy_spawn_groups.tac_tazer_flanking = {
			amount = {1, 1},
			spawn = {
				{
					unit = "CS_tazer",
					freq = 1,
					amount_min = 1,
					amount_max = 1,
					tactics = self._tactics.tazer_flanking,
					rank = 3
				}
			}
		}
	elseif difficulty_index == 4 then
		self.enemy_spawn_groups.tac_tazer_flanking = {
			amount = {1, 1},
			spawn = {
				{
					unit = "CS_tazer",
					freq = 1,
					amount_min = 1,
					amount_max = 1,
					tactics = self._tactics.tazer_flanking,
					rank = 3
				}
			}
		}
	elseif difficulty_index == 5 then
		self.enemy_spawn_groups.tac_tazer_flanking = {
			amount = {1, 1},
			spawn = {
				{
					unit = "CS_tazer",
					freq = 1,
					amount_min = 1,
					amount_max = 1,
					tactics = self._tactics.tazer_flanking,
					rank = 3
				}
			}
		}
	elseif difficulty_index == 6 then
		self.enemy_spawn_groups.tac_tazer_flanking = {
			amount = {1, 1},
			spawn = {
				{
					unit = "CS_tazer",
					freq = 1,
					amount_min = 1,
					amount_max = 1,
					tactics = self._tactics.tazer_flanking,
					rank = 3
				}
			}
		}
	else
		self.enemy_spawn_groups.tac_tazer_flanking = {
			amount = {2, 2},
			spawn = {
				{
					unit = "CS_tazer",
					freq = 1,
					amount_min = 2,
					amount_max = 2,
					tactics = self._tactics.tazer_flanking,
					rank = 3
				}
			}
		}
	end
	if difficulty_index <= 2 then
		self.enemy_spawn_groups.tac_tazer_charge = {
			amount = {1, 1},
			spawn = {
				{
					unit = "CS_tazer",
					freq = 1,
					amount_min = 1,
					amount_max = 1,
					tactics = self._tactics.tazer_charge,
					rank = 3
				}
			}
		}
	elseif difficulty_index == 3 then
		self.enemy_spawn_groups.tac_tazer_charge = {
			amount = {1, 1},
			spawn = {
				{
					unit = "CS_tazer",
					freq = 1,
					amount_min = 1,
					amount_max = 1,
					tactics = self._tactics.tazer_charge,
					rank = 3
				}
			}
		}
	elseif difficulty_index == 4 then
		self.enemy_spawn_groups.tac_tazer_charge = {
			amount = {1, 1},
			spawn = {
				{
					unit = "CS_tazer",
					freq = 1,
					amount_min = 1,
					amount_max = 1,
					tactics = self._tactics.tazer_charge,
					rank = 3
				}
			}
		}
	elseif difficulty_index == 5 then
		self.enemy_spawn_groups.tac_tazer_charge = {
			amount = {1, 1},
			spawn = {
				{
					unit = "CS_tazer",
					freq = 1,
					amount_min = 1,
					amount_max = 1,
					tactics = self._tactics.tazer_charge,
					rank = 3
				}
			}
		}
	elseif difficulty_index == 6 then
		self.enemy_spawn_groups.tac_tazer_charge = {
			amount = {1, 1},
			spawn = {
				{
					unit = "CS_tazer",
					freq = 1,
					amount_min = 1,
					amount_max = 1,
					tactics = self._tactics.tazer_charge,
					rank = 3
				}
			}
		}
	else
		self.enemy_spawn_groups.tac_tazer_charge = {
			amount = {2, 2},
			spawn = {
				{
					unit = "CS_tazer",
					freq = 1,
					amount_min = 2,
					amount_max = 2,
					tactics = self._tactics.tazer_charge,
					rank = 3
				}
			}
		}
	end
	if difficulty_index <= 2 then
		self.enemy_spawn_groups.tac_bull_rush = {
			amount = {1, 1},
			spawn = {
				{
					unit = "FBI_tank",
					freq = 1,
					amount_min = 1,
					amount_max = 1,
					tactics = self._tactics.tank_rush,
					rank = 3
				}
			}
		}
	elseif difficulty_index == 3 then
		self.enemy_spawn_groups.tac_bull_rush = {
			amount = {1, 1},
			spawn = {
				{
					unit = "FBI_tank",
					freq = 1,
					amount_min = 1,
					amount_max = 1,
					tactics = self._tactics.tank_rush,
					rank = 3
				}
			}
		}
	elseif difficulty_index == 4 then
		self.enemy_spawn_groups.tac_bull_rush = {
			amount = {1, 1},
			spawn = {
				{
					unit = "FBI_tank",
					freq = 1,
					amount_min = 1,
					amount_max = 1,
					tactics = self._tactics.tank_rush,
					rank = 3
				}
			}
		}
	elseif difficulty_index == 5 then
		self.enemy_spawn_groups.tac_bull_rush = {
			amount = {1, 1},
			spawn = {
				{
					unit = "FBI_tank",
					freq = 1,
					amount_min = 1,
					amount_max = 1,
					tactics = self._tactics.tank_rush,
					rank = 3
				}
			}
		}
	elseif difficulty_index == 6 then
		self.enemy_spawn_groups.tac_bull_rush = {
			amount = {1, 1},
			spawn = {
				{
					unit = "FBI_tank",
					freq = 1,
					amount_min = 1,
					amount_max = 1,
					tactics = self._tactics.tank_rush,
					rank = 3
				}
			}
		}
	else
		self.enemy_spawn_groups.tac_bull_rush = {
			amount = {2, 2},
			spawn = {
				{
					unit = "FBI_tank",
					freq = 1,
					amount_min = 2,
					amount_max = 2,
					tactics = self._tactics.tank_rush,
					rank = 3
				}
			}
		}
	end
	self.enemy_spawn_groups.Phalanx = {
		amount = {
			self.phalanx.minions.amount + 1,
			self.phalanx.minions.amount + 1
		},
		spawn = {
			{
				unit = "Phalanx_vip",
				freq = 1,
				amount_min = 1,
				amount_max = 1,
				tactics = self._tactics.Phalanx_vip,
				rank = 2
			},
			{
				unit = "Phalanx_minion",
				freq = 1,
				amount_min = 1,
				tactics = self._tactics.Phalanx_minion,
				rank = 1
			}
		}
	}
	self.enemy_spawn_groups.single_spooc = {
		amount = {1, 1},
		spawn = {
			{
				unit = "spooc",
				freq = 1,
				amount_min = 1,
				tactics = self._tactics.spooc,
				rank = 1
			}
		}
	}
	self.enemy_spawn_groups.FBI_spoocs = self.enemy_spawn_groups.single_spooc
end
function GroupAITweakData:_init_task_data(difficulty_index, difficulty)
	local is_console = SystemInfo:platform() ~= Idstring("WIN32")
	self.max_nr_simultaneous_boss_types = 0
	self.difficulty_curve_points = {0.5}
	if difficulty_index < 6 then
		self.smoke_and_flash_grenade_timeout = {10, 20}
	else
		self.smoke_and_flash_grenade_timeout = {15, 20}
	end
	if difficulty_index < 6 then
		self.smoke_grenade_lifetime = 7.5
	else
		self.smoke_grenade_lifetime = 12
	end
	self.flash_grenade_lifetime = 7.5
	self.flash_grenade = {
		timer = 3,
		range = 1000,
		light_color = Vector3(255, 0, 0),
		light_range = 300,
		light_specular = 1,
		beep_speed = {0.1, 0.025},
		beep_fade_speed = 4,
		beep_multi = 0.3
	}
	if difficulty_index < 6 then
		self.flash_grenade.timer = 3
	else
		self.flash_grenade.timer = 2
	end
	self.optimal_trade_distance = {0, 0}
	self.bain_assault_praise_limits = {1, 3}
	if difficulty_index <= 2 then
		self.besiege.recurring_group_SO = {
			recurring_cloaker_spawn = {
				interval = {180, 300},
				retire_delay = 30
			},
			recurring_spawn_1 = {
				interval = {30, 60}
			}
		}
	elseif difficulty_index == 3 then
		self.besiege.recurring_group_SO = {
			recurring_cloaker_spawn = {
				interval = {60, 120},
				retire_delay = 30
			},
			recurring_spawn_1 = {
				interval = {30, 60}
			}
		}
	elseif difficulty_index == 4 then
		self.besiege.recurring_group_SO = {
			recurring_cloaker_spawn = {
				interval = {45, 60},
				retire_delay = 30
			},
			recurring_spawn_1 = {
				interval = {30, 60}
			}
		}
	elseif difficulty_index == 5 then
		self.besiege.recurring_group_SO = {
			recurring_cloaker_spawn = {
				interval = {20, 40},
				retire_delay = 30
			},
			recurring_spawn_1 = {
				interval = {30, 60}
			}
		}
	else
		self.besiege.recurring_group_SO = {
			recurring_cloaker_spawn = {
				interval = {20, 40},
				retire_delay = 30
			},
			recurring_spawn_1 = {
				interval = {30, 60}
			}
		}
	end
	self.besiege.regroup.duration = {
		15,
		15,
		15
	}
	self.besiege.assault = {}
	self.besiege.assault.anticipation_duration = {
		{30, 1},
		{30, 1},
		{45, 0.5}
	}
	self.besiege.assault.build_duration = 35
	self.besiege.assault.sustain_duration_min = {
		240,
		240,
		240
	}
	self.besiege.assault.sustain_duration_max = {
		240,
		240,
		240
	}
	self.besiege.assault.sustain_duration_balance_mul = {
		1,
		1,
		1,
		1
	}
	self.besiege.assault.fade_duration = 5
	if difficulty_index <= 2 then
		self.besiege.assault.delay = {
			30,
			35,
			30
		}
	elseif difficulty_index == 3 then
		self.besiege.assault.delay = {
			30,
			30,
			30
		}
	elseif difficulty_index == 4 then
		self.besiege.assault.delay = {
			30,
			30,
			30
		}
	elseif difficulty_index == 5 then
		self.besiege.assault.delay = {
			30,
			30,
			30
		}
	else
		self.besiege.assault.delay = {
			30,
			30,
			30
		}
	end
	if difficulty_index <= 5 then
		self.besiege.assault.hostage_hesitation_delay = {
			30,
			30,
			30
		}
	else
		self.besiege.assault.hostage_hesitation_delay = {
			10,
			10,
			10
		}
	end
	if is_console then
		self.besiege.assault.force = {
			10000,
			10000,
			10000
		}
		self.besiege.assault.force_pool = {
			10000,
			10000,
			10000
		}
	else
		self.besiege.assault.force = {
			10000,
			10000,
			10000
		}
		self.besiege.assault.force_pool = {
			10000,
			10000,
			10000
		}
	end
	if is_console then
		if difficulty_index <= 2 then
			self.besiege.assault.force_balance_mul = {
				1,
				1,
				1,
				1
			}
			self.besiege.assault.force_pool_balance_mul = {
				1,
				1,
				1,
				1
			}
		elseif difficulty_index == 3 then
			self.besiege.assault.force_balance_mul = {
				1,
				1,
				1,
				1
			}
			self.besiege.assault.force_pool_balance_mul = {
				1,
				1,
				1,
				1
			}
		elseif difficulty_index == 4 then
			self.besiege.assault.force_balance_mul = {
				1,
				1,
				1,
				1
			}
			self.besiege.assault.force_pool_balance_mul = {
				1,
				1,
				1,
				1
			}
		elseif difficulty_index == 5 then
			self.besiege.assault.force_balance_mul = {
				1,
				1,
				1,
				1
			}
			self.besiege.assault.force_pool_balance_mul = {
				1,
				1,
				1,
				1
			}
		else
			self.besiege.assault.force_balance_mul = {
				1,
				1,
				1,
				1
			}
			self.besiege.assault.force_pool_balance_mul = {
				1,
				1,
				1,
				1
			}
		end
	elseif difficulty_index <= 2 then
		self.besiege.assault.force_balance_mul = {
			1,
			1,
			1,
			1
		}
		self.besiege.assault.force_pool_balance_mul = {
			1,
			1,
			1,
			1
		}
	elseif difficulty_index == 3 then
		self.besiege.assault.force_balance_mul = {
			1,
			1,
			1,
			1
		}
		self.besiege.assault.force_pool_balance_mul = {
			1,
			1,
			1,
			1
		}
	elseif difficulty_index == 4 then
		self.besiege.assault.force_balance_mul = {
			1,
			1,
			1,
			1
		}
		self.besiege.assault.force_pool_balance_mul = {
			1,
			1,
			1,
			1
		}
	elseif difficulty_index == 5 then
		self.besiege.assault.force_balance_mul = {
			1,
			1,
			1,
			1
		}
		self.besiege.assault.force_pool_balance_mul = {
			1,
			1,
			1,
			1
		}
	elseif difficulty_index == 6 then
		self.besiege.assault.force_balance_mul = {
			1,
			1,
			1,
			1
		}
		self.besiege.assault.force_pool_balance_mul = {
			1,
			1,
			1,
			1
		}
	elseif difficulty_index == 7 then
		self.besiege.assault.force_balance_mul = {
			1,
			1,
			1,
			1
		}
		self.besiege.assault.force_pool_balance_mul = {
			1,
			1,
			1,
			1
		}
	else
		self.besiege.assault.force_balance_mul = {
			1,
			1,
			1,
			1
		}
		self.besiege.assault.force_pool_balance_mul = {
			1,
			1,
			1,
			1
		}
	end
	if difficulty_index <= 2 then
		self.besiege.assault.groups = {
			tac_swat_shotgun_rush = {
				0.26,
				0.26,
				0.26
			},
			tac_swat_shotgun_flank = {
				0.26,
				0.26,
				0.26
			},
			tac_swat_rifle = {
				0.26,
				0.26,
				0.26
			},
			tac_swat_rifle_flank = {
				0.26,
				0.26,
				0.26
			},
			tac_shield_wall_ranged = {
				0.06,
				0.06,
				0.06
			},
			tac_shield_wall_charge = {
				0.05,
				0.05,
				0.05
			},
			tac_shield_wall = {
				0.05,
				0.05,
				0.05
			},
			tac_tazer_flanking = {
				0.09,
				0.09,
				0.09
			},
			tac_tazer_charge = {
				0.09,
				0.09,
				0.09
			},
			FBI_spoocs = {
				0.09,
				0.09,
				0.09
			},
			tac_bull_rush = {
				0.09,
				0.09,
				0.09
			}
		}
	elseif difficulty_index == 3 then
		self.besiege.assault.groups = {
			tac_swat_shotgun_rush = {
				0.26,
				0.26,
				0.26
			},
			tac_swat_shotgun_flank = {
				0.26,
				0.26,
				0.26
			},
			tac_swat_rifle = {
				0.26,
				0.26,
				0.26
			},
			tac_swat_rifle_flank = {
				0.26,
				0.26,
				0.26
			},
			tac_shield_wall_ranged = {
				0.06,
				0.06,
				0.06
			},
			tac_shield_wall_charge = {
				0.05,
				0.05,
				0.05
			},
			tac_shield_wall = {
				0.05,
				0.05,
				0.05
			},
			tac_tazer_flanking = {
				0.09,
				0.09,
				0.09
			},
			tac_tazer_charge = {
				0.09,
				0.09,
				0.09
			},
			FBI_spoocs = {
				0.09,
				0.09,
				0.09
			},
			tac_bull_rush = {
				0.09,
				0.09,
				0.09
			}
		}
	elseif difficulty_index == 4 then
		self.besiege.assault.groups = {
			tac_swat_shotgun_rush = {
				0.26,
				0.26,
				0.26
			},
			tac_swat_shotgun_flank = {
				0.26,
				0.26,
				0.26
			},
			tac_swat_rifle = {
				0.26,
				0.26,
				0.26
			},
			tac_swat_rifle_flank = {
				0.26,
				0.26,
				0.26
			},
			tac_shield_wall_ranged = {
				0.06,
				0.06,
				0.06
			},
			tac_shield_wall_charge = {
				0.05,
				0.05,
				0.05
			},
			tac_shield_wall = {
				0.05,
				0.05,
				0.05
			},
			tac_tazer_flanking = {
				0.09,
				0.09,
				0.09
			},
			tac_tazer_charge = {
				0.09,
				0.09,
				0.09
			},
			FBI_spoocs = {
				0.09,
				0.09,
				0.09
			},
			tac_bull_rush = {
				0.09,
				0.09,
				0.09
			}
		}
	elseif difficulty_index == 5 then
		self.besiege.assault.groups = {
			tac_swat_shotgun_rush = {
				0.26,
				0.26,
				0.26
			},
			tac_swat_shotgun_flank = {
				0.26,
				0.26,
				0.26
			},
			tac_swat_rifle = {
				0.26,
				0.26,
				0.26
			},
			tac_swat_rifle_flank = {
				0.26,
				0.26,
				0.26
			},
			tac_shield_wall_ranged = {
				0.06,
				0.06,
				0.06
			},
			tac_shield_wall_charge = {
				0.05,
				0.05,
				0.05
			},
			tac_shield_wall = {
				0.05,
				0.05,
				0.05
			},
			tac_tazer_flanking = {
				0.09,
				0.09,
				0.09
			},
			tac_tazer_charge = {
				0.09,
				0.09,
				0.09
			},
			FBI_spoocs = {
				0.09,
				0.09,
				0.09
			},
			tac_bull_rush = {
				0.09,
				0.09,
				0.09
			}
		}
	elseif difficulty_index == 6 then
		self.besiege.assault.groups = {
			tac_swat_shotgun_rush = {
				0.26,
				0.26,
				0.26
			},
			tac_swat_shotgun_flank = {
				0.26,
				0.26,
				0.26
			},
			tac_swat_rifle = {
				0.26,
				0.26,
				0.26
			},
			tac_swat_rifle_flank = {
				0.26,
				0.26,
				0.26
			},
			tac_shield_wall_ranged = {
				0.06,
				0.06,
				0.06
			},
			tac_shield_wall_charge = {
				0.05,
				0.05,
				0.05
			},
			tac_shield_wall = {
				0.05,
				0.05,
				0.05
			},
			tac_tazer_flanking = {
				0.09,
				0.09,
				0.09
			},
			tac_tazer_charge = {
				0.09,
				0.09,
				0.09
			},
			FBI_spoocs = {
				0.09,
				0.09,
				0.09
			},
			tac_bull_rush = {
				0.09,
				0.09,
				0.09
			}
		}
	elseif difficulty_index == 7 then
		self.besiege.assault.groups = {
			tac_swat_shotgun_rush = {
				0.26,
				0.26,
				0.26
			},
			tac_swat_shotgun_flank = {
				0.26,
				0.26,
				0.26
			},
			tac_swat_rifle = {
				0.26,
				0.26,
				0.26
			},
			tac_swat_rifle_flank = {
				0.26,
				0.26,
				0.26
			},
			tac_shield_wall_ranged = {
				0.06,
				0.06,
				0.06
			},
			tac_shield_wall_charge = {
				0.05,
				0.05,
				0.05
			},
			tac_shield_wall = {
				0.05,
				0.05,
				0.05
			},
			tac_tazer_flanking = {
				0.09,
				0.09,
				0.09
			},
			tac_tazer_charge = {
				0.09,
				0.09,
				0.09
			},
			FBI_spoocs = {
				0.09,
				0.09,
				0.09
			},
			tac_bull_rush = {
				0.09,
				0.09,
				0.09
			}
		}
	elseif difficulty_index == 8 then
		self.besiege.assault.groups = {
			tac_swat_shotgun_rush = {
				0.26,
				0.26,
				0.26
			},
			tac_swat_shotgun_flank = {
				0.26,
				0.26,
				0.26
			},
			tac_swat_rifle = {
				0.26,
				0.26,
				0.26
			},
			tac_swat_rifle_flank = {
				0.26,
				0.26,
				0.26
			},
			tac_shield_wall_ranged = {
				0.06,
				0.06,
				0.06
			},
			tac_shield_wall_charge = {
				0.05,
				0.05,
				0.05
			},
			tac_shield_wall = {
				0.05,
				0.05,
				0.05
			},
			tac_tazer_flanking = {
				0.09,
				0.09,
				0.09
			},
			tac_tazer_charge = {
				0.09,
				0.09,
				0.09
			},
			FBI_spoocs = {
				0.09,
				0.09,
				0.09
			},
			tac_bull_rush = {
				0.09,
				0.09,
				0.09
			}
		}
	else
		self.besiege.assault.groups = {
			tac_swat_shotgun_rush = {
				0.26,
				0.26,
				0.26
			},
			tac_swat_shotgun_flank = {
				0.26,
				0.26,
				0.26
			},
			tac_swat_rifle = {
				0.26,
				0.26,
				0.26
			},
			tac_swat_rifle_flank = {
				0.26,
				0.26,
				0.26
			},
			tac_shield_wall_ranged = {
				0.06,
				0.06,
				0.06
			},
			tac_shield_wall_charge = {
				0.05,
				0.05,
				0.05
			},
			tac_shield_wall = {
				0.05,
				0.05,
				0.05
			},
			tac_tazer_flanking = {
				0.09,
				0.09,
				0.09
			},
			tac_tazer_charge = {
				0.09,
				0.09,
				0.09
			},
			FBI_spoocs = {
				0.09,
				0.09,
				0.09
			},
			tac_bull_rush = {
				0.09,
				0.09,
				0.09
			}
		}
	end
	self.besiege.assault.groups.single_spooc = {
		0,
		0,
		0
	}
	self.besiege.assault.groups.Phalanx = {
		0,
		0,
		0
	}
	self.besiege.reenforce.interval = {
		10,
		20,
		30
	}
	if difficulty_index <= 2 then
		self.besiege.reenforce.groups = {
			tac_swat_shotgun_rush = {
				0.1,
				0.1,
				0.1
			},
			tac_swat_shotgun_flank = {
				0.1,
				0.1,
				0.1
			},
			tac_swat_rifle = {
				0.1,
				0.1,
				0.1
			},
			tac_swat_rifle_flank = {
				0.1,
				0.1,
				0.1
			}
		}
	elseif difficulty_index == 3 then
		self.besiege.reenforce.groups = {
			tac_swat_shotgun_rush = {
				0.1,
				0.1,
				0.1
			},
			tac_swat_shotgun_flank = {
				0.1,
				0.1,
				0.1
			},
			tac_swat_rifle = {
				0.1,
				0.1,
				0.1
			},
			tac_swat_rifle_flank = {
				0.1,
				0.1,
				0.1
			}
		}
	elseif difficulty_index == 4 then
		self.besiege.reenforce.groups = {
			tac_swat_shotgun_rush = {
				0.1,
				0.1,
				0.1
			},
			tac_swat_shotgun_flank = {
				0.1,
				0.1,
				0.1
			},
			tac_swat_rifle = {
				0.1,
				0.1,
				0.1
			},
			tac_swat_rifle_flank = {
				0.1,
				0.1,
				0.1
			}
		}
	elseif difficulty_index == 5 then
		self.besiege.reenforce.groups = {
			tac_swat_shotgun_rush = {
				0.1,
				0.1,
				0.1
			},
			tac_swat_shotgun_flank = {
				0.1,
				0.1,
				0.1
			},
			tac_swat_rifle = {
				0.1,
				0.1,
				0.1
			},
			tac_swat_rifle_flank = {
				0.1,
				0.1,
				0.1
			}
		}
	else
		self.besiege.reenforce.groups = {
			tac_swat_shotgun_rush = {
				0.1,
				0.1,
				0.1
			},
			tac_swat_shotgun_flank = {
				0.1,
				0.1,
				0.1
			},
			tac_swat_rifle = {
				0.1,
				0.1,
				0.1
			},
			tac_swat_rifle_flank = {
				0.1,
				0.1,
				0.1
			}
		}
	end
	self.besiege.recon.interval = {
		5,
		5,
		5
	}
	self.besiege.recon.interval_variation = 40
	if difficulty_index < 6 then
		self.besiege.recon.force = {
			100,
			100,
			100
		}
	else
		self.besiege.recon.force = {
			100,
			100,
			100
		}
	end
	if difficulty_index <= 2 then
		self.besiege.recon.groups = {
			tac_swat_shotgun_rush = {
				0.1,
				0.1,
				0.1
			},
			tac_swat_shotgun_flank = {
				0.1,
				0.1,
				0.1
			},
			tac_swat_rifle = {
				0.1,
				0.1,
				0.1
			},
			tac_swat_rifle_flank = {
				0.1,
				0.1,
				0.1
			}
		}
	elseif difficulty_index == 3 then
		self.besiege.recon.groups = {
			tac_swat_shotgun_rush = {
				0.1,
				0.1,
				0.1
			},
			tac_swat_shotgun_flank = {
				0.1,
				0.1,
				0.1
			},
			tac_swat_rifle = {
				0.1,
				0.1,
				0.1
			},
			tac_swat_rifle_flank = {
				0.1,
				0.1,
				0.1
			}
		}
	elseif difficulty_index == 4 then
		self.besiege.recon.groups = {
			tac_swat_shotgun_rush = {
				0.1,
				0.1,
				0.1
			},
			tac_swat_shotgun_flank = {
				0.1,
				0.1,
				0.1
			},
			tac_swat_rifle = {
				0.1,
				0.1,
				0.1
			},
			tac_swat_rifle_flank = {
				0.1,
				0.1,
				0.1
			}
		}
	elseif difficulty_index == 5 then
		self.besiege.recon.groups = {
			tac_swat_shotgun_rush = {
				0.1,
				0.1,
				0.1
			},
			tac_swat_shotgun_flank = {
				0.1,
				0.1,
				0.1
			},
			tac_swat_rifle = {
				0.1,
				0.1,
				0.1
			},
			tac_swat_rifle_flank = {
				0.1,
				0.1,
				0.1
			}
		}
	else
		self.besiege.recon.groups = {
			tac_swat_shotgun_rush = {
				0.1,
				0.1,
				0.1
			},
			tac_swat_shotgun_flank = {
				0.1,
				0.1,
				0.1
			},
			tac_swat_rifle = {
				0.1,
				0.1,
				0.1
			},
			tac_swat_rifle_flank = {
				0.1,
				0.1,
				0.1
			}
		}
	end
	self.besiege.recon.groups.single_spooc = {
		0,
		0,
		0
	}
	self.besiege.recon.groups.Phalanx = {
		0,
		0,
		0
	}
	self.besiege.cloaker.groups = {
		single_spooc = {
			1,
			1,
			1
		}
	}
	self.street = deep_clone(self.besiege)
	self.phalanx.minions.min_count = 0
	self.phalanx.minions.amount = 15
	self.phalanx.minions.distance = 80
	self.phalanx.vip.health_ratio_flee = 0.2
	self.phalanx.vip.damage_reduction = {
		start = 0.5,
		increase = 0,
		max = 0.5,
		increase_intervall = 0
	}
	self.phalanx.check_spawn_intervall = 210
	self.phalanx.chance_increase_intervall = 0
	if difficulty_index == 4 then
		self.phalanx.spawn_chance = {
			start = 0.05,
			increase = 0.5,
			decrease = 0,
			max = 1,
			respawn_delay = 420
		}
	elseif difficulty_index == 5 then
		self.phalanx.spawn_chance = {
			start = 0.05,
			increase = 0.5,
			decrease = 0,
			max = 1,
			respawn_delay = 600
		}
	elseif difficulty_index == 6 then
		self.phalanx.spawn_chance = {
			start = 0.05,
			increase = 0.5,
			decrease = 0,
			max = 1,
			respawn_delay = 420
		}
	elseif difficulty_index == 7 then
		self.phalanx.spawn_chance = {
			start = 0.05,
			increase = 0.5,
			decrease = 0,
			max = 1,
			respawn_delay = 420
		}
	elseif difficulty_index == 8 then
		self.phalanx.spawn_chance = {
			start = 0.05,
			increase = 0.5,
			decrease = 0,
			max = 1,
			respawn_delay = 420
		}
	else
		self.phalanx.spawn_chance = {
			start = 0.05,
			increase = 0.5,
			decrease = 0,
			max = 1,
			respawn_delay = 420
		}
	end
	self.safehouse = deep_clone(self.besiege)
end
function GroupAITweakData:_read_mission_preset(tweak_data)
	if not Global.game_settings then
		return
	end
	local lvl_tweak_data = tweak_data.levels[Global.game_settings.level_id]
	self._mission_preset = lvl_tweak_data.group_ai_preset
end
function GroupAITweakData:_create_table_structure()
	self.enemy_spawn_groups = {}
	self.besiege = {
		regroup = {},
		assault = {
			force = {}
		},
		reenforce = {},
		recon = {},
		rescue = {},
		cloaker = {}
	}
	self.safehouse = {
		regroup = {},
		assault = {
			force = {}
		},
		reenforce = {},
		recon = {},
		rescue = {},
		cloaker = {}
	}
	self.phalanx = {
		minions = {},
		vip = {},
		spawn_chance = {}
	}
	self.street = {
		blockade = {
			force = {}
		},
		assault = {
			force = {}
		},
		regroup = {},
		capture = {
			force = {}
		}
	}
end
