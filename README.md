# RSZ ALPHA 0.1

RSZ MOD FOR EXILE Arma3 - BECOME ZOMBIE WHEN KILLED (For AI and/or Players)
ALPHA Version - in test phase

Required : ExileZ 2 https://github.com/patrix87/ExileZ-2

When you kill AI or Player (separate installations) corpse become Zombie Demon , drop all weapons and hold all other stuff .
you can setup HeadShot yes or not ... if set yes ,killed by headshot not become zombie .....if set not, all killed become zombie...
           

Installation:

PLAYER BECOME ZOMBIE WHEN KILLED

Copy RSZ folder  (mission\RSZ )  inside your mission folder.
Open config.cpp  , search "class CfgExileCustomCode" and add this line inside class 

ExileClient_object_player_event_onKilled = "RSZ\ExileClient_object_player_event_onKilled.sqf";

Open RSZ\initRSZ.sqf and setup
_headshotOnOff = 1;   // If 1 AI  dont become demons when killed with headshot ... set 0 if you want all killed become demons


AI BECOME ZOMBIE WHEN KILLED

Copy   RSZ.pbo ( @EzileServer\addons\RSZ.pbo)  inside @EzileServer\addons\

NOTE: line to add is not equal for all AI systems

WITH DMS AI

Unpbo a3_dms.pbo 
open a3_dms\scripts\fn_onKilled.sqf and at the bottom of all 

 nul=[_unit]spawn  RESP_ZOMBIE_AFTER_DEAD;
 
 
 WITH VEMF AI
 
 Unpbo a3_vemf_reloaded.pbo
 open  a3_vemf_reloaded\sqf\handleKillCleanup.sqf and at the bottom add
 
 nul=[_t]spawn  RESP_ZOMBIE_AFTER_DEAD;	
 
 
 WITH SARGE AI
 
 Unpbo sarge.pbo
 open sarge\code\functions\fn_AI_killed.sqf and at the bottom add
 
nul=[_ai]spawn  RESP_ZOMBIE_AFTER_DEAD;


WITH FUMS AI (not tested )

Unpbo FuMS.pbo
open FuMS/HC/AI/AIKilled.sqf and at the bottom add

nul=[_victim]spawn  RESP_ZOMBIE_AFTER_DEAD;

 
 
