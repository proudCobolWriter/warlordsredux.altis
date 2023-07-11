#include "..\warlords_constants.inc"

params ["_asset"];

createDialog ["rearmMenu", true];
assetGlbl = _asset;

MRTM_fnc_getHulls = {
	params ["_asset"];
	{
		_lb = lbAdd [1500, _x];
		lbSetData [1500, _lb, str ([_x, (_asset animationPhase _x)])];
		lbSetCurSel [1500, _lb];
	} forEach ((animationNames _asset) select {["showslat", _x, false] call BIS_fnc_inString});	
};

MRTM_fnc_getCamos = {
	params ["_asset"];
	{
		_lb = lbAdd [1501, _x];
		lbSetData [1501, _lb, str ([_x, (_asset animationPhase _x)])];
		lbSetCurSel [1501, _lb];
	} forEach ((animationNames _asset) select {["showcamonet", _x, false] call BIS_fnc_inString});
};

MRTM_fnc_getLiverys = {
	params ["_asset"];
	//lbAdd [1502, _x];
};

MRTM_fnc_getExtras = {
	params ["_asset"];
	{
		_lb = lbAdd [1503, _x];
		lbSetData [1503, _lb, str ([_x, (_asset animationPhase _x)])];
		lbSetCurSel [1503, _lb];
	} forEach ((animationNames _asset) select {(["showbag", _x, false] call BIS_fnc_inString) || (["Tools", _x, false] call BIS_fnc_inString)});
};

MRTM_fnc_rearm = {
	params ["_asset"];
	{
		private _turret = _x;
		private _mags = (_asset getVariable "BIS_WL_defaultMagazines") # _forEachIndex;
		{											
			_asset removeMagazineTurret [_x, _turret];
			[_asset, 1] remoteExec ["setVehicleAmmoDef", 0];
		} forEach _mags;
	} forEach allTurrets _asset;
	playSound3D ["A3\Sounds_F\sfx\UI\vehicles\Vehicle_Rearm.wss", _asset, false, getPosASL _asset, 2, 1, 75];
	[toUpper localize "STR_A3_WL_popup_asset_rearmed"] spawn BIS_fnc_WL2_smoothText;
	((findDisplay 1000) displayCtrl 1500) ctrlRemoveAllEventHandlers "LBSelChanged";
	((findDisplay 1000) displayCtrl 1501) ctrlRemoveAllEventHandlers "LBSelChanged";
	((findDisplay 1000) displayCtrl 1503) ctrlRemoveAllEventHandlers "LBSelChanged";
};

MRTM_fnc_animate = {
	params ["_asset", "_animation", "_state", "_lbCurSel", "_idc"];
	_asset animate [_animation, _state, true];
	lbSetData [_idc, _lbCurSel, str ([_animation, (_asset animationPhase _animation)])];
};

_asset call MRTM_fnc_getCamos;
_asset call MRTM_fnc_getHulls;
_asset call MRTM_fnc_getExtras;

((findDisplay 1000) displayCtrl 1501) ctrlAddEventHandler ["LBSelChanged", {
	params ["_control", "_lbCurSel", "_lbSelection"];
	_asset = assetGlbl;
	_anim = ((parseSimpleArray (lbData [1501, _lbCurSel])) # 0);
	_animPhase = ((parseSimpleArray (lbData [1501, _lbCurSel])) # 1);
	_state = 1;
	if (_animPhase == 1) then {
		_state = 0;
	};
	if (_animPhase == 0) then {
		_state = 1;
	};
	[_asset, _anim, _state, _lbCurSel, 1501] spawn MRTM_fnc_animate;
}];

((findDisplay 1000) displayCtrl 1500) ctrlAddEventHandler ["LBSelChanged", {
	params ["_control", "_lbCurSel", "_lbSelection"];
	_asset = assetGlbl;
	_anim = ((parseSimpleArray (lbData [1500, _lbCurSel])) # 0);
	_animPhase = ((parseSimpleArray (lbData [1500, _lbCurSel])) # 1);
	_state = 1;
	if (_animPhase == 1) then {
		_state = 0;
	};
	if (_animPhase == 0) then {
		_state = 1;
	};
	[_asset, _anim, _state, _lbCurSel, 1500] spawn MRTM_fnc_animate;
}];

((findDisplay 1000) displayCtrl 1503) ctrlAddEventHandler ["LBSelChanged", {
	params ["_control", "_lbCurSel", "_lbSelection"];
	_asset = assetGlbl;
	_anim = ((parseSimpleArray (lbData [1503, _lbCurSel])) # 0);
	_animPhase = ((parseSimpleArray (lbData [1503, _lbCurSel])) # 1);
	_state = 1;
	if (_animPhase == 1) then {
		_state = 0;
	};
	if (_animPhase == 0) then {
		_state = 1;
	};
	[_asset, _anim, _state, _lbCurSel, 1503] spawn MRTM_fnc_animate;
}];

((findDisplay 1000) displayCtrl 1) ctrlAddEventHandler ["buttonClick", {
	params ["_control"];
	_asset = assetGlbl;
	_asset spawn MRTM_fnc_rearm;
}];