class welcomeScreen
{
	idd = 6969;

	class controls
	{
		class welcomeFrame: IGUIBackMRTM
		{
			idc = 69697;
			deletable = 0;
			x = 0.250656 * safezoneW + safezoneX;
			y = 0.171 * safezoneH + safezoneY;
			w = 0.499688 * safezoneW;
			h = 0.671 * safezoneH;
			colorText[] = {1,1,1,1};
		};

		class welcomeMain: IGUIBackMRTM
		{
			idc = 69690;
			deletable = 0;
			x = 0.257656 * safezoneW + safezoneX;
			y = 0.181 * safezoneH + safezoneY;
			w = 0.484688 * safezoneW;
			h = 0.649 * safezoneH;
			colorText[] = {1,1,1,1};
			colorActive[] = {1,1,1,1};
		};

		class welcomeMainImg: RscPictureMRTM
		{
			idc = 69691;
			deletable = 0;
			text = "img\altis.paa";
			style = ST_MULTI + ST_TITLE_BAR;
			x = 0.257656 * safezoneW + safezoneX;
			y = 0.181 * safezoneH + safezoneY;
			w = 0.484688 * safezoneW;
			h = 0.649 * safezoneH;
		};

		class welcomeText: RscStructuredTextMRTM
		{
			idc = 69692;
			deletable = 0;
			text = "Warlords Redux v2.5";
			x = 0.288594 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.149531 * safezoneW;
			h = 0.033 * safezoneH;
		};

		class welcomeTextToRead: RscStructuredTextMRTM
		{
			idc = 6969691;
			deletable = 0;
			text = "";
			font = "puristaMedium";
			x = 0.508594 * safezoneW + safezoneX;
			y = 0.801 * safezoneH + safezoneY;
			w = 0.189531 * safezoneW;
			h = 0.033 * safezoneH;
		};

		class welcomeSlidePic: RscPictureMRTM
		{
			idc = 69694;
			deletable = 0;
			text = "";
			style = ST_MULTI + ST_TITLE_BAR + ST_KEEP_ASPECT_RATIO;
			x = 0.288594 * safezoneW + safezoneX;
			y = 0.588 * safezoneH + safezoneY;
			w = 0.190781 * safezoneW;
			h = 0.209 * safezoneH;
		};

		class welcomeListFrame: RscFrameMRTM
		{
			type = CT_STATIC;
			idc = 69698;
			deletable = 0;
			style = ST_FRAME;
			colorBackground[] = {0,0,0,0};
			x = 0.288594 * safezoneW + safezoneX;
			y = 0.269 * safezoneH + safezoneY;
			w = 0.190781 * safezoneW;
			h = 0.286 * safezoneH;
		};

		class welcomeTextBlockFrame: RscFrameMRTM
		{
			type = CT_STATIC;
			idc = 69699;
			deletable = 0;
			style = ST_FRAME;
			colorBackground[] = {0,0,0,0};
			x = 0.485469 * safezoneW + safezoneX;
			y = 0.269 * safezoneH + safezoneY;
			w = 0.245937 * safezoneW;
			h = 0.528 * safezoneH;
		};

		class welcomeControlGroup: RscControlsGroupMRTM
		{
			deletable = 0;
			fade = 0;
			class VScrollbar: ScrollBar
			{
				color[] = {1,1,1,1};
				height = 0.528;
				width = 0.021;
				autoScrollEnabled = 1;
			};

			class HScrollbar: ScrollBar
			{
				color[] = {1,1,1,1};
				height = 0;
				width = 0;
			};

			class Controls
			{
				class welcomeTextBlock: RscStructuredTextMRTM
				{
					idc = 69696;
					deletable = 0;
					type = CT_STRUCTURED_TEXT;
					style = ST_LEFT;
					w = 0.245937 * safezoneW;
					h = 4.5 * safezoneH;
				};
			};

			type = CT_CONTROLS_GROUP;
			idc = -1;
			x = 0.485469 * safezoneW + safezoneX;
			y = 0.269 * safezoneH + safezoneY;
			w = 0.255937 * safezoneW;
			h = 0.528 * safezoneH;
			shadow = 0;
			style = ST_MULTI;
		};

		class welcomeList: RscListboxMRTM
		{
			idc = 69695;
			deletable = 0;
			x = 0.288594 * safezoneW + safezoneX;
			y = 0.269 * safezoneH + safezoneY;
			w = 0.190781 * safezoneW;
			h = 0.286 * safezoneH;
		};
		class welcomeCloseButton: RscButtonMRTM
		{
			idc = 1;
			access = 0;
			type = CT_BUTTON;
			text = "Close";
			colorText[] = {1,1,1,1};
			colorDisabled[] = {0,0,0,0};
			colorBackground[] = {0,0,0,0};
			colorBackgroundDisabled[] = {0,0,0,0};
			colorBackgroundActive[] = {0,0,0,0};
			colorFocused[] = {0,0,0,0};
			colorShadow[] = {0,0,0,0};
			colorBorder[] = {1,1,1,0};
			soundEnter[] = {"\A3\ui_f\data\Sound\RscButtonMenu\soundEnter", 0.09, 1};
			soundPush[] = {"\A3\ui_f\data\Sound\RscButtonMenu\soundPush", 0.0, 0};
			soundClick[] = {"\A3\ui_f\data\Sound\RscButtonMenu\soundClick", 0.07, 1};
			soundEscape[] = {"\A3\ui_f\data\Sound\RscButtonMenu\soundEscape", 0.09, 1};
			style = 2;
			x = 0.678594 * safezoneW + safezoneX;
			y = 0.794 * safezoneH + safezoneY;
			w = 0.059531 * safezoneW;
			h = 0.033 * safezoneH;
			shadow = 0;
			sizeEx = 0.03921;
			offsetX = 0.000;
			offsetY = 0.000;
			offsetPressedX = 0.002;
			offsetPressedY = 0.002;
			borderSize = 0;
			onLoad =  "(_this # 0) ctrlEnable false;";
		};
	};
};

class rearmMenu
{
	idd = 1000;

	class controls
	{
		class MRTMRearmBack: IGUIBackMRTM
		{
			idc = 2200;
			x = 0.247344 * safezoneW + safezoneX;
			y = 0.236 * safezoneH + safezoneY;
			w = 0.515625 * safezoneW;
			h = 0.495 * safezoneH;
		};
		class MRTMRearmOk: RscButtonMRTM
		{
			idc = 1;
			type = CT_BUTTON;
			text = "Rearm";
			x = 0.68975 * safezoneW + safezoneX;
			y = 0.687 * safezoneH + safezoneY;
			w = 0.0670312 * safezoneW;
			h = 0.033 * safezoneH;
			onLoad =  "(_this # 0) ctrlEnable true;";
		};
		class MRTMRearmCamoText: RscStructuredTextMRTM
		{
			idc = 1100;
			text = "Cammo Netting:";
			x = 0.422656 * safezoneW + safezoneX;
			y = 0.258 * safezoneH + safezoneY;
			w = 0.139219 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class MRTMRearmHullList: RscListboxMRTM
		{
			idc = 1500;
			x = 0.267969 * safezoneW + safezoneX;
			y = 0.302 * safezoneH + safezoneY;
			w = 0.139219 * safezoneW;
			h = 0.187 * safezoneH;
		};
		class MRTMRearmHullText: RscStructuredTextMRTM
		{
			idc = 1101;
			text = "SLAT armor:";
			x = 0.267969 * safezoneW + safezoneX;
			y = 0.258 * safezoneH + safezoneY;
			w = 0.139219 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class MRTMRearmCamoList: RscListboxMRTM
		{
			idc = 1501;
			x = 0.422656 * safezoneW + safezoneX;
			y = 0.302 * safezoneH + safezoneY;
			w = 0.139219 * safezoneW;
			h = 0.187 * safezoneH;
		};
		class MRTMRearmOtherText: RscStructuredTextMRTM
		{
			idc = 1103;
			text = "Other customizations:";
			x = 0.267969 * safezoneW + safezoneX;
			y = 0.511 * safezoneH + safezoneY;
			w = 0.139219 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class MRTMRearmOtherList: RscListboxMRTM
		{
			idc = 1503;
			x = 0.267969 * safezoneW + safezoneX;
			y = 0.555 * safezoneH + safezoneY;
			w = 0.139219 * safezoneW;
			h = 0.143 * safezoneH;
		};
		class MRTMRearmCustomAmmoText: RscStructuredTextMRTM
		{
			idc = 1104;
			text = "Custom ammo: Soon™";
			x = 0.422656 * safezoneW + safezoneX;
			y = 0.511 * safezoneH + safezoneY;
			w = 0.139219 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class MRTMRearmLiveryText: RscStructuredTextMRTM
		{
			idc = 1102;
			text = "Liveries: Soon™";
			x = 0.577344 * safezoneW + safezoneX;
			y = 0.258 * safezoneH + safezoneY;
			w = 0.139219 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class RscFrame_1800: RscFrameMRTM
		{
			idc = 1800;
			x = 0.265905 * safezoneW + safezoneX;
			y = 0.5066 * safezoneH + safezoneY;
			w = 0.144375 * safezoneW;
			h = 0.198 * safezoneH;
		};
		class RscFrame_1801: RscFrameMRTM
		{
			idc = 1801;
			x = 0.265907 * safezoneW + safezoneX;
			y = 0.2536 * safezoneH + safezoneY;
			w = 0.144375 * safezoneW;
			h = 0.242 * safezoneH;
		};
		class RscFrame_1802: RscFrameMRTM
		{
			idc = 1802;
			x = 0.420594 * safezoneW + safezoneX;
			y = 0.2536 * safezoneH + safezoneY;
			w = 0.144375 * safezoneW;
			h = 0.242 * safezoneH;
		};
		class RscFrame_1803: RscFrameMRTM
		{
			idc = 1803;
			x = 0.576313 * safezoneW + safezoneX;
			y = 0.2536 * safezoneH + safezoneY;
			w = 0.144375 * safezoneW;
			h = 0.242 * safezoneH;
		};
		class RscFrame_1804: RscFrameMRTM
		{
			idc = 1804;
			x = 0.420593 * safezoneW + safezoneX;
			y = 0.5066 * safezoneH + safezoneY;
			w = 0.144375 * safezoneW;
			h = 0.198 * safezoneH;
		};
		class MRTMRearmCustomAmmoClassified: RscPictureMRTM
		{
			idc = 69691;
			deletable = 0;
			text = "img\classified.paa";
			style = ST_MULTI + ST_TITLE_BAR + ST_KEEP_ASPECT_RATIO;
			x = 0.422656 * safezoneW + safezoneX;
			y = 0.530 * safezoneH + safezoneY;
			w = 0.139219 * safezoneW;
			h = 0.187 * safezoneH;
		};
		class MRTMRearmLiveryClassified: RscPictureMRTM
		{
			idc = 69691;
			deletable = 0;
			text = "img\classified.paa";
			style = ST_MULTI + ST_TITLE_BAR + ST_KEEP_ASPECT_RATIO;
			x = 0.577344 * safezoneW + safezoneX;
			y = 0.302 * safezoneH + safezoneY;
			w = 0.139219 * safezoneW;
			h = 0.187 * safezoneH;
		};
	};
};

class MRTM_settingsMenu
{
	idd = 8000;

	class controls
	{
		class MRTMBackground: IGUIBackMRTM
		{
			idc = 1600;
			colorBackground[] = {0,0,0,0.75};
			x = 0.26836 * safezoneW + safezoneX;
			y = 0.2646 * safezoneH + safezoneY;
			w = 0.45375 * safezoneW;
			h = 0.517 * safezoneH;
		};
		class MRTMHeaderBackground: IGUIBackMRTM
		{
			idc = 2200;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
			x = 0.267969 * safezoneW + safezoneX;
			y = 0.235 * safezoneH + safezoneY;
			w = 0.45375 * safezoneW;
			h = 0.025 * safezoneH;
		};
		class MRTMHeaderTextLeft: RscStructuredTextMRTM
		{
			idc = 1100;
			text = "Option menu";
			colorBackground[] = {0,0,0,0};
			x = 0.267969 * safezoneW + safezoneX;
			y = 0.235 * safezoneH + safezoneY;
			w = 0.154687 * safezoneW;
			h = 0.033 * safezoneH;
			class Attributes
			{
				font = "PuristaMedium";
				color = "#ffffff";
				colorLink = "#D09B43";
				align = "left";
				shadow = 1;
			};
		};
		class MRTMHeaderTextRight: RscStructuredTextMRTM
		{
			idc = 1101;
			colorBackground[] = {0,0,0,0};
			x = 0.577344 * safezoneW + safezoneX;
			y = 0.235 * safezoneH + safezoneY;
			w = 0.144375 * safezoneW;
			h = 0.033 * safezoneH;
			class Attributes
			{
				font = "PuristaMedium";
				color = "#ffffff";
				colorLink = "#D09B43";
				align = "right";
				shadow = 1;
			};
		};
		class MRTMViewHeaderText: RscStructuredTextMRTM
		{
			idc = 1103;
			text = "View Settings";
			colorBackground[] = {0,0,0,0.9};
			x = 0.267969 * safezoneW + safezoneX;
			y = 0.2646 * safezoneH + safezoneY;
			w = 0.185625 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class MRTMViewInfText: RscStructuredTextMRTM
		{
			idc = 1102;
			text = "Infantry:";
			x = 0.271063 * safezoneW + safezoneX;
			y = 0.3042 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.033 * safezoneH;
			class Attributes
			{
				font = "PuristaMedium";
				color = "#ffffff";
				colorLink = "#D09B43";
				align = "left";
				shadow = 1;
				size = 0.9;
			};
		};
		class MRTMViewGroundText: RscStructuredTextMRTM
		{
			idc = 1104;
			text = "Vehicles:";
			x = 0.271063 * safezoneW + safezoneX;
			y = 0.3416 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.033 * safezoneH;
			class Attributes
			{
				font = "PuristaMedium";
				color = "#ffffff";
				colorLink = "#D09B43";
				align = "left";
				shadow = 1;
				size = 0.9;
			};
		};
		class MRTMViewAirText: RscStructuredTextMRTM
		{
			idc = 1105;
			text = "Air:";
			x = 0.271063 * safezoneW + safezoneX;
			y = 0.3812 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.033 * safezoneH;
			class Attributes
			{
				font = "PuristaMedium";
				color = "#ffffff";
				colorLink = "#D09B43";
				align = "left";
				shadow = 1;
				size = 0.9;
			};
		};
		class MRTMViewDronesText: RscStructuredTextMRTM
		{
			idc = 1106;
			text = "Drones:";
			x = 0.271063 * safezoneW + safezoneX;
			y = 0.4186 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.033 * safezoneH;
			class Attributes
			{
				font = "PuristaMedium";
				color = "#ffffff";
				colorLink = "#D09B43";
				align = "left";
				shadow = 1;
				size = 0.9;
			};
		};
		class MRTMViewInfEdit: RscEditMRTM
		{
			idc = 1400;
			onKeyUp = "[_this select 0, _this select 1, 'inf',true] call MRTM_fnc_onChar;";
			x = 0.411271 * safezoneW + safezoneX;
			y = 0.3042 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class MRTMViewVehiclesEdit: RscEditMRTM
		{
			idc = 1401;
			onKeyUp = "[_this select 0, _this select 1, 'ground',true] call MRTM_fnc_onChar;";
			x = 0.411313 * safezoneW + safezoneX;
			y = 0.3416 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class MRTMViewAirEdit: RscEditMRTM
		{
			idc = 1402;
			onKeyUp = "[_this select 0, _this select 1, 'air',true] call MRTM_fnc_onChar;";
			x = 0.411313 * safezoneW + safezoneX;
			y = 0.3812 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class MRTMViewDronesEdit: RscEditMRTM
		{
			idc = 1403;
			onKeyUp = "[_this select 0, _this select 1, 'drones',true] call MRTM_fnc_onChar;";
			x = 0.411311 * safezoneW + safezoneX;
			y = 0.4186 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class MRTMObjectsHeaderText: RscStructuredTextMRTM
		{
			idc = 1108;
			text = "Object Settings";
			colorBackground[] = {0,0,0,0.9};
			x = 0.267969 * safezoneW + safezoneX;
			y = 0.4582 * safezoneH + safezoneY;
			w = 0.185625 * safezoneW;
			h = 0.033 * safezoneH;
			class Attributes
			{
				font = "PuristaMedium";
				color = "#ffffff";
				colorLink = "#D09B43";
				align = "left";
				shadow = 1;
			};
		};
		class MRTMObjectsButton: RscCheckboxMRTM
		{
			idc = 2800;
			action = "if (MRTM_syncObjects) then {MRTM_syncObjects = false} else {MRTM_syncObjects = true}; [] call MRTM_fnc_openMenu;";
			x = 0.273125 * safezoneW + safezoneX;
			y = 0.5044 * safezoneH + safezoneY;
			w = 0.0154688 * safezoneW;
			h = 0.022 * safezoneH;
			tooltip = "Sync object rendering";
		};
		class MRTMObjectsButtonText: RscStructuredTextMRTM
		{
			idc = 1109;
			text = "Sync object rendering with view distance";
			x = 0.291687 * safezoneW + safezoneX;
			y = 0.5044 * safezoneH + safezoneY;
			w = 0.159844 * safezoneW;
			h = 0.022 * safezoneH;
			class Attributes
			{
				font = "PuristaMedium";
				color = "#ffffff";
				colorLink = "#D09B43";
				align = "left";
				shadow = 1;
				size = 0.9;
			};
		};
		class MRTMObjectsText: RscStructuredTextMRTM
		{
			idc = 1110;
			text = "Objects:";
			x = 0.273125 * safezoneW + safezoneX;
			y = 0.5374 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.033 * safezoneH;
			class Attributes
			{
				font = "PuristaMedium";
				color = "#ffffff";
				colorLink = "#D09B43";
				align = "left";
				shadow = 1;
				size = 0.9;
			};
		};
		class MRTMObjectsEdit: RscEditMRTM
		{
			idc = 1404;
			onKeyUp = "[_this select 0, _this select 1, 'objects',true] call MRTM_fnc_onChar;";
			x = 0.411289 * safezoneW + safezoneX;
			y = 0.5374 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class MRTMRWRHeaderText: RscStructuredTextMRTM
		{
			idc = 1111;
			text = "Voice Warning Volume Settings";
			colorBackground[] = {0,0,0,0.9};
			x = 0.453594 * safezoneW + safezoneX;
			y = 0.2646 * safezoneH + safezoneY;
			w = 0.268125 * safezoneW;
			h = 0.033 * safezoneH;
			class Attributes
			{
				font = "PuristaMedium";
				color = "#ffffff";
				colorLink = "#D09B43";
				align = "left";
				shadow = 1;
			};
		};
		class MRTMRWRText1: RscStructuredTextMRTM
		{
			idc = 1112;
			text = "Pull Up Volume:";
			x = 0.456652 * safezoneW + safezoneX;
			y = 0.3042 * safezoneH + safezoneY;
			w = 0.0800312 * safezoneW;
			h = 0.033 * safezoneH;
			class Attributes
			{
				font = "PuristaMedium";
				color = "#ffffff";
				colorLink = "#D09B43";
				align = "left";
				shadow = 1;
			};
		};
		class MRTMRWRText2: RscStructuredTextMRTM
		{
			idc = 1113;
			text = "Altitude Volume:";
			x = 0.456687 * safezoneW + safezoneX;
			y = 0.3416 * safezoneH + safezoneY;
			w = 0.0800312 * safezoneW;
			h = 0.033 * safezoneH;
			class Attributes
			{
				font = "PuristaMedium";
				color = "#ffffff";
				colorLink = "#D09B43";
				align = "left";
				shadow = 1;
			};
		};
		class MRTMRWRText3: RscStructuredTextMRTM
		{
			idc = 1114;
			text = "Warning Volume:";
			x = 0.456687 * safezoneW + safezoneX;
			y = 0.3812 * safezoneH + safezoneY;
			w = 0.0800312 * safezoneW;
			h = 0.033 * safezoneH;
			class Attributes
			{
				font = "PuristaMedium";
				color = "#ffffff";
				colorLink = "#D09B43";
				align = "left";
				shadow = 1;
			};
		};
		class MRTMRWRText4: RscStructuredTextMRTM
		{
			idc = 1115;
			text = "Other:";
			x = 0.456687 * safezoneW + safezoneX;
			y = 0.4186 * safezoneH + safezoneY;
			w = 0.0800312 * safezoneW;
			h = 0.033 * safezoneH;
			class Attributes
			{
				font = "PuristaMedium";
				color = "#ffffff";
				colorLink = "#D09B43";
				align = "left";
				shadow = 1;
			};
		};
		class MRTMRWREdit1: RscEditMRTM
		{
			idc = 1405;
			onKeyUp = "[_this select 0, _this select 1, 'RWR1',true] call MRTM_fnc_onChar;";
			x = 0.672179 * safezoneW + safezoneX;
			y = 0.3042 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class MRTMRWREdit2: RscEditMRTM
		{
			idc = 1406;
			onKeyUp = "[_this select 0, _this select 1, 'RWR2',true] call MRTM_fnc_onChar;";
			x = 0.672218 * safezoneW + safezoneX;
			y = 0.3416 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class MRTMRWREdit3: RscEditMRTM
		{
			idc = 1407;
			onKeyUp = "[_this select 0, _this select 1, 'RWR3',true] call MRTM_fnc_onChar;";
			onLoad =  "(_this # 0) ctrlEnable false;";
			x = 0.672219 * safezoneW + safezoneX;
			y = 0.3812 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class MRTMRWREdit4: RscEditMRTM
		{
			idc = 1408;
			onKeyUp = "[_this select 0, _this select 1, 'RWR4',true] call MRTM_fnc_onChar;";
			x = 0.672218 * safezoneW + safezoneX;
			y = 0.4186 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class MRTMOtherSettingsHeaderText: RscStructuredTextMRTM
		{
			idc = 1116;
			text = "Other Settings";
			colorBackground[] = {0,0,0,0.9};
			x = 0.453594 * safezoneW + safezoneX;
			y = 0.4582 * safezoneH + safezoneY;
			w = 0.268125 * safezoneW;
			h = 0.033 * safezoneH;
			class Attributes
			{
				font = "PuristaMedium";
				color = "#ffffff";
				colorLink = "#D09B43";
				align = "left";
				shadow = 1;
			};
		};
		class MRTMOtherButton1: RscCheckboxMRTM
		{
			idc = 2801;
			action = "if (player getVariable 'MRTM_3rdPersonDisabled') then {player setVariable ['MRTM_3rdPersonDisabled', false, [2, clientOwner]];} else {player setVariable ['MRTM_3rdPersonDisabled', true, [2, clientOwner]];}";
			toolTip = "Recieve a 100% CP bonus.";
			x = 0.463906 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.0154688 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class MRTMOtherButton2: RscCheckboxMRTM
		{
			idc = 2802;
			action = "if (MRTM_muteVoiceInformer) then {MRTM_muteVoiceInformer = false} else {MRTM_muteVoiceInformer = true}";
			x = 0.463906 * safezoneW + safezoneX;
			y = 0.533 * safezoneH + safezoneY;
			w = 0.0154688 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class MRTMOtherButton3: RscCheckboxMRTM
		{
			idc = 2803;
			action = "if (MRTM_playKillSound) then {MRTM_playKillSound = false} else {MRTM_playKillSound = true}";
			x = 0.463906 * safezoneW + safezoneX;
			y = 0.566 * safezoneH + safezoneY;
			w = 0.0154688 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class MRTMOtherButton4: RscCheckboxMRTM
		{
			idc = 2804;
			action = "if (MRTM_EnableRWR) then {MRTM_EnableRWR = false} else {MRTM_EnableRWR = true}";
			x = 0.463906 * safezoneW + safezoneX;
			y = 0.599 * safezoneH + safezoneY;
			w = 0.0154688 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class MRTMOtherButton5: RscCheckboxMRTM
		{
			idc = 2805;
			action = "if (MRTM_disableHint) then {MRTM_disableHint = false} else {MRTM_disableHint = true}";
			x = 0.463906 * safezoneW + safezoneX;
			y = 0.632 * safezoneH + safezoneY;
			w = 0.0154688 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class MRTMOtherButton6: RscCheckboxMRTM
		{
			idc = 2806;
			action = "if (MRTM_smallAnnouncerText) then {MRTM_smallAnnouncerText = false} else {MRTM_smallAnnouncerText = true}";
			x = 0.463906 * safezoneW + safezoneX;
			y = 0.665 * safezoneH + safezoneY;
			w = 0.0154688 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class MRTMOtherButton7: RscCheckboxMRTM
		{
			idc = 2807;
			action = "";
			onLoad =  "(_this # 0) ctrlEnable false;";
			x = 0.463906 * safezoneW + safezoneX;
			y = 0.698 * safezoneH + safezoneY;
			w = 0.0154688 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class MRTMOtherButton8: RscCheckboxMRTM
		{
			idc = 2808;
			action = "";
			onLoad =  "(_this # 0) ctrlEnable false;";
			x = 0.463906 * safezoneW + safezoneX;
			y = 0.731 * safezoneH + safezoneY;
			w = 0.0154688 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class MRTMOtherText1: RscStructuredTextMRTM
		{
			idc = 1117;
			text = "Disable 3rd person view";
			x = 0.481437 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.221719 * safezoneW;
			h = 0.022 * safezoneH;
			class Attributes
			{
				font = "PuristaMedium";
				color = "#ffffff";
				colorLink = "#D09B43";
				align = "left";
				shadow = 1;
			};
		};
		class MRTMOtherText2: RscStructuredTextMRTM
		{
			idc = 1118;
			text = "Mute the warlords voice informer";
			x = 0.481437 * safezoneW + safezoneX;
			y = 0.533 * safezoneH + safezoneY;
			w = 0.221719 * safezoneW;
			h = 0.022 * safezoneH;
			class Attributes
			{
				font = "PuristaMedium";
				color = "#ffffff";
				colorLink = "#D09B43";
				align = "left";
				shadow = 1;
			};
		};
		class MRTMOtherText3: RscStructuredTextMRTM
		{
			idc = 1119;
			text = "Play sound for kill reward";
			x = 0.481437 * safezoneW + safezoneX;
			y = 0.566 * safezoneH + safezoneY;
			w = 0.221719 * safezoneW;
			h = 0.022 * safezoneH;
			class Attributes
			{
				font = "PuristaMedium";
				color = "#ffffff";
				colorLink = "#D09B43";
				align = "left";
				shadow = 1;
			};
		};
		class MRTMOtherText4: RscStructuredTextMRTM
		{
			idc = 1120;
			text = "Enable the voice warning system on aircraft";
			x = 0.481437 * safezoneW + safezoneX;
			y = 0.599 * safezoneH + safezoneY;
			w = 0.221719 * safezoneW;
			h = 0.022 * safezoneH;
			class Attributes
			{
				font = "PuristaMedium";
				color = "#ffffff";
				colorLink = "#D09B43";
				align = "left";
				shadow = 1;
			};
		};
		class MRTMOtherText5: RscStructuredTextMRTM
		{
			idc = 1121;
			text = "Disable easter egg hints";
			x = 0.481437 * safezoneW + safezoneX;
			y = 0.632 * safezoneH + safezoneY;
			w = 0.221719 * safezoneW;
			h = 0.022 * safezoneH;
			class Attributes
			{
				font = "PuristaMedium";
				color = "#ffffff";
				colorLink = "#D09B43";
				align = "left";
				shadow = 1;
			};
		};
		class MRTMOtherText6: RscStructuredTextMRTM
		{
			idc = 1122;
			text = "Small announcer font";
			x = 0.481437 * safezoneW + safezoneX;
			y = 0.665 * safezoneH + safezoneY;
			w = 0.221719 * safezoneW;
			h = 0.022 * safezoneH;
			class Attributes
			{
				font = "PuristaMedium";
				color = "#ffffff";
				colorLink = "#D09B43";
				align = "left";
				shadow = 1;
			};
		};
		class MRTMOtherText7: RscStructuredTextMRTM
		{
			idc = 1123;
			text = "";
			x = 0.481437 * safezoneW + safezoneX;
			y = 0.698 * safezoneH + safezoneY;
			w = 0.221719 * safezoneW;
			h = 0.022 * safezoneH;
			class Attributes
			{
				font = "PuristaMedium";
				color = "#ffffff";
				colorLink = "#D09B43";
				align = "left";
				shadow = 1;
			};
		};
		class MRTMOtherText8: RscStructuredTextMRTM
		{
			idc = 1124;
			text = "";
			x = 0.481437 * safezoneW + safezoneX;
			y = 0.731 * safezoneH + safezoneY;
			w = 0.221719 * safezoneW;
			h = 0.022 * safezoneH;
			class Attributes
			{
				font = "PuristaMedium";
				color = "#ffffff";
				colorLink = "#D09B43";
				align = "left";
				shadow = 1;
			};
		};
		class MRTMViewInfSlider: RscXSliderHMRTM
		{
			idc = 1125;
			text = "";
			onSliderPosChanged = "[0, _this select 1] call MRTM_fnc_onSliderChanged;";
			toolTip = "View Distance while on foot";
			x = 0.311063 * safezoneW + safezoneX;
			y = 0.3072 * safezoneH + safezoneY;
			w = 0.09525 * safezoneW;
			h = 0.025 * safezoneH;
		};
		class MRTMViewIGroundlider: RscXSliderHMRTM
		{
			idc = 1126;
			text = "";
			onSliderPosChanged = "[1, _this select 1] call MRTM_fnc_onSliderChanged;";
			toolTip = "View distance while in a ground vehicle";
			x = 0.311063 * safezoneW + safezoneX;
			y = 0.3446 * safezoneH + safezoneY;
			w = 0.09525 * safezoneW;
			h = 0.025 * safezoneH;
		};
		class MRTMViewAirSlider: RscXSliderHMRTM
		{
			idc = 1127;
			text = "";
			onSliderPosChanged = "[2, _this select 1] call MRTM_fnc_onSliderChanged;";
			toolTip = "View distance while in an aircraft";
			x = 0.311063 * safezoneW + safezoneX;
			y = 0.3842 * safezoneH + safezoneY;
			w = 0.09525 * safezoneW;
			h = 0.025 * safezoneH;
		};
		class MRTMViewDronesSlider: RscXSliderHMRTM
		{
			idc = 1128;
			text = "";
			onSliderPosChanged = "[4, _this select 1] call MRTM_fnc_onSliderChanged;";
			toolTip = "View distance while operating a UAV/UGV";
			x = 0.311063 * safezoneW + safezoneX;
			y = 0.4216 * safezoneH + safezoneY;
			w = 0.09525 * safezoneW;
			h = 0.025 * safezoneH;
		};
		class MRTMViewObjectsSlider: RscXSliderHMRTM
		{
			idc = 1129;
			text = "";
			onSliderPosChanged = "[3, _this select 1] call MRTM_fnc_onSliderChanged;";
			toolTip = "Objects rendering distance";
			x = 0.311063 * safezoneW + safezoneX;
			y = 0.5404 * safezoneH + safezoneY;
			w = 0.09525 * safezoneW;
			h = 0.025 * safezoneH;
		};
		class MRTMRWRPullUpSlider: RscXSliderHMRTM
		{
			idc = 1130;
			text = "";
			onSliderPosChanged = "[5, _this select 1] call MRTM_fnc_onSliderChanged;";
			toolTip = "Pull up warning volume";
			x = 0.536063 * safezoneW + safezoneX;
			y = 0.3072 * safezoneH + safezoneY;
			w = 0.12525 * safezoneW;
			h = 0.025 * safezoneH;
		};
		class MRTMRWRAltSlider: RscXSliderHMRTM
		{
			idc = 1131;
			text = "";
			onSliderPosChanged = "[6, _this select 1] call MRTM_fnc_onSliderChanged;";
			toolTip = "Altitude warning volume";
			x = 0.536063 * safezoneW + safezoneX;
			y = 0.3446 * safezoneH + safezoneY;
			w = 0.12525 * safezoneW;
			h = 0.025 * safezoneH;
		};
		class MRTMRWRWarningSlider: RscXSliderHMRTM
		{
			idc = 1132;
			text = "";
			onSliderPosChanged = "[7, _this select 1] call MRTM_fnc_onSliderChanged;";
			toolTip = "Alarm warning volume";
			onLoad =  "(_this # 0) ctrlEnable false;";
			x = 0.536063 * safezoneW + safezoneX;
			y = 0.3842 * safezoneH + safezoneY;
			w = 0.12525 * safezoneW;
			h = 0.025 * safezoneH;
		};
		class MRTMRWROtherSlider: RscXSliderHMRTM
		{
			idc = 1133;
			text = "";
			onSliderPosChanged = "[8, _this select 1] call MRTM_fnc_onSliderChanged;";
			toolTip = "Other warnings volume";
			x = 0.536063 * safezoneW + safezoneX;
			y = 0.4216 * safezoneH + safezoneY;
			w = 0.12525 * safezoneW;
			h = 0.025 * safezoneH;
		};
		class MRTMCloseButton: RscButtonMRTM
		{
			idc = 1604;
			text = "CLOSE";
			x = 0.267969 * safezoneW + safezoneX;
			y = 0.786 * safezoneH + safezoneY;
			w = 0.0567187 * safezoneW;
			h = 0.022 * safezoneH;
			font = "PuristaMedium";
			action =  "closeDialog 1";
		};
	};
};