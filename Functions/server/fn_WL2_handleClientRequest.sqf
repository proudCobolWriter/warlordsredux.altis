#include "..\warlords_constants.inc"

params ["_sender", "_action", "_cost", "_pos", "_target", "_isStatic"];

_playerFunds = ((serverNamespace getVariable "fundsDatabase") getOrDefault [(getPlayerUID _sender), 0]);

if !(isNull _sender) then {
	switch (_action) do {
		case "kill" : {
			if ((owner _sender) == _cost) then {
				_sender setDamage 1;
			};
		};
		case "repair" : {
			if ((!isNil {_cost}) && {_cost <= serverTime}) then {
				_target setDamage _pos;
			};
		};
		case "scan" : {
			_hasFunds = (_playerFunds >= _cost);
			if (_hasFunds) then {
				private _uid = getPlayerUID _sender;
				[_uid, -_cost] call BIS_fnc_WL2_fundsDatabaseWrite;

				_target setVariable [format ["BIS_WL_lastScanEnd_%1", side _sender], serverTime + WL_SCAN_DURATION, TRUE];
				_revealTrigger = createTrigger ["EmptyDetector", position _target];
				_revealTrigger setTriggerArea (_target getVariable "objectArea");
				_revealTrigger setTriggerActivation ["ANY", "PRESENT", FALSE];
				_target setVariable ["BIS_WL_revealTrigger", _revealTrigger, TRUE];
				[_target, _revealTrigger] spawn {
					params ["_sector", "_revealTrigger"];
					while {!isNull _revealTrigger} do {
						_eligibleSides = BIS_WL_competingSides select {(_sector getVariable [format ["BIS_WL_lastScanEnd_%1", _x], -9999]) > serverTime};
						_eligibleWarlords = BIS_WL_allWarlords select {local _x && (side group _x) in _eligibleSides};
						{
							_toReveal = _x;
							{
								_x reveal [_toReveal, 4];
							} forEach _eligibleWarlords;
						} forEach list _revealTrigger;
						sleep WL_TIMEOUT_STANDARD;
					};
				};
				[_target, side group _sender] remoteExec ["BIS_fnc_WL2_sectorScanHandle", [0, -2] select isDedicated];
				waitUntil {sleep WL_TIMEOUT_SHORT; BIS_WL_competingSides findIf {(_target getVariable [format ["BIS_WL_lastScanEnd_%1", _x], -9999]) > serverTime} == -1};
				deleteVehicle _revealTrigger;
				_target setVariable ["BIS_WL_revealTrigger", nil, TRUE];
			};
		};
		case "targetReset": {
			_hasFunds = (_playerFunds >= _cost);
			if (_hasFunds) then {
				private _uid = getPlayerUID _sender;
				[_uid, -_cost] call BIS_fnc_WL2_fundsDatabaseWrite;

				missionNamespace setVariable [format ["BIS_WL_targetResetVotingSince_%1", side _sender], serverTime, true];
				missionNamespace setVariable [format ["BIS_WL_targetResetOrderedBy_%1", side _sender], name _sender, true];
				_sender setVariable ["BIS_WL_targetResetVote", 1, [2, remoteExecutedOwner]];

				[side _sender] spawn BIS_fnc_WL2_targetResetHandleServer;
				[side _sender] remoteExec ["BIS_fnc_WL2_targetResetHandleVote", [0, -2] select isDedicated];
			};
		};
		case "lastLoadout": {
			_hasFunds = (_playerFunds >= _cost);
			if (_hasFunds) then {
				private _uid = getPlayerUID _sender;
				[_uid, -_cost] call BIS_fnc_WL2_fundsDatabaseWrite;

				0 remoteExecCall ["BIS_fnc_WL2_orderLastLoadout", remoteExecutedOwner];
			};
		};
		case "savedLoadout": {
			_hasFunds = (_playerFunds >= _cost);
			if (_hasFunds) then {
				private _uid = getPlayerUID _sender;
				[_uid, -_cost] call BIS_fnc_WL2_fundsDatabaseWrite;

				["apply"] remoteExecCall ["BIS_fnc_WL2_orderSavedLoadout", remoteExecutedOwner];
			};
		};
		case "orderFTVehicle": {
			_hasFunds = (_playerFunds >= _cost);
			if (_hasFunds) then {
				private _uid = getPlayerUID _sender;
				[_uid, -_cost] call BIS_fnc_WL2_fundsDatabaseWrite;

				if (_target == west) then {
					if ((count ((entities "B_Truck_01_medical_F") select {alive _x})) == 0) then {
						_asset = createVehicle ["B_Truck_01_medical_F", _sender, [], 0, "NONE"];
						[_sender, _asset] remoteExec ["BIS_fnc_WL2_newAssetHandle", remoteExecutedOwner];
					};
				} else {
					if ((count ((entities "O_Truck_03_medical_F") select {alive _x})) == 0) then {
						_asset = createVehicle ["O_Truck_03_medical_F", _sender, [], 0, "NONE"];
						[_sender, _asset] remoteExec ["BIS_fnc_WL2_newAssetHandle", remoteExecutedOwner];
					};
				};
			};
		};
		case "orderFTPod": {
			_hasFunds = (_playerFunds >= _cost);
			if (_hasFunds) then {
				private _uid = getPlayerUID _sender;
				[_uid, -_cost] call BIS_fnc_WL2_fundsDatabaseWrite;

				if (_target == west) then {
					if ((count (entities "B_Slingload_01_Medevac_F")) == 0) then {
						_asset = createVehicle ["B_Slingload_01_Medevac_F", _sender, [], 0, "NONE"];
						[_sender, _asset] remoteExec ["BIS_fnc_WL2_newAssetHandle", remoteExecutedOwner];
					};
				} else {
					if ((count (entities "Land_Pod_Heli_Transport_04_medevac_F")) == 0) then {
						_asset = createVehicle ["Land_Pod_Heli_Transport_04_medevac_F", _sender, [], 0, "NONE"];
						[_sender, _asset] remoteExec ["BIS_fnc_WL2_newAssetHandle", remoteExecutedOwner];
					};
				};
			};
		};
		case "fastTravelContested": {
			_hasFunds = (_playerFunds >= _cost);
			if (_hasFunds) then {
				private _uid = getPlayerUID _sender;
				[_uid, -_cost] call BIS_fnc_WL2_fundsDatabaseWrite;

				_sender setVehiclePosition [_pos, [], 2, "NONE"];
			};
		};
		case "fastTravel": {
			_sender setVehiclePosition [_pos, [], 3, "NONE"];
		};
		case "orderArsenal": {
			_hasFunds = (_playerFunds >= _cost);
			if (_hasFunds) then {
				private _uid = getPlayerUID _sender;
				[_uid, -_cost] call BIS_fnc_WL2_fundsDatabaseWrite;	

				0 remoteExecCall ["BIS_fnc_WL2_orderArsenal", (owner _sender)];			
			};
		};
		case "orderAI" : {
			private _uid = getPlayerUID _sender;
			[_uid, -_cost] call BIS_fnc_WL2_fundsDatabaseWrite;		
		};
		case "orderAsset": {
			_hasFunds = (_playerFunds >= _cost);
			if (_hasFunds) then {
				private _uid = getPlayerUID _sender;
				[_uid, -_cost] call BIS_fnc_WL2_fundsDatabaseWrite;

				private _class = _target;
				private _asset = objNull;
				
				_targetPos = _pos;
				if (_class isKindOf "Ship") then {
					_asset = createVehicle [_class, (_pos vectorAdd [0,0,3]), [], 0, "CAN_COLLIDE"];
					_asset setVariable ["BIS_WL_delete", (serverTime + 600), 2];
				} else {
					if (_class isKindOf "Air") then {
						if (_class == "B_UAV_02_dynamicLoadout_F" || _class == "B_T_UAV_03_dynamicLoadout_F" || _class == "B_UAV_05_F" || _class == "O_UAV_02_dynamicLoadout_F" || _class == "O_T_UAV_04_CAS_F") then {
							if (isNil {((_targetPos nearObjects ["Logic", 10]) select {count (_x getVariable ["BIS_WL_runwaySpawnPosArr", []]) > 0}) # 0}) then {
								_sector = (((BIS_WL_allSectors) select {((_x distance _targetPos) < 15)}) # 0);
								_array = (_sector call BIS_fnc_WL2_findSpawnPositions);
								_pos1 = (_array # (_array findIf {(((abs ([_x, 0] call BIS_fnc_terrainGradAngle)) < 5) && ((abs ([_x, 90] call BIS_fnc_terrainGradAngle)) < 5))}));
								_posFinal = _pos1 findEmptyPosition [0, 20, _class];
								_asset = createVehicle [_class, _posFinal, [], 0, "NONE"];
								_asset setDir (direction _sender);
							} else {
								private _sector = ((_targetPos nearObjects ["Logic", 10]) select {count (_x getVariable ["BIS_WL_runwaySpawnPosArr", []]) > 0}) # 0;
								private _taxiNodes = _sector getVariable "BIS_WL_runwaySpawnPosArr";
								private _taxiNodesCnt = count _taxiNodes;
								private _spawnPos = [];
								private _dir = 0;
								private _checks = 0;
								while {count _spawnPos == 0 && _checks < 100} do {
									_checks = _checks + 1;
									private _i = (floor random _taxiNodesCnt) max 1;
									private _pointB = _taxiNodes # _i;
									private _pointA = _taxiNodes # (_i - 1);
									_dir = _pointA getDir _pointB;
									private _pos = [_pointA, random (_pointA distance2D _pointB), _dir] call BIS_fnc_relPos;
									if (count (_pos nearObjects ["AllVehicles", 20]) == 0) then {
										_spawnPos = _pos;
									};
								};

								_asset = createVehicle [_class, _spawnPos, [], 0, "NONE"];
								_asset setDir _dir;
							};

							createVehicleCrew _asset;
							(group effectiveCommander _asset) deleteGroupWhenEmpty true;
						} else {
							_isPlane = (toLower getText (configFile >> "CfgVehicles" >> _class >> "simulation")) in ["airplanex", "airplane"] && !(_class isKindOf "VTOL_Base_F");
							if (_isPlane) then {
								private _sector = ((_targetPos nearObjects ["Logic", 10]) select {count (_x getVariable ["BIS_WL_runwaySpawnPosArr", []]) > 0}) # 0;
								private _taxiNodes = _sector getVariable "BIS_WL_runwaySpawnPosArr";
								private _taxiNodesCnt = count _taxiNodes;
								private _spawnPos = [];
								private _dir = 0;
								private _checks = 0;
								while {count _spawnPos == 0 && _checks < 100} do {
									_checks = _checks + 1;
									private _i = (floor random _taxiNodesCnt) max 1;
									private _pointB = _taxiNodes # _i;
									private _pointA = _taxiNodes # (_i - 1);
									_dir = _pointA getDir _pointB;
									private _pos = [_pointA, random (_pointA distance2D _pointB), _dir] call BIS_fnc_relPos;
									if (count (_pos nearObjects ["AllVehicles", 20]) == 0) then {
										_spawnPos = _pos;
									};
								};

								_asset = createVehicle [_class, _spawnPos, [], 0, "NONE"];
								_asset setDir _dir;
							} else {
								if (_class == "B_UAV_01_F" || _class == "O_UAV_01_F") then {
									_asset = createVehicle [_class, _pos, [], 0, "CAN_COLLIDE"];
									createVehicleCrew _asset;
									(group _asset) deleteGroupWhenEmpty true;
								} else {
									if (isNil {((_targetPos nearObjects ["Logic", 10]) select {count (_x getVariable ["BIS_WL_runwaySpawnPosArr", []]) > 0}) # 0}) then {
										_sector = (((BIS_WL_allSectors) select {((_x distance _targetPos) < 15)}) # 0);
										_array = (_sector call BIS_fnc_WL2_findSpawnPositions);
										_pos1 = (_array # (_array findIf {(((abs ([_x, 0] call BIS_fnc_terrainGradAngle)) < 5) && ((abs ([_x, 90] call BIS_fnc_terrainGradAngle)) < 5))}));
										_posFinal = _pos1 findEmptyPosition [0, 20, _class];
										_asset = createVehicle [_class, _posFinal, [], 5, "NONE"];
										_asset setDir 0;
									} else {
										private _sector = ((_targetPos nearObjects ["Logic", 10]) select {count (_x getVariable ["BIS_WL_runwaySpawnPosArr", []]) > 0}) # 0;
										private _taxiNodes = _sector getVariable "BIS_WL_runwaySpawnPosArr";
										private _taxiNodesCnt = count _taxiNodes;
										private _spawnPos = [];
										private _dir = 0;
										private _checks = 0;
										while {count _spawnPos == 0 && _checks < 100} do {
											_checks = _checks + 1;
											private _i = (floor random _taxiNodesCnt) max 1;
											private _pointB = _taxiNodes # _i;
											private _pointA = _taxiNodes # (_i - 1);
											_dir = _pointA getDir _pointB;
											private _pos = [_pointA, random (_pointA distance2D _pointB), _dir] call BIS_fnc_relPos;
											if (count (_pos nearObjects ["AllVehicles", 20]) == 0) then {
												_spawnPos = _pos;
											};
										};

										_asset = createVehicle [_class, _spawnPos, [], 0, "NONE"];
										_asset setDir _dir;
									};
								};
							};
						};
					} else {
						if (_isStatic) then {
							if (getNumber (configFile >> "CfgVehicles" >> _class >> "isUav") == 1) then {
								if (_class == "B_AAA_System_01_F" || {_class == "B_SAM_System_01_F" || {_class == "B_SAM_System_02_F" || {_class == "B_Ship_MRLS_01_F"}}}) then {
									if (side _sender == east) then {
										_asset = [_pos, _class] call BIS_fnc_WL2_createUAVCrew;
									} else {
										_asset = createVehicle [_class, _pos, [], 0, "CAN_COLLIDE"];
										createVehicleCrew _asset;										
									};

									//Livery change
									if (typeOf _asset == "B_AAA_System_01_F") then {
										private _side = side _sender;
										if (_side == east) then {
											_asset setObjectTextureGlobal [0, "A3\static_f_jets\AAA_System_01\data\AAA_system_01_olive_co.paa"];
											_asset setObjectTextureGlobal [1, "A3\static_f_jets\AAA_System_01\data\AAA_system_02_olive_co.paa"];
										};
									} else {
										if (typeOf _asset == "B_SAM_System_01_F") then {
											private _side = side _sender;
											if (_side == east) then {
												_asset setObjectTextureGlobal [0, "A3\static_f_jets\SAM_System_01\data\SAM_system_01_olive_co.paa"];
											};
										} else {
											if (typeOf _asset == "B_SAM_System_02_F") then {
												private _side = side _sender;
												if (_side == east) then {
													_asset setObjectTextureGlobal [0, "A3\static_f_jets\SAM_System_02\data\SAM_system_02_olive_co.paa"];
												};
											};
										};
									};
								} else {
									_asset = createVehicle [_class, _pos, [], 0, "CAN_COLLIDE"];
									createVehicleCrew _asset;
								};

								if (_asset call DIS_fnc_IsSam) then {
									_asset spawn DIS_fnc_RegisterSam;
								};
							} else {
								_asset = createVehicle [_class, _pos, [], 0, "CAN_COLLIDE"];
								_asset enableWeaponDisassembly false;
							};
							_asset setDir (direction _sender);
						} else {
							_asset = createVehicle [_class, _targetPos, [], 0, "CAN_COLLIDE"];
							_asset setDir direction _sender;
							_asset setVariable ["BIS_WL_delete", (serverTime + 600), 2];

							if ((typeOf _asset) in dapsDazzler) then {
								_asset spawn DAPS_fnc_RegisterVehicle;
							};

							//Livery change
							if (typeOf _asset == "I_Truck_02_MRL_F") then {
								_asset setObjectTextureGlobal [0, "a3\soft_f_beta\truck_02\data\truck_02_kab_opfor_co.paa"];
								_asset setObjectTextureGlobal [2, "a3\soft_f_gamma\truck_02\data\truck_02_mrl_opfor_co.paa"];
							};

							if (typeOf _asset == "B_APC_Wheeled_03_cannon_F") then {
								_asset setObjectTextureGlobal [0, "A3\armor_f_gamma\APC_Wheeled_03\Data\apc_wheeled_03_ext_co.paa"];
								_asset setObjectTextureGlobal [1, "A3\armor_f_gamma\APC_Wheeled_03\Data\apc_wheeled_03_ext2_co.paa"];
								_asset setObjectTextureGlobal [2, "A3\armor_f_gamma\APC_Wheeled_03\Data\rcws30_co.paa"];
								_asset setObjectTextureGlobal [3, "A3\armor_f_gamma\APC_Wheeled_03\Data\apc_wheeled_03_ext_alpha_co.paa"];
							};
						};
					};
				};

				if !(typeOf _asset == "B_Truck_01_medical_F" || typeOf _asset == "O_Truck_03_medical_F" || typeOf _asset == "Land_Pod_Heli_Transport_04_medevac_F" || unitIsUAV _asset) then {
					[_asset, 2] remoteExec ["lock", (owner _asset)];
				} else {
					[_asset, 0] remoteExec ["lock", (owner _asset)];
				};
			
				_assetVariable = call BIS_fnc_WL2_generateVariableName;
				_asset setVehicleVarName _assetVariable;
				[_asset, _assetVariable] remoteExec ["setVehicleVarName", remoteExecutedOwner];
				remoteExecutedOwner publicVariableClient _assetVariable;
				[_asset, _sender, _isStatic] call BIS_fnc_WL2_setOwner;
				[_sender, _asset] remoteExec ["BIS_fnc_WL2_newAssetHandle", remoteExecutedOwner];

				waitUntil {sleep 0.01; !(isNull _asset)};
			};
			_sender setVariable ["BIS_WL_isOrdering", false, [2, remoteExecutedOwner]];
		};
		case "fundsTransferBill": {
			private _uid = getPlayerUID _sender;
			[_uid, -2000] call BIS_fnc_WL2_fundsDatabaseWrite;
			
			serverNamespace setVariable [format ["BIS_WL_isTransferring_%1", _uid], true];
		};
		case "fundsTransferCancel": {
			private _uid = getPlayerUID _sender;
			if (serverNamespace getVariable (format ["BIS_WL_isTransferring_%1", _uid])) then {
				[_uid, 2000] call BIS_fnc_WL2_fundsDatabaseWrite;
				serverNamespace setVariable [format ["BIS_WL_isTransferring_%1", _uid], false];
			};
		};
		case "fundsTransfer": {
			if (_playerFunds >= _cost) then {
				_targetUID = getPlayerUID _target;
				_uid = getPlayerUID _sender;
				_recipient = _targetUID call BIS_fnc_getUnitByUID;

				[_targetUID, _cost] call BIS_fnc_WL2_fundsDatabaseWrite;
				[_uid, -_cost] call BIS_fnc_WL2_fundsDatabaseWrite;
				serverNamespace setVariable [format ["BIS_WL_isTransferring_%1", _uid], false];
				{
					[[side _recipient, "Base"], (format [ localize "STR_A3_WL_donate_cp", name _sender, name _recipient, _cost])] remoteExec ["commandChat", (owner _x)];
				} forEach (allPlayers select {side group _x == side group _sender});
			};
		};
	};
};