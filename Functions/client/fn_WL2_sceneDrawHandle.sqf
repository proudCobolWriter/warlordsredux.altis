addMissionEventHandler ["Draw3D", {
	if !(isNull (missionNamespace getVariable format ["BIS_WL_currentTarget_%1", BIS_WL_playerSide])) then {
		drawIcon3D [
			BIS_WL_currentTargetData # 0,
			BIS_WL_currentTargetData # 1,
			BIS_WL_currentTargetData # 2,
			1,
			1,
			0,
			"",
			0,
			0,
			"RobotoCondensedBold",
			"center",
			TRUE
		];
		_dist = (getPosVisual player) distance (missionNamespace getVariable format ["BIS_WL_currentTarget_%1", BIS_WL_playerSide]);
		_units = "m";
		_dist = ceil _dist;
		if (_dist > 1000) then {_dist = _dist / 100; _dist = round _dist; _dist = _dist / 10; _units = "km"};
		drawIcon3D [
			"",
			[1, 1, 1, 0.5],
			BIS_WL_currentTargetData # 2,
			0,
			0.75,
			0,
			format ["%1%2 %3", _dist, if (_dist % 1 == 0 && _units == "km") then {".0"} else {""}, if (_units == "m") then {BIS_WL_localized_m} else {BIS_WL_localized_km}],
			2,
			0.03,
			"RobotoCondensedBold"
		];
	};
	{
		drawIcon3D [
			"A3\ui_f\data\igui\cfg\islandmap\iconplayer_ca.paa",
			[1, 1, 1, 1],
			if (vehicle _x == _x) then {
				(_x modelToWorldVisual (_x selectionPosition "head")) vectorAdd [0,0,0.6];
			} else {
				getPosATLVisual _x
			},
			0,
			0,
			0,
			name _x,
			2,
			0.03,
			"RobotoCondensedBold",
			"center"
		];
	} forEach ((BIS_WL_allWarlords) select {alive _x && {player distance _x < 100 && {_x != player} && {side group _x == side group player}}});
	{
		drawIcon3D [
			"\A3\ui_f\data\map\groupicons\selector_selectable_ca.paa",
			[1, 1, 1, 0.5],
			(getPosATLVisual _x) vectorAdd [0,0,1],
			1,
			1,
			0,
			_x getVariable ["BIS_WL_iconText", ""],
			2,
			0.03,
			"RobotoCondensedBold",
			"center",
			FALSE
		];
	} forEach BIS_WL_recentlyPurchasedAssets;
}];