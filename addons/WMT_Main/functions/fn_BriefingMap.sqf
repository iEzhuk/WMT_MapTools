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

["itemAdd", ["wmtbriefingmap", {
    //открыта карта и у игрока нет карты в инвентаре
    if (!(captive player) && visibleMap && {!("ItemMap" in assignedItems player)} && {!("ItemGPS" in assignedItems player)} && {!("ItemMapFake_WMT" in assignedItems player)}) then {
        if (vehicle player == player) then {
            //человек не в технике
            _people = nearestObjects [player, ["Man"], 5];
            scopeName "loop1";
            {
                if (side _x == (side player) && {"ItemMap" in assignedItems _x || "ItemGPS" in assignedItems _x}) then {
                    wmt_mapadded = true;
                    [] spawn {waituntil{!visibleMap || (captive player) || !(alive player)}; player unlinkItem "ItemMapFake_WMT"; wmt_mapadded = false; hint "";};
                    wmt_mapsource = ["man",_x];
                    closeDialog 1; //закроем диалог чтобы карту не открывали с открытым инвентарем
                    player linkItem "ItemMapFake_WMT";
                    hint format [localize "STR_WMT_MapFromAlly", name _x];
                    breakOut "loop1";
                };
            } foreach _people;
        } else {
            //человек в технике
            _hasgps = getNumber ( configFile >> "CfgVehicles" >> typeOf(vehicle player) >> "enableGPS");
            if (_hasgps > 0) then {
                wmt_mapadded = true;
                player linkItem "ItemMapFake_WMT";
                wmt_mapsource = ["veh",vehicle player];
                closeDialog 1;
                [] spawn {waituntil{!visibleMap || (captive player) || !(alive player)}; player unlinkItem "itemMap"; wmt_mapadded = false; hint "";};
                hint localize "STR_WMT_MapFromVehicle";
            } else {
                scopeName "loopcrew";
                {
                    if ("ItemMap" in assignedItems _x) then {
                        wmt_mapadded = true;
                        wmt_mapsource = ["veh",vehicle player];
                        closeDialog 1;
                        player linkItem "ItemMapFake_WMT";
                        0 spawn {waituntil{!visibleMap || (captive player) || !(alive player)};player unlinkItem "ItemMapFake_WMT"; wmt_mapadded = false; hint "";};
                        hint localize "STR_WMT_MapFromVehicleCrew";
                        breakOut "loopcrew";
                    };
                } foreach (crew vehicle player);
            };
        };
    };

    if (visibleMap && wmt_mapadded) then {
        _source = missionNamespace getVariable ["wmt_mapsource", ["man", player]];
        if ((_source select 0) == "man") then {
            if ((_source select 1) distance player > 5) then {
                player unlinkItem "ItemMapFake_WMT";
                wmt_mapadded = false;
                hint format [localize "STR_WMT_MapFromAllyEnd", name (_source select 1)];
            };
        };
    };
    if (!visibleMap and ("ItemMapFake_WMT" in assignedItems player)) then {
        player unlinkItem "ItemMapFake_WMT";
        player removeItems "ItemMapFake_WMT";
    };
}, 50, "frames", {time > 0.5},{!alive player}]] call BIS_fnc_loop;


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
