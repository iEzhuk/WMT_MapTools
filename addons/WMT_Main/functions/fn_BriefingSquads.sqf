/*
 	Name: WMT_fnc_BriefingSquads
 	
 	Author(s):
		Ezhuk

 	Description:
		Add list of squads and players to briefing 

	Parameters:
 		Nothing
 	Returns:
		Nothing 
*/

#define PR(x) private ['x']; x

PR(_text) = "";

// Show group of player in top position
PR(_playerGroup) = group player;
PR(_allGroups) = [_playerGroup] + (allgroups - [_playerGroup]);

{
	if (side leader _x == side player and (leader _x) in playableUnits) then {
		PR(_markerName) = format ["WMT_PrepareTime_%1_%2", side _x, groupId _x];

		_text = _text + format ["<font color='#c7861b'><marker name='%2'>%1:</marker></font><br/>", groupID _x, _markerName];
		{
			_text = _text + getText (configFile >> "CfgVehicles" >> format["%1",typeOf _x] >> "Displayname")+ ":  ";
			if(isPlayer _x) then {
				_text = _text  + name _x;
			};
			_text = _text + "<br/>";
		} foreach units _x;
		_text = _text + "<br/>";
	}
} foreach _allGroups;

["diary",localize "STR_WMT_Squads", _text] call WMT_fnc_CreateDiaryRecord;


