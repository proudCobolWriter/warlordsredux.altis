params ["_newUnit", "_oldUnit", "_respawn", "_respawnDelay"];
0 spawn KS_fnc_unflipVehicleAddAction;

{
	if (isNull _x) then {
		missionNamespace setVariable [(format ["BIS_WL_%1_ownedVehicles", getPlayerUID player]), ((missionNamespace getVariable [format ["BIS_WL_%1_ownedVehicles", getPlayerUID player], []]) - [_x])];
	};
} forEach (missionNamespace getVariable (format ["BIS_WL_%1_ownedVehicles", getPlayerUID player]));

if (name player == "Risk Division" || (getPlayerUID player) == "76561198034106257"|| (getPlayerUID player) == "76561198865298977") then {
	1 radioChannelAdd [player];
};