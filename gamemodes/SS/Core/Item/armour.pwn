public OnItemCreate(itemid)
{
	if(IsItemLoot(itemid))
	{
		if(GetItemType(itemid) == item_Armour)
		{
			SetItemExtraData(itemid, random(100) + 1);
		}
	}

	#if defined armour_OnItemCreate
		return armour_OnItemCreate(itemid);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnItemCreate
	#undef OnItemCreate
#else
	#define _ALS_OnItemCreate
#endif
 
#define OnItemCreate armour_OnItemCreate
#if defined armour_OnItemCreate
	forward armour_OnItemCreate(itemid);
#endif


public OnPlayerUseItem(playerid, itemid)
{
	if(GetItemType(itemid) == item_Armour)
	{
		if(GetPlayerAP(playerid) <= 0.0)
		{
			new data = GetItemExtraData(itemid);
			if(data > 0)
			{
				DestroyItem(itemid);
				SetPlayerAP(playerid, float(data));
			}
		}
	}
	#if defined armour_OnPlayerUseItem
		return armour_OnPlayerUseItem(playerid, itemid);
	#else
		return 0;
	#endif
}
#if defined _ALS_OnPlayerUseItem
	#undef OnPlayerUseItem
#else
	#define _ALS_OnPlayerUseItem
#endif
#define OnPlayerUseItem armour_OnPlayerUseItem
#if defined armour_OnPlayerUseItem
	forward armour_OnPlayerUseItem(playerid, itemid);
#endif

public OnItemNameRender(itemid, ItemType:itemtype)
{
	if(itemtype == item_Armour)
	{
		new
			amount = GetItemExtraData(itemid),
			str[11];

		format(str, sizeof(str), "%d", amount);
		
		SetItemNameExtra(itemid, str);
	}

	#if defined armour_OnItemNameRender
		return armour_OnItemNameRender(itemid, itemtype);
	#else
		return 0;
	#endif
}
#if defined _ALS_OnItemNameRender
	#undef OnItemNameRender
#else
	#define _ALS_OnItemNameRender
#endif
#define OnItemNameRender armour_OnItemNameRender
#if defined armour_OnItemNameRender
	forward armour_OnItemNameRender(itemid, ItemType:itemtype);
#endif


public OnPlayerShootPlayer(playerid, targetid, bodypart, Float:bleedrate, Float:knockmult, Float:bulletvelocity, Float:distance)
{
	if(bodypart == 3)
	{
		new Float:ap = GetPlayerAP(targetid);

		if(ap > 0.0)
		{
			new Float:penetration = GetAmmoTypePenetration(GetItemTypeAmmoType(GetItemWeaponItemAmmoItem(GetPlayerItem(playerid))));

			bleedrate *= penetration;

			SetPlayerAP(targetid, ap * (bleedrate * 10.0));

			DMG_FIREARM_SetBleedRate(targetid, bleedrate);

			return 1;
		}
	}

	#if defined armour_OnPlayerShootPlayer
		return armour_OnPlayerShootPlayer(playerid, targetid, bodypart, bleedrate, knockmult, bulletvelocity, distance);
	#else
		return 0;
	#endif
}
#if defined _ALS_OnPlayerShootPlayer
	#undef OnPlayerShootPlayer
#else
	#define _ALS_OnPlayerShootPlayer
#endif
 
#define OnPlayerShootPlayer armour_OnPlayerShootPlayer
#if defined armour_OnPlayerShootPlayer
	forward armour_OnPlayerShootPlayer(playerid, targetid, Float:bodypart, Float:bleedrate, Float:knockmult, Float:bulletvelocity, Float:distance);
#endif


new Float:ArmourSkinData[17][9]=
{
	{0.072999, 0.036000, 0.002999,  0.000000, 0.000000, 4.400002,  1.043000, 1.190000, 1.139000},		// skin_MainM
	{0.117000, 0.062000, 0.009000,  -1.199999, 0.500000, -3.199997,  1.043000, 1.101000, 0.895000},		// skin_MainF
	{0.072999, 0.036000, 0.002999,  0.000000, 0.000000, 4.400002,  1.043000, 1.190000, 1.139000},		// skin_Civ1M
	{0.073000, 0.052000, 0.009000,  -1.199999, -0.500000, 2.500002,  1.064000, 1.107001, 1.030000},		// skin_Civ2M
	{0.036000, 0.061999, 0.014999,  -1.199999, -0.500000, -1.399994,  0.967000, 1.180001, 0.912000},	// skin_Civ3M
	{0.082000, 0.061999, 0.003999,  -1.199999, -0.500000, -1.399994,  0.967000, 1.180001, 0.912000},	// skin_Civ4M
	{0.044000, 0.068999, -0.001000,  -1.199999, -1.900001, -1.399994,  1.248000, 1.539002, 1.128000},	// skin_MechM
	{0.064000, 0.049000, 0.005999,  -1.199999, -1.300001, -0.899995,  1.138000, 1.294001, 1.108000},	// skin_BikeM
	{0.064000, 0.022000, 0.005999,  -1.199999, -1.300001, 3.800003,  1.138000, 1.294001, 1.108000},		// skin_ArmyM
	{0.064000, 0.036000, 0.005999,  -1.199999, -1.300001, 2.100000,  1.138000, 1.399002, 1.265000},		// skin_ClawM
	{0.057999, 0.048000, 0.005999,  -0.299999, -0.800000, 2.399999,  1.138000, 1.419002, 1.072000},		// skin_FreeM
	{0.090999, 0.048000, 0.005999,  -0.299999, -0.800000, 2.399999,  1.231001, 1.234003, 0.998000},		// skin_Civ1F
	{0.117000, 0.062000, 0.009000,  -1.199999, 0.500000, -3.199997,  1.043000, 1.101000, 0.895000},		// skin_Civ2F
	{0.117000, 0.062000, 0.009000,  -1.199999, 0.500000, -3.199997,  1.043000, 1.101000, 0.895000},		// skin_Civ3F
	{0.117000, 0.062000, 0.009000,  -1.199999, 0.500000, -3.199997,  1.043000, 1.101000, 0.895000},		// skin_Civ4F
	{0.117000, 0.041000, 0.009000,  -1.199999, 0.500000, 2.500001,  1.064000, 1.067001, 0.965000},		// skin_ArmyF
	{0.089000, 0.079999, 0.009000,  -1.199999, 0.500000, -4.299999,  1.064000, 1.107001, 0.965000}		// skin_IndiF
};

ToggleArmour(playerid, bool:toggle)
{
	if(toggle)
	{
		new skin = GetPlayerClothes(playerid);

		SetPlayerAttachedObject(playerid, ATTACHSLOT_ARMOUR, 19515, 1,
			ArmourSkinData[skin][0], ArmourSkinData[skin][1], ArmourSkinData[skin][2],
			ArmourSkinData[skin][3], ArmourSkinData[skin][4], ArmourSkinData[skin][5],
			ArmourSkinData[skin][6], ArmourSkinData[skin][7], ArmourSkinData[skin][8]);
	}
	else
	{
		RemovePlayerAttachedObject(playerid, ATTACHSLOT_ARMOUR);
	}
}
