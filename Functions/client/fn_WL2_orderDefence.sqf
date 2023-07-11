#include "..\warlords_constants.inc"

params ["_class", "_cost", "_offset"];

player setVariable ["BIS_WL_isOrdering", true, [2, clientOwner]];
if (count _offset != 3) then {
	_offset = [0, 1.5, 0];
};

BIS_WL_currentSelection = WL_ID_SELECTION_DEPLOYING_DEFENCE;

if (visibleMap) then {
	openMap [false, false];
	titleCut ["", "BLACK IN", 0.5];
};

_asset = createSimpleObject [_class, [0, 0, 0], true];

_asset lock true;
_asset allowDamage false;
_asset enableWeaponDisassembly false;

//_asset setDir direction player;
//_asset attachTo [player, _offset];
//_h = (position _asset) # 2;
//detach _asset;
//_offset_tweaked = [_offset select 0, _offset select 1, _h];
//_asset attachTo [player, _offset_tweaked];

if (!isNil "WTK_defenseHandle") then { removeMissionEventHandler ["EachFrame", WTK_defenseHandle] };

sleep 0.15; // adjustable (there has to be a delay to avoid blowing up everything when vehicle appears)

WTK_defenseHandle = addMissionEventHandler ["EachFrame", {
	_thisArgs params ["_asset", "_offset"];
	_assetPos = player modelToWorld _offset;
	_asset setPosATL [_assetPos select 0, _assetPos select 1, 0];
	_asset setDir direction player;
	_asset setVectorUp surfaceNormal (position _asset);
}, [_asset, _offset]];

[player, "assembly"] call BIS_fnc_WL2_hintHandle;

BIS_WL_spacePressed = false;
BIS_WL_backspacePressed = false;

_deployKeyHandle = (findDisplay 46) displayAddEventHandler ["KeyDown", {
	if (_this # 1 == 57) then {
		if !(BIS_WL_backspacePressed) then {
			BIS_WL_spacePressed = TRUE;
		};
	};
	if (_this # 1 == 14) then {
		if !(BIS_WL_spacePressed) then {
			BIS_WL_backspacePressed = TRUE;
		};
	};
}];

uiNamespace setVariable ["BIS_WL_deployKeyHandle", _deployKeyHandle];

0 spawn {
	waitUntil {
		sleep WL_TIMEOUT_STANDARD;
		BIS_WL_spacePressed ||
		BIS_WL_backspacePressed ||
		vehicle player != player ||
		!alive player ||
		lifeState player == "INCAPACITATED" ||
		triggerActivated BIS_WL_enemiesCheckTrigger ||
		(getPosATL player) select 2 > 1 ||
		(BIS_WL_sectorsArray # 0) findIf {player inArea (_x getVariable "objectAreaComplete")} == -1
	};
	if !(BIS_WL_spacePressed) then {
		BIS_WL_backspacePressed = TRUE;
	};
	if (!isNil "WTK_defenseHandle") then { removeMissionEventHandler ["EachFrame", WTK_defenseHandle] };
};

waitUntil {sleep WL_TIMEOUT_MIN; BIS_WL_spacePressed || BIS_WL_backspacePressed};

(findDisplay 46) displayRemoveEventHandler ["KeyDown", uiNamespace getVariable "BIS_WL_deployKeyHandle"];
uiNamespace setVariable ['BIS_WL_deployKeyHandle', nil];
_offset set [1, _asset distance player];
detach _asset;
_p = getPosATL _asset;
deleteVehicle _asset;

[player, "assembly", false] call BIS_fnc_WL2_hintHandle;

if (BIS_WL_spacePressed) then {
	playSound "assemble_target";
	[player, "orderAsset", _cost, [(_p # 0), (_p # 1), 0], _class, true] remoteExec ["BIS_fnc_WL2_handleClientRequest", 2];
} else {
	"Canceled" call BIS_fnc_WL2_announcer;
	[toUpper localize "STR_A3_WL_deploy_canceled"] spawn BIS_fnc_WL2_smoothText;
	player setVariable ["BIS_WL_isOrdering", false, [2, clientOwner]];
};

if (BIS_WL_currentSelection == WL_ID_SELECTION_DEPLOYING_DEFENCE) then {
	BIS_WL_currentSelection = WL_ID_SELECTION_NONE;
};

sleep 0.1;

showCommandingMenu "";