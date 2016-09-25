_playersKilled = missionNamespace getVariable ["WMT_UIDKilledList", []];
_uid = getPlayerUID player;

if(_uid in _playersKilled) then {
	diag_log "WMT. Rejoined after being killed";
	titleText["Rejoined after being killed", "PLAIN"];
	// not to desturb players
	player setPos [-10000, -10000];
	// ask server to delete bot when we leave mission
	pDeleteJIP = player;
	publicVariableServer "pDeleteJIP"; 
	// leave mission
	["epicFail", false] call BIS_fnc_endMission;
};