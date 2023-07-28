params ["_asset"];

_asset addAction [
	"Kick players",
	{
		_this params ["_asset", "_caller", "_actionID"];
		{
			moveOut _x;
		} forEach ((crew _asset) select {(_x != player) && {(_x getVariable ['BIS_WL_ownerAsset', grpNull]) != (group player)}});
	},
	[],
	5,
	false,
	true,
	"",
	"(alive _target && {(group _this) == (_target getVariable ['BIS_WL_ownerAsset', grpNull]) && {(count ((crew _target) select {(_x getVariable ['BIS_WL_ownerAsset', grpNull]) != (group _this)}) > 0) && {(!(isAutonomous _target))}}})",
	50,
	true
];