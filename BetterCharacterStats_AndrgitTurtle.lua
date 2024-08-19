BCS_AndrgitTurtle = BCS_AndrgitTurtle or {};
local BCS = BCS;
local L = BCS.L;

local BetterCharacterAttributesFrame = BetterCharacterAttributesFrame;
local START_NUMBER_CUSTOM_OPTIONS = table.getn(BCS.PLAYERSTAT_DROPDOWN_OPTIONS);

local CUSTOM_PLAYERSTAT_DROPDOWN_OPTIONS = {
	"PLAYERSTAT_RETURNED",
};

local function AddDropdownOptions(options)
	if (not options or type(options) ~= "table") then 
		return;
	end

	for _, v in pairs(options) do
		table.insert(BCS.PLAYERSTAT_DROPDOWN_OPTIONS, v);
	end
end
AddDropdownOptions(CUSTOM_PLAYERSTAT_DROPDOWN_OPTIONS);

function BCS_AndrgitTurtle:UpdateStatTooltip(frame)
	if (not frame) then 
		return;
	end;

	if frame.tooltip then
		frame:SetScript("OnEnter", function()
			GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
			GameTooltip:SetText(this.tooltip);
			if (this.tooltipSubtext) then
				GameTooltip:AddLine(this.tooltipSubtext, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1);
			end
			GameTooltip:Show();
		end);
		frame:SetScript("OnLeave", function()
			GameTooltip:Hide();
		end);
	end
end


function BCS_AndrgitTurtle:SetPlayerStatReturned(statFrames)
	for i = 2, 6 do
		statFrames[i]:Hide();
	end
	
	BCS_AndrgitTurtle:SetReturnSelfHealing(statFrames[1])
	statFrames[1]:Show();
end

function BCS_AndrgitTurtle:SetReturnSelfHealing(statFrame)
	local spellHealing = BCS_AndrgitTurtle:GetReturnSelfHealing();
	local text = getglobal(statFrame:GetName() .. "StatText")
	local label = getglobal(statFrame:GetName() .. "Label")

	label:SetText(L.RETURNED_AS_HEAL)
	text:SetText(format("%.2f%%", spellHealing))

	statFrame.tooltip = format(L.RETURNED_AS_HEAL_TOOLTIP, spellHealing);
	statFrame.tooltipSubtext = nil;
	BCS_AndrgitTurtle:UpdateStatTooltip(statFrame);
end

local UpdatePaperdollStats = BCS.UpdatePaperdollStats;
BCS.UpdatePaperdollStats = function(self, prefix, index)
	local stats = {};
	local nStats = 6;
	
	for i = 1, nStats do
		table.insert(stats, getglobal(prefix..i));
		stats[i]:Show();
	end

	UpdatePaperdollStats(self, prefix, index);

	if (index == "PLAYERSTAT_SPELL_COMBAT") then
		BCS_AndrgitTurtle:SetReturnSelfHealing(stats[6]);
		stats[6]:Show();
	elseif (index == "PLAYERSTAT_RETURNED") then 
		BCS_AndrgitTurtle:SetPlayerStatReturned(stats);
	end
end