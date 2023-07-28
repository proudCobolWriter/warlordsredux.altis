#include "..\warlords_constants.inc"

params ["_class", "_cost"];

player setVariable ["BIS_WL_isOrdering", true, [2, clientOwner]];

if (_class isKindOf "Man") then {
	_asset = (group player) createUnit [_class, (getPosATL player), [], 2, "NONE"];
	_assetVariable = call BIS_fnc_WL2_generateVariableName;
	_asset setVehicleVarName _assetVariable;
	[_asset, _assetVariable] remoteExec ["setVehicleVarName", 2];
	[player, "orderAI", _cost] remoteExec ["BIS_fnc_WL2_handleClientRequest", 2];
	[player, _asset] spawn BIS_fnc_WL2_newAssetHandle;
	player setVariable ["BIS_WL_isOrdering", false, [2, clientOwner]];
} else {
	BIS_WL_currentSelection = WL_ID_SELECTION_DEPLOYING_DEFENCE;

	_offset = [0, 8, 0];
	_asset = createSimpleObject [_class, (AGLToASL (player modelToWorld _offset)), true];

	_asset setDir direction player;
	_asset lock 2;
	_asset allowDamage false;
	_asset attachTo [player, _offset];
	_h = (position _asset) # 2;
	detach _asset;
	_offset_tweaked = [_offset select 0, _offset select 1, _h];
	_asset attachTo [player, _offset_tweaked];

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
		[player, "orderAsset", _cost, [(_p # 0), (_p # 1), 0], _class, false] remoteExec ["BIS_fnc_WL2_handleClientRequest", 2];
	} else {
		"Canceled" call BIS_fnc_WL2_announcer;
		[toUpper localize "STR_A3_WL_deploy_canceled"] spawn BIS_fnc_WL2_smoothText;
		player setVariable ["BIS_WL_isOrdering", false, [2, clientOwner]];
	};

	if (BIS_WL_currentSelection == WL_ID_SELECTION_DEPLOYING_DEFENCE) then {
		BIS_WL_currentSelection = WL_ID_SELECTION_NONE;
	};
};

sleep 0.1;
showCommandingMenu "";