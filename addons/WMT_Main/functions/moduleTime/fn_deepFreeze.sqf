params ["_deepFreezeTime"];
if (isNil "wmt_deepFreezeRunning") then {wmt_deepFreezeRunning = true;};
if (!hasInterface || !isMultiplayer ||(WMT_pub_frzState >= 3) || !wmt_deepFreezeRunning || WMT_pub_deepFrzTimeLeft <= 0) exitWith {wmt_deepFreezeRunning = false;};
player enableSimulation false;
while {(WMT_pub_frzState < 3) && wmt_deepFreezeRunning && WMT_pub_deepFrzTimeLeft > 0} do {
	[format ["<t color='#ffa31f' size='1.2'>%1</t><br/><t color='#ff0000' size='1.2'>%2</t>", localize "STR_WMT_DeepFreeze", [0 max (WMT_pub_deepFrzTimeLeft),"MM:SS"] call BIS_fnc_secondsToString],
		0,0,.5,0,0,"wmtDeepFrzCl" call BIS_fnc_rscLayer] spawn bis_fnc_dynamicText;
	sleep 0.5;
	WMT_pub_deepFrzTimeLeft = WMT_pub_deepFrzTimeLeft - 0.5;
};
["",0,0,0,0,0,"wmtDeepFrzCl" call BIS_fnc_rscLayer] spawn bis_fnc_dynamicText;
player enableSimulation true;
wmt_deepFreezeRunning = false;

