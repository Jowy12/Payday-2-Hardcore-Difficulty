local text_original = LocalizationManager.text
local testAllStrings = false

function LocalizationManager:text(string_id, ...)
return string_id == "menu_difficulty_apocalypse" and "Hardcore"

or testAllStrings == true and string_id
or text_original(self, string_id, ...)
end
