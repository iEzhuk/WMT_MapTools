// by [STELS]Zealot

#define SCRIPT_VERSION "1d"
#define STR_HELP "Скрипт игрового брифинга (Автор: Zealot)<br/>Сразу после старта миссии техника обездвиживается и топливо в ней появляется только после завершения фризтайма. Также на фризтайме не работают ручные гранаты и выстрелы из стрелкового оружия. <br/>Игроки, выбегающие за зону фризтайма телепортируются обратно. Это сделано для того, чтобы все могли своевременно безопасно прогрузится, настроить оборудование и вместе начать игру.<br/>Досрочно стартовать игру КО может нажав 0-0-1<br/>Чтобы предотвратить досрочный старт игры КО должен нажать 0-0-2<br/>Если хотя бы один из КО против досрочного старта игры, брифинг не прервется.<br/>Во время игрового брифинга нельзя использовать UAV терминал и баллистический вычислитель.<br/>Version: "+SCRIPT_VERSION
#define STR_SCRIPTS_NAME "Скрипты"
#define STR_SCRIPT_NAME "Игровой брифинг"

_freeztime = [_this, 0, 60] call BIS_fnc_param;

player createDiarySubject [STR_SCRIPTS_NAME,STR_SCRIPTS_NAME];
player createDiaryRecord [STR_SCRIPTS_NAME,[STR_SCRIPT_NAME, STR_HELP]];

private ["_cTime","_lastTime"];

zlt_fnc_doWantStart = {

	if ((name player) in zlt_pub_frz_waitUsrs) then {
		zlt_pub_frz_waitUsrs = zlt_pub_frz_waitUsrs - [name player];
		publicVariable "zlt_pub_frz_waitUsrs";
	} else {
		if not ((name player) in zlt_pub_frz_startUsrs) then {
			zlt_pub_frz_startUsrs = zlt_pub_frz_startUsrs + [name player];
			publicVariable "zlt_pub_frz_startUsrs";
		};
	};
};

zlt_fnc_doWantContinue = {
	if ((name player) in zlt_pub_frz_startUsrs) then {
		zlt_pub_frz_startUsrs = zlt_pub_frz_startUsrs - [name player];
		publicVariable "zlt_pub_frz_startUsrs";
	} else {
		if not ((name player) in zlt_pub_frz_waitUsrs) then {
			zlt_pub_frz_waitUsrs = zlt_pub_frz_waitUsrs + [name player];
			publicVariable "zlt_pub_frz_waitUsrs";
		};
	};
};

zlt_fnc_addTriggers = {
_triggers =  [
	[true, 0, "ALPHA", "PRESENT","this","[] call zlt_fnc_doWantStart ","","Старт игры"] call zlt_fnc_createtrigger,
	[true, 0, "BRAVO", "PRESENT","this","[] call zlt_fnc_doWantContinue ","","Отложить старт"] call zlt_fnc_createtrigger
	];

};

zlt_fnc_list_from_array = {
	_arr = _this select 0;
	_res = "";
	{
		_res = _res + _x + " ";
	} foreach _arr;
	_res;
};



_triggers = [];

if (leader player == player) then {
	[] call zlt_fnc_addTriggers;
};

waitUntil {sleep 0.75; time > 0};

while {zlt_pub_frz_state < 3} do {
	_engineon = false;
	_time3 = round(zlt_pub_frz_timeLeft);
	_sec = 0;
	if (zlt_pub_frz_state == 2) then {
		_sec = round (zlt_pub_frz_timeLeftForced);
	} else {
		_sec = _time3;
		
	};
	_infoStr1 = format ["<t size='0.6' color='%2'>%1</t>", [0 max (_sec min _time3),"MM:SS"] call BIS_fnc_secondsToString, if (_sec >= 30 ) then {"#cccccc"} else {"#ff0000"}];
	[_infoStr1, 0,safeZoneY+0.01,1.5,0,0,3] spawn bis_fnc_dynamicText;

	if (!_engineon and {player == driver vehicle player} and { (0 max (_sec min _time3)) < 10}) then {
		 player action ["engineOn", vehicle player];
		_engineon = true;
	};
	
	if (count zlt_pub_frz_waitUsrs != 0 or count zlt_pub_frz_startUsrs != 0) then {
		_infoStr5 = format ["<t size='0.4' color='#aaaaaa'>За старт игры: %1<br/>За продолжение подготовки: %2<br/></t>",
		[zlt_pub_frz_startUsrs] call zlt_fnc_list_from_array, [zlt_pub_frz_waitUsrs] call zlt_fnc_list_from_array ];
		[_infoStr5, 0.3, safeZoneY + 0.01,1.5,0,0,4]  spawn bis_fnc_dynamicText;

	};
	sleep 1;
	if (zlt_pub_frz_state == 2 and not isServer) then { zlt_pub_frz_timeLeftForced = zlt_pub_frz_timeLeftForced - 1; };	
	if (not isServer) then { zlt_pub_frz_timeLeft = zlt_pub_frz_timeLeft - 1; };	
};

["<t size='1' color='#ff0000'>Старт!</t>", 0,safeZoneY+0.01,5,0,0,3] spawn bis_fnc_dynamicText;
{deleteVehicle _x} foreach _triggers;

//sleep 3.;
//[_mission, [daytime,"HH:MM"] call BIS_fnc_timeToString] call BIS_fnc_infoText;


