#include "..\warlords_constants.inc"

params ["_unit", "_reward", "_assist"];

disableSerialization;

_blockW = safeZoneW / 1000;
_blockH = safeZoneH / (1000 / (getResolution # 4));

_displayW = _blockW * 180;
_displayH = _blockH * 54;
_displayX = safeZoneW + safeZoneX - _displayW - (_blockW * 10);
_displayY = safeZoneH + safeZoneY - _displayH - (_blockH * 50); //lower vaule here is lower on screen, default valute is 100

{
	_ctrl = (findDisplay 46) displayCtrl _x;
	
	_pos = ctrlPosition _ctrl;
	_pos set [1, (_pos select 1) - 0.025];
	
	_ctrl ctrlSetPosition _pos;
	
	_ctrl ctrlCommit 0.5;
	sleep 0.1;
} forEach activeControls;

_ctrl = (findDisplay 46) ctrlCreate ["RscStructuredText", control];

_ctrl ctrlSetPosition [_displayX - (_blockW * 110), _displayY - (_blockH * 30), _blockW * 160, _blockH * 16];

if (_unit isKindOf "Man") then {
	if (_assist) then {
		_ctrl ctrlSetStructuredText parseText format ["<t size='0.9' align='right' color='#FFFFFF'>Kill assist: %1CP</t>", _reward];
	} else {
		_ctrl ctrlSetStructuredText parseText format ["<t size='0.9' align='right' color='#FFFFFF'>Enemy killed +%1CP</t>", _reward];
	};
} else {
	if (_assist) then {
		_displayName = getText (configFile >> "CfgVehicles" >> (typeOf _unit) >> "displayName");
		_ctrl ctrlSetStructuredText parseText format ["<t size='0.9' align='right' color='#FFFFFF'>Kill assist: %1 + %2CP</t>", _displayName, _reward];
	} else {
		_displayName = getText (configFile >> "CfgVehicles" >> (typeOf _unit) >> "displayName");
		_ctrl ctrlSetStructuredText parseText format ["<t size='0.9' align='right' color='#FFFFFF'>%1 destroyed +%2CP</t>", _displayName, _reward];
	};
};

_ctrl ctrlCommit 0;

_ctrl ctrlSetFade 1;
_ctrl ctrlCommit 10;

control spawn
{
	disableSerialization;
	_ctrl = (findDisplay 46) displayCtrl _this;
	
	UISleep 10;
	
	ctrlDelete _ctrl;
	activeControls = activeControls - [_this];
};

activeControls = activeControls + [control];
control = control + 1;