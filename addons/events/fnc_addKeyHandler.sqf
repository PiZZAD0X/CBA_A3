/* ----------------------------------------------------------------------------
Function: CBA_fnc_addKeyHandler

Description:
	Adds an action to a keyhandler

Parameters:
	_key - Numerical key to attach action to [Integer].
	_settings - Shift, Ctrl, Alt required [Array].
	_code - Code to execute upon event [Code].
	_type - "keydown" (default) = keyDown,  "keyup" = keyUp [String].

Returns:

Examples:
	(begin example)
		[47, [true, false, false], { _this call myAction }] call CBA_fnc_addKeyHandler;
	(end)

Author:
	Sickboy

---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(addKeyHandler);

private ["_ar", "_entry", "_type", "_handlers"];
PARAMS_3(_key,_settings,_code);
_type = if (count _this > 3) then { _this select 3 } else { "keydown" };
_type = toLower _type;
if (_type in KEYS_ARRAY_WRONG) then { _type = ("key" + _type) };
if !(_type in KEYS_ARRAY) exitWith { ERROR("Type does not exist") };

_handlers = [GVAR(keyhandler_hash), _type] call CBA_fnc_hashGet;

if(_key>(count _handlers))then{_handlers resize(_key+1);};
_ar = _handlers select _key;
if(isNil"_ar")then{_ar=[]};
_entry = [_settings, _code];
PUSH(_ar,_entry);
_handlers set [_key, _ar];

true;
