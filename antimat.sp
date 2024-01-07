#include <sourcemod>

#pragma semicolon 1
#pragma newdecls required

int MuteTime[MAXPLAYERS];
int Mute[MAXPLAYERS];

char BadWords[][] = {
	"6ля",
	"6лядь", 
	"6лять",
	"b3ъeб",
	"cock",
	"cunt",
	"e6aль",
	"ebal",
	"eblan",
	"eбaл",
	"eбaть", 
	"eбyч",
	"eбать",
	"eбёт",
	"eблантий",
	"fuck",
	"fucker",
	"fucking",
	"xyёв",
	"xyй",
	"xyя",
	"xуе",
	"xуй",
	"xую",
	"zaeb",
	"zaebal", 
	"zaebali",
	"zaebat", 
	"ахуел",
	"ахуеть",
}; 
public void OnPluginStart() 
{ 
	HookEvent("player_say", OnPlayerText);
	CreateTimer (3.0 , SecondTimer,_, TIMER_REPEAT ); 
}
public Action SecondTimer(Handle timer, any client)
{
	if(MuteTime[client] > 0 && Mute[client] == 1)
	{
		MuteTime[client]--;
		if(MuteTime[client] == 1)
		{
			Mute[client] = 0;
			MuteTime[client] = 0;
			PrintToChat(client, "[SM-Chat]Вам включили чат. Пожалуйста больше не нарушайте правила.");
		}
	}
}
public Action OnPlayerText(Event event, const char[] name, bool dontBroadcast)
{
	int client = GetClientOfUserId(event.GetInt("userid"));
	char Text[35];
	event.GetString("text", Text, 35);
	if(Mute[client] == 1) { PrintToChat(client, "[SM-Chat]Ошибка: У Вас бан чата!"); return Plugin_Handled; }
	for(int Words; Words < sizeof(BadWords); Words++)
	if(StrEqual(Text, BadWords[Words]))
	{
		PrintToChat(client, "[SM-Chat]Игрок %N получил затычку на %d Секунд", client, MuteTime[client]);
		MuteTime[client] = 200;
		Mute[client] = 1;
	}
	return Plugin_Continue;
}