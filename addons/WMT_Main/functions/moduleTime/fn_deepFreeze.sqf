params ["_deepFreezeTime"];
if (!hasInterface || !isMultiplayer || (WMT_pub_frzState >= 3) || _deepFreezeTime == 0 || !isNil "wmt_deepFreezeRunning") exitWith {};
wmt_deepFreezeRunning = true;
player enableSimulation false;
private _before = time;
while {(WMT_pub_frzState < 3) && (time - _before < _deepFreezeTime) && wmt_deepFreezeRunning} do {
	[format ["<t color='#ffa31f' size='1.2'>%1</t><br/><t color='#ff0000' size='1.2'>%2</t>", localize "STR_WMT_DeepFreeze", [0 max (_deepFreezeTime - (time - _before)),"MM:SS"] call BIS_fnc_secondsToString],
		0,0,.5,0,0,"wmtDeepFrzCl" call BIS_fnc_rscLayer] spawn bis_fnc_dynamicText;
	sleep 0.5;
};
["",0,0,0,0,0,"wmtDeepFrzCl" call BIS_fnc_rscLayer] spawn bis_fnc_dynamicText;
player enableSimulation true;
wmt_deepFreezeRunning = false;

