["WMT","OpenMainMenu",["Open main menu","Open main menu"],{if(!dialog) then {createDialog "RscWMTMainMenu";};},{true},[KEY_HOME,[false,false,false]],false] call cba_fnc_addKeybind;
["WMT","ShowStatistic",["Show statistic","Show statistic"],{call WMT_fnc_ShowStatistic;},{true},[KEY_END,[false,false,false]],false] call cba_fnc_addKeybind;

["WMT","ViewDistancePreset1",["Set view distace (preset 1)","Set view distace (preset 1)"],{['action_vd_preset',0] call WMT_fnc_HandlerOptions;},{true},[KEY_F1,[false,false,false]],false] call cba_fnc_addKeybind;
["WMT","ViewDistancePreset2",["Set view distace (preset 2)","Set view distace (preset 2)"],{['action_vd_preset',1] call WMT_fnc_HandlerOptions;},{true},[KEY_F2,[false,false,false]],false] call cba_fnc_addKeybind;
["WMT","ViewDistancePreset3",["Set view distace (preset 3)","Set view distace (preset 3)"],{['action_vd_preset',2] call WMT_fnc_HandlerOptions;},{true},[KEY_F3,[false,false,false]],false] call cba_fnc_addKeybind;

["WMT","Muting",["Sound muting","Sound muting"],{['action_muting',[]] call WMT_fnc_HandlerOptions;},{true},[KEY_F4,[false,false,false]],false] call cba_fnc_addKeybind;
