class RscButton;
class RscButtonMenu;
class RscText;
class RscEdit;

class RscWMTButtonMenu_ext: RscButtonMenu {
	w = 0.3;
	h = 0.1;
	color[] = {0.543, 0.5742, 0.4102, 1.0};
	class ShortcutPos {
		left = 0.0204;
		top = 0.026;
		w = 0.0392157;
		h = 0.0522876;
	};
	class TextPos {
		left = 0.06;
		top = 0.034;
		right = 0.005;
		bottom = 0.005;
	};
	period = 0.5;
	font = "PuristaMedium";
	size = 0.03921;
	sizeEx = 0.03921;
	class Attributes {
		font = "PuristaMedium";
		color = "#E5E5E5";
		align = "left";
		shadow = "false";
	};
	class AttributesImage {
		font = "PuristaMedium";
		color = "#E5E5E5";
		align = "false";
	};
};

class RscWMTText_ext {
	type = 0;
	h = 0.037;
	w = 0.3;
	style = 256;
	font = "PuristaMedium";
	SizeEx = 0.03921;
	colorText[] = {0.543, 0.5742, 0.4102, 1.0};
	colorBackground[] = {0, 0, 0, 0};
};

class RscWMTXSliderH_ext {
	idc = -1;
	type = 43;
	style = 0x400  + 0x10;
	x = 0;
	y = 0;
	h = 0.029412;
	w = 0.4;
	color[] = {1, 1, 1, 0.4};
	colorActive[] = {1, 1, 1, 1};
	colorDisabled[] = {1, 1, 1, 0.2};	
	arrowEmpty = "\A3\ui_f\data\gui\cfg\slider\arrowEmpty_ca.paa";
	arrowFull = "\A3\ui_f\data\gui\cfg\slider\arrowFull_ca.paa";
	border = "\A3\ui_f\data\gui\cfg\slider\border_ca.paa";
	thumb = "\A3\ui_f\data\gui\cfg\slider\thumb_ca.paa";
};

class RscWMTButton_ext: RscButton{
	type = 1;
	colorDisabled[] = 
	{
		0.4,
		0.4,
		0.4,
		1
	};
	colorBackground[] = 
	{
		"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",
		0.9
	};
	colorBackgroundDisabled[] = 
	{
		0.95,
		0.95,
		0.95,
		1
	};
	colorBackgroundActive[] = 
	{
		"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",
		1
	};
	colorFocused[] = 
	{
		"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",
		1
	};
	colorBorder[] = 
	{
		0,
		0,
		0,
		1
	};
	w = 0.16;
	h = 0.04;
	shadow = 0;
	offsetPressedX = 0.002;
	offsetPressedY = 0.002;
};