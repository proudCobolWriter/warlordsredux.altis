params ["_asset"];

_actionID = _asset addAction [
	"",
	{
		_this params ["_asset", "_caller", "_actionID"];
		_asset removeAction _actionID;
		if (locked _asset == 2) then {
			_asset lock 0;
		} else {
			_asset lock 2;
		};
		_asset call BIS_fnc_WL2_sub_vehicleLockAction;
	},
	[],
	-100,
	if ((locked _this) == 2) then {true} else {false},
	false,
	"",
	"alive _target && {(group _this) == (_target getVariable ['BIS_WL_ownerAsset', grpNull])}",
	50,
	true
];

_asset setUserActionText [_actionId, format ["<t color = '%1'>%2</t>", if ((locked _asset) == 2) then {"#4bff58"} else {"#ff4b4b"}, if ((locked _asset) == 2) then {localize "STR_A3_cfgvehicles_miscunlock_f_0"} else {localize "STR_A3_cfgvehicles_misclock_f_0"}], format ["<img size='2' image='%1'/>", if ((locked _asset) == 2) then {'a3\modules_f\data\iconunlock_ca.paa'} else {'a3\modules_f\data\iconlock_ca.paa'}]];

_asset setVariable ["BIS_WL_lockActionID", _actionID];