/*
    Name: WMT_fnc_startPosition_client

    Author(s):
        Ezhuk
*/
private ["_center", "_hideFromEnemy", "_action"];
params ["_logic", "_units", "_owner", "_markers", "_time", "_markerSide", "_text"];

waitUntil{!isNil {player}};

_friendsSide = ([playerSide] call BIS_fnc_friendlySides) - [civilian];

if(_logic getVariable ["Finished", false]) exitWith {};

// Hide marker for enemy side
_alpha = if (_markerSide in _friendsSide || _markerSide == sideLogic)then{0.7}else{0};
for "_i" from 0 to ((count _markers)-1) do {
    (_markers select _i) setMarkerAlphaLocal _alpha;
};

if (_owner!="") then {
    if (str(player) == _owner) then {

        wmt_fnc_openChooseMap = {
            ["openMap",
                [
                    (_this select 3) select 0, // markers
                    (_this select 3) select 1, // module
                    (_this select 3) select 2, // function
                    (_this select 3) select 3  // text
                ]
            ] call WMT_fnc_chooseMarker_handler;
        };

        sleep 1;
        _action = player addAction [
                                        format ["<t color='#0353f5'>%1</t>", _text],
                                        wmt_fnc_openChooseMap,
                                        [
                                            _markers,
                                            _logic,
                                            {
                                                (_this select 0) setVariable ["IndexPosition", (_this select 1), true];
                                            },
                                            _text
                                        ],
                                        10,
                                        true,
                                        true,
                                        '',
                                        'true'
                                    ];


        //===================================================
        //                  WAIT
        //===================================================
        if (not isNil "WMT_pub_frzState") then {
            waitUntil {sleep 1.4; WMT_pub_frzState >= 3};
        } else {
            waitUntil {sleep 1.4; _logic getVariable ["Finished", false]};
        };


        //===================================================
        //                  CLEAN
        //===================================================
        player removeAction _action;
        if (!isNil {uiNamespace getVariable "WMT_StartPos_Disaplay"}) then {
            closeDialog 0;
        };
    };
};
