private _deepFreezeTime = (_this select 0);
private _deepFreezeMinPlayers = 120;

if (!hasInterface || !isNil "wmt_flg_noDeepFreeze" || !isMultiplayer || (WMT_pub_frzState >= 3) || _deepFreezeTime == 0) exitWith {};
private _playerCount = {isPlayer _x} count playableUnits;
if (_playerCount < _deepFreezeMinPlayers) exitWith {};
player enableSimulation false;
private _before = time;
while {(WMT_pub_frzState < 3) || (time - _before < _deepFreezeTime)} do {
	[format ["<t color='#ff0000' size='1.2'> %1 </t>",localize "STR_WMT_DeepFreeze"],0,0,.5,0,0,"wmtDeepFrzCl" call BIS_fnc_rscLayer] spawn bis_fnc_dynamicText;
	sleep 0.5;
};
["",0,0,0,0,0,"wmtDeepFrzCl" call BIS_fnc_rscLayer] spawn bis_fnc_dynamicText;
player enableSimulation true;

