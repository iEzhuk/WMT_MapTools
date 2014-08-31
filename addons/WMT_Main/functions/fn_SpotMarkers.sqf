/*
 	Name: WMT_fnc_SpotMarkers
 	
 	Author(s):
		Ezhuk

 	Description:
		Add local markers on vehicles and squads

	Parameters:
 		Nothing
 	Returns:
		ARRAY: Marker pool 
*/

#include "defines.sqf"

PR(_side) = side player;
PR(_markersPool) = [];


// Vehicles
{
	if(!(_x isKindOf "Strategic") && !(_x isKindOf "Thing") && (_x getVariable ["WMT_show",true])) then
	{
		PR(_show) = false;
		if(_x getVariable ["WMT_side",sideLogic] == _side) then {
			_show = true;
		}else{
			PR(_nearestUnit) = nearestObject [_x, "Man"];
			if(!(isNil "_nearestUnit") ) then {
				if(side player in ([side _nearestUnit] call BIS_fnc_friendlySides)) then {
					_show = true;
				};
			};
		};

		if(_show) then {
			PR(_text) = format ["%1", getText (configFile >> "CfgVehicles" >> (typeOf (_x)) >> "displayName") ];
			PR(_markerName) = format ["WMT_PrepareTime_%1_%2",_text,count _markersPool];
			PR(_marker) = [_markerName,getPos _x,_text,"ColorYellow","mil_box",[1, 1],"ICON",0,"Solid"] call WMT_fnc_CreateLocalMarker;

			_markersPool set [count _markersPool, _marker];
		};
	};
}forEach vehicles;

// Squads
while { (isNil "WMT_pub_frzState" and {time < 10}) or {(not isNil "WMT_pub_frzState" and {WMT_pub_frzState <= 2})} } do {
	{
		PR(_leader) = leader _x;
		PR(_pos) = getPos _leader;

		if( (side _leader) in ([_side] call BIS_fnc_friendlySides) and _leader in playableUnits and {(_leader getVariable ["WMT_show",true])}) then {
			PR(_playersGr) = 0;
			{
				if (isPlayer _x) then {_playersGr=_playersGr+1;};
			} foreach units _x;
			PR(_text) = format ["%1 %2:%3", (groupID _x) call wmt_fnc_LongGroupNameToShort, if(isPLayer _leader)then{name _leader}else {""},_playersGr];
			PR(_markerName) = format ["WMT_PrepareTime_%1_%2", side _x, groupId _x];
			if (_markerName in allMapMarkers) then {
				_markerName setMarkerTextLocal _text;
			} else {
				[_markerName,getPos _leader,_text,([side _leader, true] call BIS_fnc_sidecolor),"mil_dot",[1, 1],"ICON",0,"Solid"] call WMT_fnc_CreateLocalMarker;
			};
			_markersPool set [count _markersPool, _markerName];
		};
	}forEach allGroups;
	uiSleep 5.1;
};




sleep 0.1;
{deleteMarkerLocal _x;} foreach _markerPool;





