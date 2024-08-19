local BCS = BCS;

local LOCALE = {
	SPELL_FULL_CRIT_COLON = "Full Crit Chance:",
	
	-- Returned
	PLAYERSTAT_RETURNED = "Returned",
	RETURNED_AS_HEAL = "Self healing",
	-- Return damage dealt as self heal
	["Equip: (%d)%% of damage dealt is returned as healing."] = "Equip: (%d)%% of damage dealt is returned as healing.",
	
	["RETURNED_AS_HEAL_TOOLTIP"] = [[|cffffffffSelf healing (%d%%)|r
	Result of damage dealt is returned as healing.]],
};

local function initLocale()
	if (not BCS or not BCS.L) then
		return;
	end

	for k, v in pairs(LOCALE) do
		BCS.L[k] = v;	
	end
end

initLocale();