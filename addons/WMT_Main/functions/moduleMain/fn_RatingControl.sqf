/*
 	Name: WMT_fnc_RatingControl
 	
 	Author(s):
		Ezhuk

 	Description:
		Save positive rating
	
	Parameters:
		Nothing
 	
 	Returns:
		Nothing
*/
private ["_rating"];

while {true} do {
	if(alive player) then {
		_rating = rating player;
		if(_rating < 0) then {
			player addRating -_rating;
		};
	};
	sleep 1;
};