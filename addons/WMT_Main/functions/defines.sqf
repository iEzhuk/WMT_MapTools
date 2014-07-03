#define FAST_START 30

#define IDD_MENU_MAINMENU 	61000
#define IDC_MENU_OPTION 	61001 
#define IDC_MENU_ADMIN 		61002
#define IDC_MENU_CLOSE 		61003

#define IDD_OPTIONS_OPTIONS 		17000
#define IDC_OPTIONS_FOOT_TEXT 		17001
#define IDC_OPTIONS_FOOT_SLIDER 	17011
#define IDC_OPTIONS_FOOT_VAR 		17021
#define IDC_OPTIONS_VEH_TEXT 		17002
#define IDC_OPTIONS_VEH_SLIDER 		17012
#define IDC_OPTIONS_VEH_VAR 		17022
#define IDC_OPTIONS_AIR_TEXT 		17003
#define IDC_OPTIONS_AIR_SLIDER 		17013
#define IDC_OPTIONS_AIR_VAR 		17023
#define IDC_OPTIONS_SHIP_TEXT 		17004
#define IDC_OPTIONS_SHIP_SLIDER 	17014
#define IDC_OPTIONS_SHIP_VAR 		17024
#define IDC_OPTIONS_SPECT_TEXT 		17005
#define IDC_OPTIONS_SPECT_SLIDER 	17015
#define IDC_OPTIONS_SPECT_VAR 		17025
#define IDC_OPTIONS_MAX				17090
#define IDC_OPTIONS_CLOSE 			17091

#define IDD_ADMINPANEL				62000
#define IDC_ADMINPANEL_TEXT 		62001 
#define IDD_ADMINPANEL_CLOSE 		62002
#define IDD_ADMINPANEL_ANNOUNCEMENT 62003
#define IDD_ADMINPANEL_ENDMISSION 	62004

#define IDD_FEEDBACK			63000
#define IDC_FEEDBACK_TEXT 		63001 
#define IDC_FEEDBACK_CLOSE 		63002
#define IDC_FEEDBACK_ADMIN	 	63003
#define IDC_FEEDBACK_ADMINNAME 	63004
#define IDC_FEEDBACK_SEND	 	63005

#define IDD_DISABLETI		59000
#define IDD_DISABLETI_TEXT	59001

#define IDD_NAMETAG 		59100
#define IDC_NAMETAG_TEXT 	59101

#define KEY_ESCAPE          0x01
#define KEY_1               0x02
#define KEY_2               0x03
#define KEY_3               0x04
#define KEY_4               0x05
#define KEY_5               0x06
#define KEY_6               0x07
#define KEY_7               0x08
#define KEY_8               0x09
#define KEY_9               0x0A
#define KEY_0               0x0B
#define KEY_MINUS           0x0C    /* - on main keyboard */
#define KEY_EQUALS          0x0D
#define KEY_BACK            0x0E    /* backspace */
#define KEY_TAB             0x0F
#define KEY_Q               0x10
#define KEY_W               0x11
#define KEY_E               0x12
#define KEY_R               0x13
#define KEY_T               0x14
#define KEY_Y               0x15
#define KEY_U               0x16
#define KEY_I               0x17
#define KEY_O               0x18
#define KEY_P               0x19
#define KEY_LBRACKET        0x1A
#define KEY_RBRACKET        0x1B
#define KEY_ENTER           0x1C    /* Enter on main keyboard */
#define KEY_LCONTROL        0x1D
#define KEY_A               0x1E
#define KEY_S               0x1F
#define KEY_D               0x20
#define KEY_F               0x21
#define KEY_G               0x22
#define KEY_H               0x23
#define KEY_J               0x24
#define KEY_K               0x25
#define KEY_L               0x26
#define KEY_SEMICOLON       0x27
#define KEY_APOSTROPHE      0x28
#define KEY_GRAVE           0x29    /* accent grave */
#define KEY_LSHIFT          0x2A
#define KEY_BACKSLASH       0x2B
#define KEY_Z               0x2C
#define KEY_X               0x2D
#define KEY_C               0x2E
#define KEY_V               0x2F
#define KEY_B               0x30
#define KEY_N               0x31
#define KEY_M               0x32
#define KEY_COMMA           0x33
#define KEY_PERIOD          0x34    /* . on main keyboard */
#define KEY_SLASH           0x35    /* / on main keyboard */
#define KEY_RSHIFT          0x36
#define KEY_MULTIPLY        0x37    /* * on numeric keypad */
#define KEY_LMENU           0x38    /* left Alt */
#define KEY_SPACE           0x39
#define KEY_CAPITAL         0x3A
#define KEY_F1              0x3B
#define KEY_F2              0x3C
#define KEY_F3              0x3D
#define KEY_F4              0x3E
#define KEY_F5              0x3F
#define KEY_F6              0x40
#define KEY_F7              0x41
#define KEY_F8              0x42
#define KEY_F9              0x43
#define KEY_F10             0x44
#define KEY_NUMLOCK         0x45
#define KEY_SCROLL          0x46    /* Scroll Lock */
#define KEY_NUMPAD7         0x47
#define KEY_NUMPAD8         0x48
#define KEY_NUMPAD9         0x49
#define KEY_SUBTRACT        0x4A    /* - on numeric keypad */
#define KEY_NUMPAD4         0x4B
#define KEY_NUMPAD5         0x4C
#define KEY_NUMPAD6         0x4D
#define KEY_ADD             0x4E    /* + on numeric keypad */
#define KEY_NUMPAD1         0x4F
#define KEY_NUMPAD2         0x50
#define KEY_NUMPAD3         0x51
#define KEY_NUMPAD0         0x52
#define KEY_DECIMAL         0x53    /* . on numeric keypad */
#define KEY_OEM_102         0x56    /* < > | on UK/Germany keyboards */
#define KEY_F11             0x57
#define KEY_NUMPADENTER     0x9C    /* Enter on numeric keypad */
#define KEY_DELETE			0xD3	/* Delete*/

#define KEY_UP 				200
#define KEY_DOWN 			208
#define KEY_LEFT 			203
#define KEY_RIGHT 			205
#define KEY_HOME 			199
#define KEY_END				207

#define MOUSE_LEFT			0
#define MOUSE_RIGHT			1

#define PR(x) private ['x']; x

#define PARAM(X,Y,Z) private ['X']; X=[_this, Y, Z] call BIS_fnc_param;

