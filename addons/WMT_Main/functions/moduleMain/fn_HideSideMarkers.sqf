 /*
    Name: WMT_fnc_HideSideMarkers

    Author(s):
        Zealot

    Description:
        Show marker only for some side

    Parameters:
        Nothing

    Returns:
        Nothing
*/
private ["_mrk", "_count", "_markers"];

_count   = (count allMapMarkers) - 1;
_markers = allMapMarkers;

for "_i" from 0 to _count do {
    _mrk = _markers select _i;
    switch true do {
        case ([_mrk,0,8] call BIS_fnc_trimString == "wmt_west_" and (not (playerSide in (([west] call BIS_fnc_friendlySides)        - [civilian])))) : {_mrk setMarkerAlphaLocal 0;};
        case ([_mrk,0,8] call BIS_fnc_trimString == "wmt_east_" and (not (playerSide in (([east] call BIS_fnc_friendlySides)        - [civilian])))) : {_mrk setMarkerAlphaLocal 0;};
        case ([_mrk,0,7] call BIS_fnc_trimString == "wmt_res_"  and (not (playerSide in (([resistance] call BIS_fnc_friendlySides) - [civilian])))) : {_mrk setMarkerAlphaLocal 0;};
        case ([_mrk,0,7] call BIS_fnc_trimString == "wmt_civ_"  and (playerSide != civilian)) : {_mrk setMarkerAlphaLocal 0;};
    };
};
