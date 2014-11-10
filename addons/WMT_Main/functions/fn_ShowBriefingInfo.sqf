 /*
 	Name:  
 	
 	Author(s):
		Zealot

 	Description:
		 

	Parameters:
 		Nothing
 	Returns:
		Nothing 
*/

 #define PR(x) private ['x']; x

if (not hasInterface) exitWith {};
waitUntil {not isNil "wmt_global_srvBrfData" and not isNull player};

PR(_beginTime) = diag_tickTime;

PR(_squadTxt) = "";
PR(_vehicleTxt) = "";
PR(_enemyVehTxt) = "";
PR(_markersPool) = [];
PR(_friendlySides) = ( [playerSide] call BIS_fnc_friendlySides ) - [civilian];
PR(_enemySides) = ( [playerSide] call BIS_fnc_enemySides ) - [civilian];

private ["_pos","_side","_class","_marker","_vehname","_groupid","_units"];

PR(_friendlyVehs)=[];
PR(_enemyVehs)=[];
PR(_friendlySquads)=[];

PR(_units) = (group player) getVariable ["WMT_BriefingUnitsInfo", []];
if (count _units != 0 ) then {
	_marker = format ["WMT_PrepareTime_%1_%2", playerSide, groupID group player];
	PR(_myTxt) = format ["<font color='#c7861b'><marker name='%2'>%1:</marker></font><br/>", groupID group player, _marker];
	{
		_myTxt = _myTxt + getText (configFile >> "CfgVehicles" >> format["%1",(_x select 0)] >> "Displayname")+ ":  " + (_x select 1);
		_myTxt = _myTxt + "<br/>";
	} foreach _units;
	_myTxt = _myTxt + "<br/>";
	["diary",localize "STR_WMT_MySquad", _myTxt] call WMT_fnc_CreateDiaryRecord;

};

{
	if ( (_x select 0) == "V") then {
		_pos = _x select 1;
		_class = _x select 2;
		_side = _x select 3;
		_vehname = format ["%1", getText (configFile >> "CfgVehicles" >> _class >> "displayName") ];
		
		// если дружественные, то
		if (_side in _friendlySides) then {
			// маркер на технику
			
			_marker = format ["WMT_PrepareTime_%1_%2",_vehname,count _markersPool];
			_marker = [_marker,_pos,_vehname,"ColorYellow","mil_box",[1, 1],"ICON",0,"Solid"] call WMT_fnc_CreateLocalMarker;
			_markersPool pushback _marker;

			_friendlyVehs pushback _vehname;
		};
		if (_side in _enemySides) then {
			_enemyVehs pushback _vehname;
		};

	};
	if ( (_x select 0) == "S") then {
		_pos = _x select 1;
		_groupid = _x select 2;
		_side = _x select 3;
		_playersNum = _x select 4;
		_leadName = _x select 5;
		_units = _x select 6;

		if (_side in _friendlySides) then {
			// показать метку 
			PR(_text) = format ["%1 %2:%3", _groupid call wmt_fnc_LongGroupNameToShort,_leadName,_playersNum];
			_marker = format ["WMT_PrepareTime_%1_%2", _side, _groupid];
			_marker = [_marker,_pos,_text,([_side, true] call BIS_fnc_sidecolor),"mil_dot",[1, 1],"ICON",0,"Solid"] call WMT_fnc_CreateLocalMarker;

			_markersPool pushback _marker;

			_squadTxt = _squadTxt + format ["<font color='#c7861b'><marker name='%2'>%1:</marker></font><br/>", _groupid, _marker];
			{
				_squadTxt = _squadTxt + getText (configFile >> "CfgVehicles" >> format["%1",(_x select 0)] >> "Displayname")+ ":  " + (_x select 1);
				_squadTxt = _squadTxt + "<br/>";
			} foreach _units;
			_squadTxt = _squadTxt + "<br/>";

			_friendlySquads pushback _x;

		};

	};

} foreach wmt_global_srvBrfData;

["diary",localize "STR_WMT_Squads", _squadTxt] call WMT_fnc_CreateDiaryRecord;

if (count _enemyVehs != 0 and getNumber(MissionConfigFile >> "WMT_Param" >> "CampaignBriefingMode") != 1) then {
	_enemyVehs=_enemyVehs call BIS_fnc_consolidateArray;
	{
		_enemyVehTxt = _enemyVehTxt + format ["%1 - <font color='#c7861b'>%2</font>",_x select 0,_x select 1];
		_enemyVehTxt = _enemyVehTxt + "<br/>";

	} foreach _enemyVehs;

	["diary",localize "STR_WMT_EnemyVehicles", _enemyVehTxt] call WMT_fnc_CreateDiaryRecord; 
};

if (count _friendlyVehs != 0 ) then {
	_friendlyVehs=_friendlyVehs call BIS_fnc_consolidateArray;
	{
		_vehicleTxt = _vehicleTxt + format ["%1 - <font color='#c7861b'>%2</font>",_x select 0,_x select 1];
		_vehicleTxt = _vehicleTxt + "<br/>";

	} foreach _friendlyVehs;

	["diary",localize "STR_WMT_Vehicles", _vehicleTxt] call WMT_fnc_CreateDiaryRecord; 
};

waitUntil {time > 0};

if (isNil "WMT_pub_frzState") then {
	waitUntil {time > 300 and (diag_tickTime - _beginTime) > 300};

} else {
	waitUntil {WMT_pub_frzState >= 3};
	sleep 300;
};
{deleteMarkerLocal _x;} foreach _markersPool;