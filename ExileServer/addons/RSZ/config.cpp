class CfgPatches {
	class RSZ {
		units[] = {};
		weapons[] = {};
		requiredVersion = 1.36;
		requiredAddons[] = {};
	};
};

class CfgFunctions {
	class RSZF {
		class RSZombie {
			file = "x\addons\RSZ";
			class init {
				preInit = 1;
			};
		};
	};
};