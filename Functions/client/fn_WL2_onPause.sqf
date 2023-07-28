#include "..\warlords_constants.inc"

params ["_display"];

if (isMultiplayer) then {
	if !(isServer) then {
		(_display displayCtrl 1010) ctrlAddEventHandler ["ButtonClick", {
			0 spawn {
				sleep WL_TIMEOUT_SHORT;
				(findDisplay 49 displayCtrl 235106) ctrlAddEventHandler ["ButtonClick", {(findDisplay 49) closeDisplay 1; [player, "kill", clientOwner] remoteExec ["BIS_fnc_WL2_handleClientRequest", 2];}];
			};
		}];
	};
};