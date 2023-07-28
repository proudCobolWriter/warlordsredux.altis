#include "..\warlords_constants.inc"

params ["_sector", "_owner"];

_sector setVariable ["BIS_WL_owner", _owner, true];
[_sector] remoteExec ["BIS_fnc_WL2_sectorOwnershipHandleClient", [0, -2] select isDedicated];

private _previousOwners = _sector getVariable "BIS_WL_previousOwners";

if !(_owner in _previousOwners) then {
	_previousOwners pushBack _owner;
	if (serverTime > 0 && count _previousOwners == 1) then {
		{
			private _uid = getPlayerUID _x;
			[_uid, (_sector getVariable "BIS_WL_value") * WL_SECTOR_CAPTURE_REWARD_MULTIPLIER] call BIS_fnc_WL2_fundsDatabaseWrite;
		} forEach (BIS_WL_allWarlords select {side group _x == _owner});
	};
};

_previousOwners pushBackUnique _owner;
_sector setVariable ["BIS_WL_previousOwners", _previousOwners, true];

_detectionTrgs = (_sector getVariable "BIS_WL_detectionTrgs");

{
	if ((_x getVariable "BIS_WL_handledSide") == _owner) then {
		deleteVehicle _x;
	};
} forEach _detectionTrgs;

if (_detectionTrgs findIf {!isNull _x} == -1) then {_detectionTrgs = []};

if (_sector == (missionNamespace getVariable format ["BIS_WL_currentTarget_%1", _owner])) then {[_owner, objNull] call BIS_fnc_WL2_selectTarget};

["server"] call BIS_fnc_WL2_updateSectorArrays;

private _enemySide = (BIS_WL_competingSides - [_owner]) # 0;
if (isNull (missionNamespace getVariable format ["BIS_WL_currentTarget_%1", _enemySide])) then {
	missionNamespace setVariable [format ["BIS_WL_resetTargetSelection_server_%1", _enemySide], true];
	BIS_WL_resetTargetSelection_client = true;
	{
		(owner _x) publicVariableClient "BIS_WL_resetTargetSelection_client";
	} forEach (BIS_WL_allWarlords select {side group _x == _enemySide});
	if !(isDedicated) then {
		if (BIS_WL_playerSide != _enemySide) then {
			BIS_WL_resetTargetSelection_client = FALSE;
		};
	};
};