/*
    Name: WMT_fnc_EndMission

    Author(s):
        Ezhuk

    Description:
        Function for end mission

    Parameters:
        0 - STRING: message
    or
        0 - SIDE: win side
        1 - STRING: message

    Returns:
        Nothing
*/
// DEBUG
if ((missionNamespace getVariable ["WMT_pub_frzState",0]) < 3 and serverTime < 120) exitWith {
    diag_log "WMT_fnc_EndMission: WARNING!!!: mission ended before start";
    diag_log str(_this);
    hint format ["Error: mission ended\n %1", _this];
};

if(!isNil "WMT_Local_MissionEnd") exitWith {diag_log "WARNING!!! WMT_Local_MissionEnd - multiple call";};
WMT_Local_MissionEnd = true;

switch (true) do {
    case (count _this == 2) : {
        private _winner = _this select 0;
        private _text = _this select 1;

        private _isPlayerWin = (playerSide in ([_winner] call bis_fnc_friendlysides)) && (_winner != sideLogic);
        private _textWinner = if(_isPlayerWin)then{localize "STR_WMT_Win"}else{localize "STR_WMT_Lose"};
        private _config =  (isclass (configFile / "CfgDebriefing" / _text) ||  isclass (missionConfigFile / "CfgDebriefing" / _text));

        if !(_config) then {
            private _color = if(_isPlayerWin)then{"#057f05"}else{"#7f0505"};//green or red
            [ (format [ "<t size='1.4' color='%1'>%2</t>", _color, _textWinner]), 0, 0.2, 15, 0, 0, 30] spawn bis_fnc_dynamicText;
            [ (format [ "<t size='1.4' color='%1'>%2</t>", _color, _text]), 0, 0.55, 15, 0, 0, 31] spawn bis_fnc_dynamicText;
        };

        // Disable damage
        if(player != vehicle player)then{
            (vehicle player) addEventHandler ['HandleDamage', {false}];
        };
        player addEventHandler ['HandleDamage', {false}];

        if (!_config) then {
            ["end1", _isPlayerWin, 10] call BIS_fnc_endMission;
        } else {
            [_text, _isPlayerWin, 10] call BIS_fnc_endMission;
        };
    };
    case (count _this == 1) : {
        private _text = _this select 0;
        [ (format [ "<t size='1.4' color='#ff9000' shadow=2 >%1</t>", localize "STR_WMT_EndMissionByAdmin"] ), 0, 0.3, 15, 0, 0, 30] spawn bis_fnc_dynamicText;
        [ (format [ "<t size='1.4' color='#ff9000' shadow=2 >%1</t>", _text] ), 0, 0.5, 15, 0, 0, 31] spawn bis_fnc_dynamicText;
        ["end1", false, 10] call BIS_fnc_endMission;
    };
    default {};
};
