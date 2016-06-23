local text_original = LocalizationManager.text
local testAllStrings = false

function LocalizationManager:text(string_id, ...)
return string_id == "menu_difficulty_normal" and "Newbie"
or string_id == "menu_difficulty_hard" and "Casual"
or string_id == "menu_difficulty_very_hard" and "Heister"
or string_id == "menu_difficulty_overkill" and "Point Break"
or string_id == "menu_difficulty_apocalypse" and "Hardcore"
or string_id == "menu_risk_pd" and "Newbie NO RISK REWARD."
or string_id == "menu_risk_swat" and "Casual INCREASED XP AND CASH."
or string_id == "menu_risk_fbi" and "Heister GREATLY INCREASED XP AND CASH."
or string_id == "menu_risk_special" and "Point Break MASSIVELY INCREASED XP AND CASH."
or string_id == "menu_risk_elite" and "Hardcore TREMENDOUSLY INCREASED XP AND CASH."

or testAllStrings == true and string_id
or text_original(self, string_id, ...)
end
