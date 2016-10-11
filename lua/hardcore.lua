local text_original = LocalizationManager.text
local testAllStrings = false

function LocalizationManager:text(string_id, ...)
return string_id == "menu_difficulty_normal" and "Newbie"
or string_id == "menu_difficulty_hard" and "Casual"
or string_id == "menu_difficulty_very_hard" and "You're Getting There"
or string_id == "menu_difficulty_overkill" and "Heister"
or string_id == "menu_difficulty_easy_wish" and "Skilled Heister"
or string_id == "menu_difficulty_apocalypse" and "Point Break"
or string_id == "menu_difficulty_sm_wish" and "Hardcore"

or testAllStrings == true and string_id
or text_original(self, string_id, ...)
end
