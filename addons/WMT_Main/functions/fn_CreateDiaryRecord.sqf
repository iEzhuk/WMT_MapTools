/*
    Name: WMT_fnc_CreateDiaryRecord

    Author(s):
        Ezhuk

    Description:
        Create record in diary of player

    Parameters:
        0 - diary
        1 - head
        2 - text

    Returns:
        Nothing
*/
params ["_d", "_head", "_text"];

if(_text != "")then{
    if(_text != "_")then{
        player createDiarySubject [_d, _head];
        player createDiaryRecord [_d, [_head, _text]];
    };
};
