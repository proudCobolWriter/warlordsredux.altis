params ["_asset"];

private _actionId = _asset addAction [
	"",
	{
		_this params ["_asset", "_caller", "_actionID"];
		_cargoTypes = ['rhs_mags_crate', 'rhs_weapon_crate', 'rhs_gear_crate', 'rhs_spec_weapons_crate', 'rhs_launcher_crate', 'rhs_7ya37_1_single', 'Land_Cargo10_grey_F', 'rhsusf_mags_crate', 'rhsusf_gear_crate', 'rhsusf_launcher_crate', 'rhsusf_spec_weapons_crate', 'rhsusf_weapons_crate'];
		_nearCargo = _asset nearEntities [_cargoTypes, 20];
		{
			_asset setVehicleCargo _x;
		} forEach _nearCargo;
	},
	[],
	5,
	false,
	false,
	"",
	"alive _target && {((group _this) == (_target getVariable ['BIS_WL_ownerAsset', grpNull])) && {((count (_target nearEntities [['rhs_mags_crate', 'rhs_weapon_crate', 'rhs_gear_crate', 'rhs_spec_weapons_crate', 'rhs_launcher_crate', 'rhs_7ya37_1_single', 'Land_Cargo10_grey_F', 'rhsusf_mags_crate', 'rhsusf_gear_crate', 'rhsusf_launcher_crate', 'rhsusf_spec_weapons_crate', 'rhsusf_weapons_crate'], 20])) > 0)}}",
	-98,
	false
];

_asset setUserActionText [_actionId, "Load cargo", format ["<img size='2' image='%1'/>", 'a3\3den\data\cfgwaypoints\load_ca.paa']];