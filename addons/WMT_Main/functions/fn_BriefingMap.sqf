/*
    Name:
        WMT_fnc_BriefingMap

    Author(s):
        Zealot

    Description:
        Add map for player in briefing time and remove after start
        Add map while near the player having the map or in vehicle which has gps or map in crew inv.

    Parameters:
        Nothing

    Returns:
        Nothing
*/

if (!hasInterface) exitwith {};

if ( not isnil "WMT_fnc_BriefingMap_Running" ) exitWith {
    diag_log "WMT_fnc_BriefingMap_Running: double initialization";
};
WMT_fnc_BriefingMap_Running = true;

wmt_mapadded = false;

[] spawn {
    waituntil {not isNull player};
    while {time < 0.1} do {
        uisleep 0.5;
        if (!("ItemMap" in assignedItems player) && (!wmt_mapadded)) then {
            wmt_mapadded = true;
            player linkItem "ItemMapFake_WMT";
        };
    };
    if (wmt_mapadded) then {
        player unlinkItem "ItemMapFake_WMT";
        wmt_mapadded = false;
    };
};

/*
				if (wmt_mapadded) then {
					private _source = missionNamespace getVariable ["wmt_mapsource", ["man", player]];
					if ((_source select 0) == "man") then {
						if ((_source select 1) distance player > 5) then {
							player unlinkItem "ItemMapFake_WMT";
							wmt_mapadded = false;
							hint format [localize "STR_WMT_MapFromAllyEnd", name (_source select 1)];
						};
					};
				};

*/

0 spawn {
	sleep 0.5;
	addMissionEventHandler["Map", {
		params ["_mapIsOpened","_mapIsForced"];
		if (_mapIsOpened) then {
			//открыта карта и у игрока нет карты в инвентаре
			if ({!("ItemMap" in assignedItems player)} && {!("ItemGPS" in assignedItems player)}) then {
				if (vehicle player == player) then {
					//человек не в технике
					private _people = nearestObjects [player, ["Man"], 5];
					scopeName "loop1";
					{
						if (alive _x && {side _x == playerSide} && {"ItemMap" in assignedItems _x || "ItemGPS" in assignedItems _x}) then {
							wmt_mapsource = ["man",_x];
							closeDialog 1; //закроем диалог чтобы карту не открывали с открытым инвентарем
							player linkItem "ItemMapFake_WMT";
							hint format [localize "STR_WMT_MapFromAlly", name _x];
							breakOut "loop1";
						};
					} foreach _people;
				} else {
					//человек в технике
					private _hasgps = getNumber ( configFile >> "CfgVehicles" >> typeOf(vehicle player) >> "enableGPS");
					if (_hasgps > 0) then {
						player linkItem "ItemMapFake_WMT";
						wmt_mapsource = ["veh",vehicle player];
						closeDialog 1;
						hint localize "STR_WMT_MapFromVehicle";
					} else {
						scopeName "loopcrew";
						{
							if ("ItemMap" in assignedItems _x) then {
								wmt_mapsource = ["veh",vehicle player];
								closeDialog 1;
								player linkItem "ItemMapFake_WMT";
								hint localize "STR_WMT_MapFromVehicleCrew";
								breakOut "loopcrew";
							};
						} foreach (crew vehicle player);
					};
				};
			};
		} else {
			if ("ItemMapFake_WMT" in assignedItems player) then {
				player unlinkItem "ItemMapFake_WMT";
				wmt_mapsource = nil;
			};
		};
	}];
	

	player addEventHandler ["Take", {
		_unit = _this select 0;
		_item = _this select 2;
		if (_item == "ItemMapFake_WMT") then {
			_unit unassignItem _item;
			_unit removeItems "ItemMapFake_WMT";
		};
	}];

	player addEventHandler ["Respawn", {
		player addEventHandler ["Take", {
			_unit = _this select 0;
			_item = _this select 2;
			if (_item == "ItemMapFake_WMT") then {
				_unit unassignItem _item;
				_unit removeItems "ItemMapFake_WMT";
			};
		}];
	}];
};

