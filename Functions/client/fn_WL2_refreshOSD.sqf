#include "..\warlords_constants.inc"

params [["_fullRefresh", FALSE]];

call BIS_fnc_WL2_sub_purchaseMenuRefresh;

waitUntil {!isNull (uiNamespace getVariable ["BIS_WL_osd_action_voting_title", controlNull])};

if (uiNamespace getVariable "BIS_WL_cp_saved") then {
	(uiNamespace getVariable "BIS_WL_osd_cp_current") ctrlSetStructuredText parseText format ["<t color='#00dd00' shadow = '2' size = '%2'>%1 CP</t>", ((missionNamespace getVariable "fundsDatabaseClients") get (getPlayerUID player)), 1 call BIS_fnc_WL2_sub_purchaseMenuGetUIScale];
} else {
	(uiNamespace getVariable "BIS_WL_osd_cp_current") ctrlSetStructuredText parseText format ["<t color='#ffffff' shadow = '2' size = '%2'>%1 CP</t>", ((missionNamespace getVariable "fundsDatabaseClients") get (getPlayerUID player)), 1 call BIS_fnc_WL2_sub_purchaseMenuGetUIScale];
};

(uiNamespace getVariable "BIS_WL_osd_income_side_2") ctrlSetStructuredText parseText format ["<t size = '%2' shadow = '2'>%1</t>", (((BIS_WL_matesAvailable - count (units player)) + 1) max 0), 0.65 call BIS_fnc_WL2_sub_purchaseMenuGetUIScale];

if (_fullRefresh) then {
	(uiNamespace getVariable "BIS_WL_osd_sectors_side_1") ctrlSetStructuredText parseText format ["<t size = '%2' align = 'center' shadow = '2'>%1</t>", count (BIS_WL_sectorsArray # 0), 0.6 call BIS_fnc_WL2_sub_purchaseMenuGetUIScale];
	(uiNamespace getVariable "BIS_WL_osd_income_side_1") ctrlSetStructuredText parseText format ["<t size = '%2' shadow = '2'>+%1</t>", BIS_WL_playerSide call BIS_fnc_WL2_income, 0.65 call BIS_fnc_WL2_sub_purchaseMenuGetUIScale];
};

if (BIS_WL_showHint_maintenance) then {
		(uiNamespace getVariable "BIS_WL_osd_rearm_possible") ctrlSetStructuredText parseText format ["<t color = '#00ff00' size = '%2' shadow = '2'>%1</t>", localize "STR_A3_WL_OSD_rearm_possible", 0.65 call BIS_fnc_WL2_sub_purchaseMenuGetUIScale];
} else {
		(uiNamespace getVariable "BIS_WL_osd_rearm_possible") ctrlSetStructuredText parseText format ["<t color = '#00ff00' size = '%1' shadow = '2'></t>", 0.65 call BIS_fnc_WL2_sub_purchaseMenuGetUIScale];
};