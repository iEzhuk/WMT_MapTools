private ["_freeztime","_str1"];

_freeztime = [_this, 0, 60] call BIS_fnc_param;

waitUntil {!isNull player};

evhandlervar = player addEventHandler ["Fired", {
    if (true) then
    {
        deleteVehicle (_this select 6);
//		_str1 = "<t size='0.5' color='#ff0000'>СТРЕЛЬБА/ГРАНАТЫ отключены для безопасности до старта игры! </t>";
//		[_str1, 0,0.5,5,0,0] spawn bis_fnc_dynamicText;
    };
}]; 

waitUntil {sleep 1.3; zlt_pub_frz_state >= 3};
player removeEventHandler ["Fired",evhandlervar];
