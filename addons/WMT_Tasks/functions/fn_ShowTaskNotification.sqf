/*
     Name: WMT_fnc_ShowTaskNotification
     
     Author(s):
        Ezhuk

     Description:
        Show notification 
    
    Parameters:
        0: STRING 
    or 
        0: SIDE
        1: STRING
     
     Returns:
        nothing
*/

switch(count _this) do {
    case 1: {
        private["_text"];
        _text = _this select 0;
        ["TaskAssigned",[0,_text]] call bis_fnc_showNotification;
    };
    case 2: {
        private ["_side","_text"];
        _side = _this select 0;
        _text = _this select 1;
        _type = if (playerSide == _side) then {"TaskSucceeded"} else {"TaskFailed"};
        [_type,[0,_text]] call bis_fnc_showNotification;
    };
};