/*

Coded by W4lly63
Spawn Zombie by player/AI after dead
nul = [_unit]execVM "RSZ\spawn_zombie"

*/

private ["_pos","_pos_x","_pos_y","_pos_z","_group","_myUnitCount","_u","_p","_wep","_x","_pName","_vehDemon","_vehDemonsItems","_vehPrimItems","_vehSecItems","_vehHangItems","_vehPrimWep","_vehSecWep","_vehHandWep","_vehAllWep","_isBin","_isRangef","_vehPrimMags","_vehSecMags","_vehHandMags","_damageHeadRSZ","_headShotRSZ"];

#include "initRSZ.sqf"

    _p = _this select 0;
   _pos= getPos _p;   

	_vehPrimWep =""; _vehSecWep=""; _vehHandWep =""; _vehPrimItems =[]; _vehSecItems =[]; _vehHangItems =[]; _vehAllWep =[]; _isBin = false; _isRangef = false; _vehPrimMags = []; _vehSecMags = []; _vehHandMags =[]; _headShotRSZ = 0;

	if(_headshotOnOff == 1) then {
        _damageHeadRSZ = _p getHit "head";
        if (_damageHeadRSZ > 0.9) then {_headShotRSZ = 1};	
	};

if(_headShotRSZ == 0)then {
	
	if (count(weapons  _p) > 0) then {
	   _vehAllWep = (weapons _p);
	   if ("Binocular" in _vehAllWep) then {
		   _p removeWeapon "Binocular";
		   _isBin = true;
	   };
	   	   if ("Rangefinder" in _vehAllWep) then {
		   _p removeWeapon "Rangefinder";
		   _isRangef = true;
	   };
	};
	
	if ((primaryWeapon _p) != "") then {
	   _vehPrimWep = (primaryWeapon _p);
	   _vehPrimItems = _p weaponAccessories _vehPrimWep;
       _vehPrimMags =	primaryWeaponMagazine _p;   
	   _p removeWeapon _vehPrimWep;
	};
	
	if ((secondaryWeapon _p) != "") then {
	   _vehSecWep = (secondaryWeapon _p);		
	   _vehSecItems = _p weaponAccessories _vehSecWep;
	   _vehSecMags = secondaryWeaponMagazine _p;
	    _p removeWeapon _vehSecWep;
	};
	if ((handgunWeapon _p) != "") then {
	   _vehHandWep = (handgunWeapon _p);
	   _vehHangItems = _p weaponAccessories _vehHandWep;
       _vehHandMags	= handgunMagazine _p;   
	   _p removeWeapon _vehHandWep;
	};
	
	
	_pName = name _p;
	[_p, [missionNamespace, format ["%1%2","InvRSZ",_pName]]] call BIS_fnc_saveInventory ;
	
	


	
	removeAllItems _p;
    removeAllWeapons _p;
    removeUniform _p;
    removeVest _p;
    removeBackpack _p;
    removeHeadgear _p;

    hideObject _p;
	


    _group = creategroup  EAST;
    _group setCombatMode "BLUE";
    _group allowFleeing 0;
    _group enableAttack true;
	_zClass = selectRandom _demonTypeRSZ;

	
	_zClass createUnit 
	[
		_pos,
		_group,
		"
		
		doStop this;
		this disableAI 'FSM';
		this enableAI 'ANIM';
		this disableConversation true;
		this addMPEventHandler ['MPKilled', {_this spawn ZMPKilled;}];
		
		"
		
	];
	
	_myUnitCount = count units _group;
	
	{
		[_x, [missionNamespace, format ["%1%2","InvRSZ",_pName]]] call BIS_fnc_loadInventory ; 
		
	} foreach units _group;
	
	    
	for "_h" from 0 to (_myUnitCount -1) do {
        _u = units _group select _h;
        _wep = createVehicle ["groundWeaponHolder", _u  modelToWorld [0,0.8,0], [], 0.5, "CAN_COLLIDE"];
		
        if (_vehPrimWep != "") then {
			_wep addWeaponCargoGlobal [_vehPrimWep, 1];
			if (count _vehPrimItems > 0 ) then {
			    {_wep addItemCargoGlobal [_x, 1];} forEach _vehPrimItems;
			};
		    if (count _vehPrimMags > 0 ) then {
			    {_wep addItemCargoGlobal [_x, 1];} forEach _vehPrimMags;
			};
		};
		if (_vehSecWep != "") then {
			_wep addWeaponCargoGlobal [_vehSecWep, 1];
			if (count _vehSecItems > 0) then {			
			    {_wep addItemCargoGlobal [_x, 1];} forEach _vehSecItems;
			};
			if (count _vehSecMags > 0) then {			
			    {_wep addItemCargoGlobal [_x, 1];} forEach _vehSecMags;
			};
		};
		if (_vehHandWep != "") then {
			_wep addWeaponCargoGlobal [_vehHandWep, 1];
			if (count _vehHangItems > 0) then {			
			    {_wep addItemCargoGlobal [_x, 1];} forEach _vehHangItems;
			};
			if (count _vehHandMags > 0) then {			
			    {_wep addItemCargoGlobal [_x, 1];} forEach _vehHandMags;
			};
		};
		if (_isBin) then {_wep addWeaponCargoGlobal ["Binocular", 1];};
		if (_isRangef) then {_wep addWeaponCargoGlobal ["Rangefinder", 1];};
		

				
	};
};
	
	_vehPrimWep = nil; _vehSecWep = nil; _vehHandWep = nil; _vehPrimItems = nil; _vehSecItems = nil; _vehHangItems = nil; _vehAllWep = nil; _isBin = nil; _isRangef = nil; _vehPrimMags = nil; _vehSecMags =nil; _vehHandMags = nil;  _headshotOnOff = nil; _headShotRSZ = nil;
	
