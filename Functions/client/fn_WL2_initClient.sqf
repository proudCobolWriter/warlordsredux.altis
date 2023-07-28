#include "..\warlords_constants.inc"

["client_init"] call BIS_fnc_startLoadingScreen;

waitUntil {!isNull player && isPlayer player};

"client" call BIS_fnc_WL2_varsInit;


//this whole if statement stops side switching. Line 11 to 56 comment out
private _teamCheckOKVarID = format ["BIS_WL_teamCheckOK_%1", getPlayerUID player];

waitUntil {!isNil {missionNamespace getVariable _teamCheckOKVarID}};

if !(missionNamespace getVariable _teamCheckOKVarID) exitWith {
	addMissionEventHandler ["EachFrame", {
		clearRadio;
		{
			deleteMarkerLocal _x;
		} forEach allMapMarkers;
	}];
	sleep 0.1;
	// This section controls the "you can't switch teams" display
	["client_init"] call BIS_fnc_endLoadingScreen;
	player removeItem "ItemMap";
	player removeItem "ItemRadio";
	[player] joinSilent BIS_WL_wrongTeamGroup;
	enableRadio FALSE;
	enableSentences FALSE;
	0 fadeSpeech 0;
	0 fadeRadio 0;
	{_x enableChannel [FALSE, FALSE]} forEach [0,1,2,3,4,5];
	showCinemaBorder FALSE;
	private _camera = "Camera" camCreate position player;
	_camera camSetPos [0, 0, 10];
	_camera camSetTarget [-1000, -1000, 10];
	_camera camCommit 0;
	_camera cameraEffect ["Internal", "Back"];
	waitUntil {!isNull (findDisplay 46)};
	(findDisplay 46) ctrlCreate ["RscStructuredText", 994001];
	((findDisplay 46) displayCtrl 994001) ctrlSetPosition [safeZoneX, safeZoneY, safeZoneW, safeZoneH];
	((findDisplay 46) displayCtrl 994001) ctrlSetBackgroundColor [0, 0, 0, 0.75];
	((findDisplay 46) displayCtrl 994001) ctrlCommit 0;
	(findDisplay 46) ctrlCreate ["RscStructuredText", 994000];
	((findDisplay 46) displayCtrl 994000) ctrlSetPosition [safeZoneX + 0.1, safeZoneY + (safeZoneH * 0.5), safeZoneW, safeZoneH];
	((findDisplay 46) displayCtrl 994000) ctrlCommit 0;
	((findDisplay 46) displayCtrl 994000) ctrlSetStructuredText parseText format [
		"<t shadow = '0'><t size = '%1' color = '#ff4b4b'>%2</t><br/><t size = '%3'>%4</t></t>",
		(2.5 call BIS_fnc_WL2_sub_purchaseMenuGetUIScale),
		localize "STR_A3_WL_switch_teams",
		(1.5 call BIS_fnc_WL2_sub_purchaseMenuGetUIScale),
		localize "STR_A3_WL_switch_teams_info"
	];
};

//View distance
MRTM_inf = 2000;
MRTM_ground = 3000;
MRTM_air = 4000;
MRTM_drones = 4000;
MRTM_objects = 2000;
MRTM_syncObjects = true;
setTerrainGrid 3.125;

//Radar warning system
MRTM_rwr1 = 0.3;
MRTM_rwr2 = 0.3;
MRTM_rwr3 = 0.2;
MRTM_rwr4 = 0.3;

//Options
player setVariable ["MRTM_3rdPersonDisabled", false, [2, clientOwner]];
MRTM_playKillSound = true;
MRTM_muteVoiceInformer = false;
MRTM_EnableRWR = true;
MRTM_disableHint = true;
MRTM_smallAnnouncerText = false;
has_recieved_reward = false;
player setVariable ["reward_active", false];

if !((side group player) in BIS_WL_competingSides) exitWith {
	["client_init"] call BIS_fnc_endLoadingScreen;
	["Warlords error: Your unit is not a Warlords competitor"] call BIS_fnc_error;
};

uiNamespace setVariable ["BIS_WL_purchaseMenuLastSelection", [0,0,0]];
uiNamespace setVariable ["BIS_WL_cp_saved", FALSE];

private _uidPlayer = getPlayerUID player;
missionNamespace setVariable [format ["BIS_WL_%1_ownedVehicles", _uidPlayer], []];


if !(isServer) then {
	"setup" call BIS_fnc_WL2_handleRespawnMarkers;
};
call BIS_fnc_WL2_sectorsInitClient;

["client", TRUE] call BIS_fnc_WL2_updateSectorArrays;

private _specialStateArray = (BIS_WL_sectorsArray # 6) + (BIS_WL_sectorsArray # 7);
{
	[_x, _x getVariable "BIS_WL_owner", _specialStateArray] call BIS_fnc_WL2_sectorMarkerUpdate;
} forEach BIS_WL_allSectors;

if !(isServer) then {
	BIS_WL_playerSide call BIS_fnc_WL2_parsePurchaseList;
};

0 spawn BIS_fnc_WL2_sectorCaptureStatus;
0 spawn BIS_fnc_WL2_teammatesAvailability;
0 spawn BIS_fnc_WL2_forceGroupIconsFunctionality;
0 spawn BIS_fnc_WL2_mapControlHandle;
0 spawn BIS_fnc_WL2_chatMsg;

BIS_WL_groupIconClickHandler = addMissionEventHandler ["GroupIconClick", BIS_fnc_WL2_groupIconClickHandle];
BIS_WL_groupIconEnterHandler = addMissionEventHandler ["GroupIconOverEnter", BIS_fnc_WL2_groupIconEnterHandle];
BIS_WL_groupIconLeaveHandler = addMissionEventHandler ["GroupIconOverLeave", BIS_fnc_WL2_groupIconLeaveHandle];

_mapBorderMrkr1 = createMarkerLocal ["BIS_WL_mapBorder1", [(BIS_WL_mapSize / 2) + (BIS_WL_mapSize / 2), -(BIS_WL_mapSize / 2)]];
_mapBorderMrkr2 = createMarkerLocal ["BIS_WL_mapBorder2", [BIS_WL_mapSize + (BIS_WL_mapSize / 2), BIS_WL_mapSize + (BIS_WL_mapSize / 2)]];
_mapBorderMrkr3 = createMarkerLocal ["BIS_WL_mapBorder3", [-(BIS_WL_mapSize / 2), BIS_WL_mapSize + (BIS_WL_mapSize / 2)]];
_mapBorderMrkr4 = createMarkerLocal ["BIS_WL_mapBorder4", [-(BIS_WL_mapSize / 2), BIS_WL_mapSize - (BIS_WL_mapSize / 2)]];

{
	_x setMarkerShapeLocal "RECTANGLE";
	_x setMarkerBrushLocal "SolidFull";
	_x setMarkerColorLocal "ColorBlack";
} forEach [_mapBorderMrkr1, _mapBorderMrkr2, _mapBorderMrkr3, _mapBorderMrkr4];

_mapBorderMrkr1 setMarkerSizeLocal [BIS_WL_mapSize + (BIS_WL_mapSize / 2), (BIS_WL_mapSize / 2)];
_mapBorderMrkr2 setMarkerSizeLocal [(BIS_WL_mapSize / 2), BIS_WL_mapSize + (BIS_WL_mapSize / 2)];
_mapBorderMrkr3 setMarkerSizeLocal [BIS_WL_mapSize + (BIS_WL_mapSize / 2), (BIS_WL_mapSize / 2)];
_mapBorderMrkr4 setMarkerSizeLocal [(BIS_WL_mapSize / 2), BIS_WL_mapSize + (BIS_WL_mapSize / 2)];

_mrkrTargetEnemy = createMarkerLocal ["BIS_WL_targetEnemy", position BIS_WL_enemyBase];
_mrkrTargetEnemy setMarkerColorLocal BIS_WL_colorMarkerEnemy;
_mrkrTargetFriendly = createMarkerLocal ["BIS_WL_targetFriendly", position BIS_WL_playerBase];
_mrkrTargetFriendly setMarkerColorLocal BIS_WL_colorMarkerFriendly;

{
	_x setMarkerAlphaLocal 0;
	_x setMarkerSizeLocal [2, 2];
	_x setMarkerTypeLocal "selector_selectedMission";
} forEach [_mrkrTargetEnemy, _mrkrTargetFriendly];

BIS_WL_enemiesCheckTrigger = createTrigger ["EmptyDetector", position player, FALSE];
BIS_WL_enemiesCheckTrigger attachTo [player, [0, 0, 0]];
BIS_WL_enemiesCheckTrigger setTriggerArea [200, 200, 0, FALSE];
BIS_WL_enemiesCheckTrigger setTriggerActivation ["ANYPLAYER", "PRESENT", TRUE];
BIS_WL_enemiesCheckTrigger setTriggerStatements ["{(side group _x) getFriend BIS_WL_playerSide == 0} count thislist > 0", "", ""];

uiNamespace setVariable ["activeControls", []];
uiNamespace setVariable ["control", 50000];

"fundsDatabaseClients" addPublicVariableEventHandler {
	[] spawn BIS_fnc_WL2_refreshOSD;
};

player addEventHandler ["GetInMan", {
	params ["_unit", "_role", "_vehicle", "_turret"];
	detach BIS_WL_enemiesCheckTrigger;
	BIS_WL_enemiesCheckTrigger attachTo [vehicle player, [0, 0, 0]];
	if ((typeOf _vehicle == "B_Plane_Fighter_01_F") || (typeOf _vehicle == "B_Plane_CAS_01_dynamicLoadout_F") || (typeOf _vehicle == "B_Heli_Attack_01_dynamicLoadout_F") || (typeOf _vehicle == "B_T_VTOL_01_armed_F") || (typeOf _vehicle == "B_T_VTOL_01_vehicle_F") || (typeOf _vehicle == "B_T_VTOL_01_infantry_F")) then  {
		[["voiceWarningSystem", "betty"], 0, "", 25, "", false, true, false, true] call BIS_fnc_advHint;
		0 spawn BIS_fnc_WL2_betty;
	};
	if ((typeOf _vehicle == "O_Plane_Fighter_02_F") || (typeOf _vehicle == "O_Plane_CAS_02_dynamicLoadout_F") || (typeOf _vehicle == "O_Heli_Attack_02_dynamicLoadout_F") || (typeOf _vehicle == "O_T_VTOL_02_vehicle_dynamicLoadout_F")) then {
		[["voiceWarningSystem", "rita"], 0, "", 25, "", false, true, false, true] call BIS_fnc_advHint;
		0 spawn BIS_fnc_WL2_rita;
	};
}];

player addEventHandler ["GetOutMan", {
	params ["_unit", "_role", "_vehicle", "_turret"];
	detach BIS_WL_enemiesCheckTrigger;
	BIS_WL_enemiesCheckTrigger attachTo [vehicle player, [0, 0, 0]];
}];

player addEventHandler ["InventoryOpened",{
	params ["_unit","_container"];
	_override = false;
	_allUnitBackpackContainers = (player nearEntities ["Man", 50]) select {isPlayer _x} apply {backpackContainer _x};

	if (_container in _allUnitBackpackContainers) then {
		systemchat "Access denied!";
		_override = true;
	};
	_override;
}];

player addEventHandler ["Killed", {
	BIS_WL_loadoutApplied = FALSE;
	["RequestMenu_close"] call BIS_fnc_WL2_setupUI;
	
	BIS_WL_lastLoadout = +getUnitLoadout player;
	private _varName = format ["BIS_WL_purchasable_%1", BIS_WL_playerSide];
	private _gearArr = (missionNamespace getVariable _varName) # 5;
	private _lastLoadoutArr = _gearArr # 0;
	private _text = _savedLoadoutArr # 5;
	private _text = localize "STR_A3_WL_last_loadout_info";
	_text = _text + "<br/><br/>";
	{
		switch (_forEachIndex) do {
			case 0;
			case 1;
			case 2;
			case 3;
			case 4: {
				if (count _x > 0) then {
					_text = _text + (getText (configFile >> "CfgWeapons" >> _x # 0 >> "displayName")) + "<br/>";
				};
			};
			case 5: {
				if (count _x > 0) then {
					_text = _text + (getText (configFile >> "CfgVehicles" >> _x # 0 >> "displayName")) + "<br/>";
				};
			};
		};
	} forEach BIS_WL_lastLoadout;
	_lastLoadoutArr set [5, _text];
	_gearArr set [0, _lastLoadoutArr];
	(missionNamespace getVariable _varName) set [5, _gearArr];

	_connectedUAV = getConnectedUAV player;
	if (_connectedUAV != objNull) exitWith {
		player connectTerminalToUAV objNull;
	};
}];

player addEventHandler ["HandleDamage", {
	params ["_unit", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint", "_directHit"];
	_base = (([BIS_WL_base1, BIS_WL_base2] select {(_x getVariable "BIS_WL_owner") == (side group _unit)}) # 0);
	if ((_unit inArea (_base getVariable "objectAreaComplete")) && {((_base getVariable ["BIS_WL_baseUnderAttack", false]) == false)}) then {
		0;
	} else {
		_damage;
	};
}];

addMissionEventHandler ["MarkerCreated", {
	params ["_marker", "_channelNumber", "_owner", "_local"];
	
	if ((isPlayer _owner) && (_channelNumber == 0)) then {
		deleteMarker _marker;
	};
}];

call BIS_fnc_WL2_sub_arsenalSetup;

0 spawn {
	waitUntil {uiSleep WL_TIMEOUT_SHORT; !isNull WL_CONTROL_MAP};
	WL_CONTROL_MAP ctrlMapAnimAdd [0, 0.35, BIS_WL_playerBase];
	ctrlMapAnimCommit WL_CONTROL_MAP;
};

{_x setMarkerAlphaLocal 0} forEach BIS_WL_sectorLinks;

call BIS_fnc_WL2_refreshCurrentTargetData;
call BIS_fnc_WL2_sceneDrawHandle;
call BIS_fnc_WL2_targetResetHandle;
player call BIS_fnc_WL2_sub_assetAssemblyHandle;
[player, "init"] spawn BIS_fnc_WL2_hintHandle;
0 spawn BIS_fnc_WL2_underWaterCheck;

(format ["BIS_WL_%1_friendlyKillPenaltyEnd", getPlayerUID player]) addPublicVariableEventHandler BIS_fnc_WL2_friendlyFireHandleClient;

["OSD"] spawn BIS_fnc_WL2_setupUI;
0 spawn BIS_fnc_WL2_timer;
0 spawn BIS_fnc_WL2_cpBalance;


0 spawn {
	waitUntil {sleep WL_TIMEOUT_STANDARD; isNull WL_TARGET_FRIENDLY};
	_t = serverTime + 10;
	waitUntil {sleep WL_TIMEOUT_SHORT; serverTime > _t || visibleMap};
	if !(visibleMap) then {
		[toUpper localize "STR_A3_WL_tip_voting", 5] spawn BIS_fnc_WL2_smoothText;
	};
};

0 spawn {
	_selectedCnt = count ((groupSelectedUnits player) - [player]);
	while {!BIS_WL_missionEnd} do {
		waitUntil {sleep 1; count ((groupSelectedUnits player) - [player]) != _selectedCnt};
		_selectedCnt = count ((groupSelectedUnits player) - [player]);
		call BIS_fnc_WL2_sub_purchaseMenuRefresh;
	};
};

0 spawn {
	_t = serverTime + 10;
	waitUntil {sleep WL_TIMEOUT_STANDARD; serverTime > _t && !isNull WL_TARGET_FRIENDLY};
	sleep WL_TIMEOUT_LONG;
	while {!BIS_WL_purchaseMenuDiscovered} do {
		[["Common", "warlordsMenu"], 0, "", 10, "", false, true, false, true] call BIS_fnc_advHint;
		sleep 13;
	};
};

[player, "maintenance", {(player nearObjects ["All", WL_MAINTENANCE_RADIUS]) findIf {(getNumber (configFile >> "CfgVehicles" >> typeOf _x >> "transportRepair") > 0) || (getNumber (configFile >> "CfgVehicles" >> typeOf _x >> "transportAmmo") > 0)} != -1}] call BIS_fnc_WL2_hintHandle;

0 spawn BIS_fnc_WL2_selectedTargetsHandle;
0 spawn BIS_fnc_WL2_targetSelectionHandleClient;
0 spawn BIS_fnc_WL2_purchaseMenuOpeningHandle;
0 spawn BIS_fnc_WL2_assetMapControl;
0 spawn BIS_fnc_WL2_mapIcons;
[] execVM "scripts\GF_Earplugs\GF_Earplugs.sqf";

0 spawn {
	_t = serverTime + 10;
	waitUntil {sleep 0.1; ((serverTime > _t) || !(isNil {Dev_MrThomasM}))};
	if (!(isNil {Dev_MrThomasM})) then {
		0 spawn BIS_fnc_WL2_mrtmAction;
	};
};

0 spawn {
	waituntil {sleep 0.1; !isnull (findDisplay 46)};
	(findDisplay 46) displayAddEventHandler ["KeyDown", {
		params ["_displayorcontrol", "_key", "_shift", "_ctrl", "_alt"];
		private _key1 = actionKeysNames "curatorInterface";
		private _key2 = actionKeysNames "tacticalView";
		private _keyName = (keyName _key);
		private _e = false;
		
		if (_keyName == _key1) then {
			if !((getPlayerUID player) == "76561198034106257"|| (getPlayerUID player) == "76561198865298977") then {
				_e = true;
			};
		};
		if (_keyName == _key2) then {
			_e = true;
		};
		_e;
	}];
};

["client_init"] call BIS_fnc_endLoadingScreen;

"Initialized" call BIS_fnc_WL2_announcer;
[toUpper localize "STR_A3_WL_popup_init"] spawn BIS_fnc_WL2_smoothText;
0 spawn BIS_fnc_WL2_welcome;