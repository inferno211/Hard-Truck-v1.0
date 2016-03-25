/*

	Zasady u¿ytkowania mapy:
	    1. Nie zmieniaj autora.
	    2. Nie udostêpniaj na inne fora/strony.
	    3. Mo¿esz j¹ edytowaæ dowolnie ale nie wystawiaj tych edycji do internetu.
	    4. Nie sprzedawaj mapy.

*/


//include

#include <a_samp>//podstawowa biblioteka sampa
#include <streamer>//streamer wszystkiego by incognito :)
#include <zcmd>//komendy zcmd
#include <O-Files>//szybkie zapisywanie i wczytywanie danych, autor: double-o-seven
#include <D-AntyCheat>//anty cheat by destroyer
#include <foreach>//szybkie petelki

//definy

	#define Sloty 50//sloty serwa
	#define WERSJA "XxX"//wersja mapy
	#define MAPNAME "San Andreas"//nazwa w zak³adce 'map'
	#define URL "xxx.pl"//nazwa w zak³adce 'url'
	
	#define UpperToLower(%1) for ( new ToLowerChar; ToLowerChar < strlen( %1 ); ToLowerChar ++ ) if ( %1[ ToLowerChar ]> 64 && %1[ ToLowerChar ] < 91 ) %1[ ToLowerChar ] += 32
	//kolory textow
    #define KOLOR_NIEWIDZIALNY 0xFFFFFF00
	#define KOLOR_BIALY 0xFFFFFFFF
	#define KOLOR_CZARNY 0x000000FF
	#define KOLOR_ZOLTY 0xFFFF00FF
	#define KOLOR_POMARANCZOWY 0xFF8040FF
	#define KOLOR_CZERWONY 0xFF2F2FFF
	#define KOLOR_ROZOWY 0xFF80FFFF
	#define KOLOR_NIEBIESKI 0x2B95FFFF
	#define KOLOR_BRAZOWY 0x9D4F4FFF
	#define KOLOR_ZIELONY 0x00FF40FF
	#define KOLOR_TURKUSOWY 0x00FFFFFF
	#define KOLOR_SZARY 0xC0C0C0FF
	#define KOLOR_FILOETOWY 0x800040FF
	#define KOLOR_BEZOWY 0xFFFFA6FF
	#define KOLOR_BORDOWY 0x800000FF
	
	//kolory do zmieniania w czacie,textcie 3d
	#define C_BIALY "{FFFFFF}"
	#define C_CZARNY "{000000}"
	#define C_ZOLTY "{FFFF00}"
	#define C_POMARANCZOWY "{FF7F50}"
	#define C_CZERWONY "{FF0000}"
	#define C_ROZOWY "{FF1493}"
	#define C_NIEBIESKI "{4169E1}"
	#define C_BRAZOWY "{A0522D}"
	#define C_ZIELONY "{ADFF2F}"
	#define C_TURKUSOWY "{00FFFF}"
	#define C_SZARY "{C0C0C0}"
	#define C_FILOETOWY "{BA55D3}"
	#define C_BEZOWY "{FFDEAD}"
	#define C_BORDOWY "{B22222}"
	
	#define SPAWN 999999999999//czas respawnu pojazdów
	
	//ogólne definy do systemów
	#define LIMIT_SAMOCHODOW 500
	#define LIMIT_LADUNKOW 100
	#define LIMIT_TEXTOW 100
	#define ILOSC_STACJI 20
	#define LIMIT_DOMOW 100
	
//newy

	//pojazdy
	new nazwypojazdow[212][32]=
	{
		"Landstalker","Bravura","Buffalo","Linerunner","Pereniel","Sentinel","Dumper","Firetruck","Trashmaster","Stretch","Manana",
		"Infernus","Voodoo","Pony","Mule","Cheetah","Ambulance","Leviathan","Moonbeam","Esperanto","Taxi","Washington","Bobcat",
		"Mr Whoopee","BF Injection","Hunter","Premier","Enforcer","Securicar","Banshee","Predator","Bus","Rhino","Barracks",
		"Hotknife","Trailer","Previon","Coach","Cabbie","Stallion","Rumpo","RC Bandit","Romero","Packer","Monster","Admiral",
		"Squalo","Seasparrow","Pizzaboy","Tram","Trailer","Turismo","Speeder","Reefer","Tropic","Flatbed","Yankee","Caddy",
		"Solair","Berkley's RC Van","Skimmer","PCJ-600","Faggio","Harley","RC Baron","RC Raider","Glendale","Oceanic",
		"Sanchez","Sparrow","Patriot","Quad","Coastguard","Dinghy","Hermes","Sabre","Rustler","ZR3 50","Walton","Regina",
		"Comet","BMX","Burrito","Camper","Marquis","Baggage","Dozer","Maverick","News Chopper","Rancher","FBI Rancher",
		"Virgo","Greenwood","Jetmax","Hotring","Sandking","Blista Compact","Police Maverick","Boxville","Benson","Mesa",
		"RC Goblin","Hotring Racer","Hotring Racer","Bloodring Banger","Rancher","Super GT","Elegant","Journey","Bike",
		"Mountain Bike","Beagle","Cropdust","Stunt","Tanker","RoadTrain","Nebula","Majestic","Buccaneer","Shamal","Hydra",
		"FCR-900","NRG-500","HPV1000","Cement Truck","Tow Truck","Fortune","Cadrona","FBI Truck","Willard","Forklift","Traktor",
		"Combine","Feltzer","Remington","Slamvan","Blade","Freight","Streak","Vortex","Vincent","Bullet","Clover","Sadler",
		"Firetruck","Hustler","Intruder","Primo","Cargobob","Tampa","Sunrise","Merit","Utility","Nevada","Yosemite","Windsor",
		"Monster","Monster","Uranus","Jester","Sultan","Stratum","Elegy","Raindance","RC Tiger","Flash","Tahoma","Savanna",
		"Bandito","Freight","Trailer","Kart","Mower","Duneride","Sweeper","Broadway","Tornado","AT-400","DFT-30","Huntley",
		"Stafford","BF-400","Newsvan","Tug","Trailer","Emperor","Wayfarer","Euros","Hotdog","Club","Trailer","Trailer",
		"Andromeda","Dodo","RC Cam","Launch","LS Police-Car","SF Police-Car","LV Police-Car","Police Rancher","Picador","SWAT Van",
		"Alpha","Phoenix","Glendale","Sadler","Luggage Trailer","Luggage Trailer","Stair Trailer","Boxville","Farm Plow","Utility Trailer"
	};
	new vPaliwo[LIMIT_SAMOCHODOW],
		vPaliwoMax[LIMIT_SAMOCHODOW],
		vLadownosc[LIMIT_SAMOCHODOW],vLadownoscMax[LIMIT_SAMOCHODOW],
		vCB[LIMIT_SAMOCHODOW],
		Text:Licznik[Sloty],
		Float:vPojazdZycie[MAX_VEHICLES];
		
    new PojazdPD[54];
    
    //ladunek
    enum ladunek
	{
		lAktywny,
		lTowar[64],//nazwa towaru
		Float:lTowarKoszt,//ile kasy dostajemy za 1 kg ladunku
		lZaladunek[64],//nazwa miejsca z ktorego bierzemy towar
		Float:lPosX,Float:lPosY,Float:lPosZ,
		lDostarczenie[64],//nazwa miejsca do ktorego dostarczamy towar
		Float:lPos2X,Float:lPos2Y,Float:lPos2Z,
	};
	new LadunekInfo[LIMIT_LADUNKOW][ladunek],
		bool:LadunekTworzenie=true,
		LadunekID[Sloty],LadunekPkt[Sloty];

	//texty3d
    enum txt
	{
		tAktywny,
		tNapis[64],
		Float:tPosX,Float:tPosY,Float:tPosZ,
	};
	new TextInfo[LIMIT_TEXTOW][txt],
        Text3D:TextNapis[LIMIT_TEXTOW],
		bool:TextTworzenie=true,
		TextID[Sloty],TextPkt[Sloty];


	//stacje paliw
	enum sInfo
	{
		Float:sCena,
		Float:sPosX,Float:sPosY,Float:sPosZ,Float:sOdleglosc,
	}
	new StacjaInfo[ILOSC_STACJI][sInfo];

	 //system domów
	enum dInfo
	{
		dAktywny,
		Float:dWejscieX,Float:dWejscieY,Float:dWejscieZ,dWejscieInt,dWejscieVir,
		Float:dWyjscieX,Float:dWyjscieY,Float:dWyjscieZ,dWyjscieInt,
		dWlasciciel[64],
		dOpis[64],
		dKupiony,
		dKoszt,
		dZamkniety,
	};

	new DomInfo[LIMIT_DOMOW][dInfo],
	    DomPickup[LIMIT_DOMOW],
		bool:DomTworzenie=true,
		DomID[Sloty],DomPkt[Sloty];

	//reszta
    enum pInfo
	{
		pHaslo[64],
		pKonto,
		pAdmin,
		pPremium,
		pJail,
		pWyciszony,
		pWarny,
		pPoziom,
		pDostarczenia,
		pScigany,
		pMandat,
		pKasa,
		pBank,
		pFrakcja,
		pLider,
		pDom,
		pWizyty,
		pMisja,
		pPosiadaneAuta,pMozliweAuta,
	    pAuto,pAuto2,pAuto3,pAuto4,pAuto5,
	};
	new PlayerInfo[Sloty][pInfo];

	new Text:NapisLadunek[Sloty],
		Text:NapisLevel[Sloty],
		bool:Zalogowany[Sloty],
		bool:Regulamin[Sloty],
		TankowanePaliwo[Sloty],
		bool:BlokadaPW[Sloty],
		bool:Lista[Sloty],
		Text:Napis,
	    NapisUzywany=0,
	    NapisTimer,
	    NaprawTimer[Sloty],
	    PaliwoTimer[Sloty],
	    MandatTimer[Sloty],
	    MandatPD[Sloty],
	    bool:Podglad=false,
		bool:Spec[Sloty],
		MuteTimer[Sloty];
		//misje
	new	bool:Misja[Sloty],
		MisjaID[Sloty],
		MisjaPojazd[Sloty],
		MisjaStopien[Sloty],
		bool:Przeladowany[Sloty],
		OstatniaMisja[Sloty];
		//kierunkowskazy
	new bool:Kierunkowskaz[Sloty],
		Text3D:Kierunek[Sloty];
		//blokady
	new Blokady=0,
		Blokadka[15];
		//kolczatki
	new	Kolczatki=0,
		bool:Kolczatka[5],
		KolczatkaObiekt[5],
		Float:KolPosX[5],Float:KolPosY[5],Float:KolPosZ[5];
		
	new Szlaban[8],SzlabanTimer[8],bool:SzlabanUzywany[8];

    new dstring[200],
		Godzina;
		
	//NEWY DO TIMERÓW
	
	//do licznika
	new lPojazd,
		Float:lPojazdHP,
		lText[7],
		engine,lights,alarm,doors,bonnet,boot,objective;
		
	new PaliwoLicznik=0;
	//
	new mstr[20];//ma³y string

//podstawowe callbaki samp

main()//funkcja wyswietlajaca wiadomosc poczatkowa
{
	printf(" \n\n\n%s\nby Inferno\n\n\n ",WERSJA);
}

public OnGameModeInit()
{
//podstawowe ustw.
    new str[30];
	format(str,sizeof(str),"%s",WERSJA);
    SetGameModeText(str);//zmienia nazwe gamemode
    format(str,sizeof(str),"mapname %s",MAPNAME);
    SendRconCommand(str);//zmienia nazwe mapname
	format(str,sizeof(str),"weburl %s",URL);
	SendRconCommand(str);//zmienia weburl
	
	Godzina=6;
	SetWorldTime(Godzina);//ustawia godzine
	AllowInteriorWeapons(true);//bronie w budynkach
	DisableInteriorEnterExits();//usuwa teleporty do interiorow
	EnableStuntBonusForAll(false);//nie dodaje kasy za stunt
	ShowPlayerMarkers(true);//wyswietla graczy na mapie
	ShowNameTags(true);//wyswietla nick
	SetNameTagDrawDistance(25);//odlegosc widzenia nicku
	
	Szlaban[0]=CreateObject(968, 1737.2573242188, 527.54992675781, 27.4, 0, 270.0, 342.0);
	SzlabanUzywany[0]=false;
	Szlaban[1]=CreateObject(968, 1747.2440185547, 538.67596435547, 26.6, 0, 90.0, 342.0);
	SzlabanUzywany[1]=false;
	Szlaban[2]=CreateObject(968, -1653.5545654297, 574.41876220703, 39.123199462891, 0, 90.0, 316.5);
	SzlabanUzywany[2]=false;
	Szlaban[3]=CreateObject(968, -1628.6497802734, 569.43347167969, 39.624629974365, 0, 270.0, 313.99996948242);
	SzlabanUzywany[3]=false;
	Szlaban[4]=CreateObject(968, -2671.6857910156, 1285.1840820313, 55.327934265137, 0, 90, 0);
	SzlabanUzywany[4]=false;
	Szlaban[5]=CreateObject(968, -2673.1394042969, 1285.1458740234, 55.326545715332, 0, 270.0, 0);
	SzlabanUzywany[5]=false;
	Szlaban[6]=CreateObject(968, -2689.8010253906, 1264.5959472656, 55.353748321533, 0, 90, 0);
	SzlabanUzywany[6]=false;
	Szlaban[7]=CreateObject(968, -2691.2211914063, 1264.6124267578, 55.319801330566, 0, 270.0, 358.25);
	SzlabanUzywany[7]=false;

//timery
    DestACOn();//uruchamia mojego anty cheata
    SetTimer("LicznikTimer",500,true);
    SetTimer("PaliwoMinus",20000,true);
    SetTimer("CoMinute",60000,true);//co minute
    SetTimer("ZmienCzas",60000*5,true);//co 5 minut
	
//skiny
	//trukerzy
	AddPlayerClass(15, -189.6111,-307.9127,2.4297,315.3905, 0, 0, 0, 0, 0, 0);//0
	AddPlayerClass(183, -189.6111,-307.9127,2.4297,315.3905, 0, 0, 0, 0, 0, 0);//1
	AddPlayerClass(206, -189.6111,-307.9127,2.4297,315.3905, 0, 0, 0, 0, 0, 0);//2
	AddPlayerClass(234, -189.6111,-307.9127,2.4297,315.3905, 0, 0, 0, 0, 0, 0);//3
	AddPlayerClass(25, -189.6111,-307.9127,2.4297,315.3905, 0, 0, 0, 0, 0, 0);//4
	AddPlayerClass(261, -189.6111,-307.9127,2.4297,315.3905, 0, 0, 0, 0, 0, 0);//5
	AddPlayerClass(133, -189.6111,-307.9127,2.4297,315.3905, 0, 0, 0, 0, 0, 0);//6
	AddPlayerClass(159, -189.6111,-307.9127,2.4297,315.3905, 0, 0, 0, 0, 0, 0);//7
	//babki
	AddPlayerClass(198, -189.6111,-307.9127,2.4297,315.3905, 0, 0, 0, 0, 0, 0);//8
	AddPlayerClass(131, -189.6111,-307.9127,2.4297,315.3905, 0, 0, 0, 0, 0, 0);//9
	//pd
	AddPlayerClass(280, -189.6111,-307.9127,2.4297,315.3905, 0, 0, 0, 0, 0, 0);//10
	AddPlayerClass(282, -189.6111,-307.9127,2.4297,315.3905, 0, 0, 0, 0, 0, 0);//11
	AddPlayerClass(283, -189.6111,-307.9127,2.4297,315.3905, 0, 0, 0, 0, 0, 0);//12
	AddPlayerClass(265, -189.6111,-307.9127,2.4297,315.3905, 0, 0, 0, 0, 0, 0);//13
	AddPlayerClass(266, -189.6111,-307.9127,2.4297,315.3905, 0, 0, 0, 0, 0, 0);//14
	AddPlayerClass(284, -189.6111,-307.9127,2.4297,315.3905, 0, 0, 0, 0, 0, 0);//15
	
//ikony
	//posterunki
    CreateDynamicMapIcon(1579.4962,-1635.2378,13.5614,30,1,-1,-1,-1,100.0);
	CreateDynamicMapIcon(-1616.4871,683.1292,7.1875,30,1,-1,-1,-1,100.0);
	CreateDynamicMapIcon(2251.7036,2488.9546,10.9908,30,1,-1,-1,-1,100.0);
 	//miejsca z tirami
	CreateDynamicMapIcon(2326.9631,2785.5002,10.8203,51,1,-1,-1,-1,300.0);
	CreateDynamicMapIcon(1636.6249,1038.6071,10.8203,51,1,-1,-1,-1,300.0);
	CreateDynamicMapIcon(252.8059,1354.8419,10.7075,51,1,-1,-1,-1,300.0);
	CreateDynamicMapIcon(-49.9214,-277.7625,5.4297,51,1,-1,-1,-1,300.0);
	CreateDynamicMapIcon(-501.8290,-518.0654,25.5234,51,1,-1,-1,-1,300.0);
	CreateDynamicMapIcon(-1710.3651,403.0952,7.4190,51,1,-1,-1,-1,300.0);
	CreateDynamicMapIcon(-79.4036,-1135.6272,1.0781,51,1,-1,-1,-1,300.0);
	//ikony pcn
	CreateDynamicMapIcon(-1328.6442,2677.4944,49.7787,55,1,-1,-1,-1,300.0);
	CreateDynamicMapIcon(-737.3889,2742.2444,46.8992,55,1,-1,-1,-1,300.0);
	CreateDynamicMapIcon(-1475.6040,1863.6361,32.3494,55,1,-1,-1,-1,300.0);
	CreateDynamicMapIcon(70.2113,1218.4081,18.5282,55,1,-1,-1,-1,300.0);
	CreateDynamicMapIcon(611.5366,1694.5262,6.7086,55,1,-1,-1,-1,300.0);
	CreateDynamicMapIcon(1596.3970,2197.1189,10.5371,55,1,-1,-1,-1,300.0);
	CreateDynamicMapIcon(2199.8953,2477.1919,10.5369,55,1,-1,-1,-1,300.0);
	CreateDynamicMapIcon(2640.4731,1104.9952,10.5366,55,1,-1,-1,-1,300.0);
	CreateDynamicMapIcon(2115.5632,923.1831,10.5362,55,1,-1,-1,-1,300.0);
	CreateDynamicMapIcon(1380.8798,456.7491,19.6220,55,1,-1,-1,-1,300.0);
	CreateDynamicMapIcon(652.3244,-569.8619,16.0465,55,1,-1,-1,-1,300.0);
	CreateDynamicMapIcon(1003.0161,-939.9588,41.8959,55,1,-1,-1,-1,300.0);
	CreateDynamicMapIcon(1944.4365,-1773.8070,13.1072,55,1,-1,-1,-1,300.0);
	CreateDynamicMapIcon(-89.2281,-1164.0281,2.0001,55,1,-1,-1,-1,300.0);
	CreateDynamicMapIcon(-1606.3033,-2713.9014,48.2523,55,1,-1,-1,-1,300.0);
	CreateDynamicMapIcon(-2244.0728,-2560.5244,31.6372,55,1,-1,-1,-1,300.0);
	CreateDynamicMapIcon(-2029.6616,157.3720,28.5526,55,1,-1,-1,-1,300.0);
	CreateDynamicMapIcon(-2414.1677,976.4759,45.0135,55,1,-1,-1,-1,300.0);
	CreateDynamicMapIcon(2150.0823,2748.0471,10.8203,55,1,-1,-1,-1,300.0);
	CreateDynamicMapIcon(-1674.9819,413.9892,7.1797,55,1,-1,-1,-1,300.0);
	
//pojazdy
	//pd
	PojazdPD[0]=CreateVehicle(596,1535.8595,-1677.6045,13.1036,0.6691,0,1,SPAWN); // radiolka ls
	PojazdPD[1]=CreateVehicle(596,1535.8490,-1669.8567,13.1057,0.5806,0,1,SPAWN); // radiolka ls
	PojazdPD[2]=CreateVehicle(596,1553.5682,-1632.9940,13.1822,90.5368,0,1,SPAWN); // radiolka ls
	PojazdPD[3]=CreateVehicle(596,1561.2012,-1632.9869,13.1878,89.2971,0,1,SPAWN); // radiolka ls
	PojazdPD[4]=CreateVehicle(596,1568.8024,-1632.9556,13.1861,90.0242,0,1,SPAWN); // radiolka ls
	PojazdPD[5]=CreateVehicle(525,1602.0361,-1628.8164,13.3562,74.0632,17,20,SPAWN); // radiolka ls
	PojazdPD[6]=CreateVehicle(596,1601.0028,-1688.2845,5.6106,89.1293,0,1,SPAWN); // radiolka ls
	PojazdPD[7]=CreateVehicle(490,1591.5991,-1710.2405,6.0176,0.0099,0,0,SPAWN); // radiolka ls
	PojazdPD[8]=CreateVehicle(601,1564.6193,-1710.0569,5.6494,2.0163,1,1,SPAWN); // radiolka ls
	PojazdPD[9]=CreateVehicle(596,1583.3732,-1710.0828,5.6123,179.5872,0,1,SPAWN); // radiolka ls
	PojazdPD[10]=CreateVehicle(523,1570.3691,-1709.8611,5.4654,1.3558,0,0,SPAWN); // radiolka ls
	PojazdPD[11]=CreateVehicle(523,1529.1710,-1688.2858,5.4560,97.2781,0,0,SPAWN); // radiolka ls
	PojazdPD[12]=CreateVehicle(523,1545.0299,-1680.6382,5.4603,264.1258,0,0,SPAWN); // radiolka ls
	PojazdPD[13]=CreateVehicle(490,1544.1602,-1667.9886,6.0170,89.5398,0,0,SPAWN); // radiolka ls
	PojazdPD[14]=CreateVehicle(599,1534.9270,-1645.4351,6.0827,0.4272,0,1,SPAWN); // radiolka ls
	PojazdPD[15]=CreateVehicle(599,1600.5369,-1700.2015,6.0784,269.6635,0,1,SPAWN); // radiolka ls
	PojazdPD[16]=CreateVehicle(427,1574.3175,-1709.9724,6.0225,359.9049,0,1,SPAWN); // radiolka ls
	PojazdPD[17]=CreateVehicle(428,1560.9229,-1694.5189,6.0191,195.1910,4,75,SPAWN); // radiolka ls
	PojazdPD[18]=CreateVehicle(523,-1606.7234,673.4042,6.7625,3.6781,0,0,SPAWN); // radiolka sf
	PojazdPD[19]=CreateVehicle(597,-1616.5729,652.1138,6.9554,359.9629,0,1,SPAWN); // radiolka sf
	PojazdPD[20]=CreateVehicle(597,-1599.8966,673.1458,6.9550,182.4025,0,1,SPAWN); // radiolka sf
	PojazdPD[21]=CreateVehicle(597,-1587.8578,651.7653,6.9567,180.2641,0,1,SPAWN); // radiolka sf
	PojazdPD[22]=CreateVehicle(525,-1576.9912,682.2624,7.0516,184.7334,18,20,SPAWN); // radiolka sf
	PojazdPD[23]=CreateVehicle(523,-1588.0481,673.5182,6.7579,188.2290,0,0,SPAWN); // radiolka sf
	PojazdPD[24]=CreateVehicle(599,-1593.4875,652.7487,7.3757,0.2005,0,1,SPAWN); // radiolka sf
	PojazdPD[25]=CreateVehicle(497,-1680.5658,705.8715,30.7779,92.7934,0,1,SPAWN); // radiolka sf
	PojazdPD[26]=CreateVehicle(597,-1596.3290,747.8721,-5.4718,177.9430,0,1,SPAWN); // radiolka sf
	PojazdPD[27]=CreateVehicle(490,-1574.2036,726.6471,-5.1149,90.7364,0,0,SPAWN); // radiolka sf
	PojazdPD[28]=CreateVehicle(601,-1574.1276,712.9396,-5.4834,86.9524,1,1,SPAWN); // radiolka sf
	PojazdPD[29]=CreateVehicle(597,-1596.1788,677.4681,-5.4742,0.6799,0,1,SPAWN); // radiolka sf
	PojazdPD[30]=CreateVehicle(523,-1603.9474,692.2616,-5.6732,190.2440,0,0,SPAWN); // radiolka sf
	PojazdPD[31]=CreateVehicle(490,-1638.5327,682.4286,-5.1146,89.7329,0,0,SPAWN); // radiolka sf
	PojazdPD[32]=CreateVehicle(599,-1638.3391,657.7626,-5.0527,270.1786,0,1,SPAWN); // radiolka sf
	PojazdPD[33]=CreateVehicle(427,-1616.3964,692.0798,-5.1103,181.9251,0,1,SPAWN); // radiolka sf
	PojazdPD[34]=CreateVehicle(428,-1589.7473,708.7147,-5.1151,292.4364,4,75,SPAWN); // radiolka sf
	PojazdPD[35]=CreateVehicle(523,-1588.2061,748.4335,-5.6718,5.4458,0,0,SPAWN); // radiolka sf
	PojazdPD[36]=CreateVehicle(599,-1575.0503,742.8077,-5.0520,267.8380,0,1,SPAWN); // radiolka sf
	PojazdPD[37]=CreateVehicle(599,2256.1758,2458.4834,11.0125,0.5368,0,1,SPAWN); // radiolka lv
	PojazdPD[38]=CreateVehicle(598,2251.7197,2444.0247,10.5679,359.4433,0,1,SPAWN); // radiolka lv
	PojazdPD[39]=CreateVehicle(523,2281.6619,2459.0173,10.3891,171.9162,0,0,SPAWN); // radiolka lv
	PojazdPD[40]=CreateVehicle(598,2269.7434,2477.4636,10.5672,0.8608,0,1,SPAWN); // radiolka lv
	PojazdPD[41]=CreateVehicle(523,2291.2727,2477.6165,10.3846,172.9162,0,0,SPAWN); // radiolka lv
	PojazdPD[42]=CreateVehicle(598,2313.8579,2484.7241,3.0175,270.0874,0,1,SPAWN); // radiolka lv
	PojazdPD[43]=CreateVehicle(599,2285.6680,2474.7322,3.4685,180.7034,0,1,SPAWN); // radiolka lv
	PojazdPD[44]=CreateVehicle(599,2240.4846,2457.1079,3.4616,269.9743,0,1,SPAWN); // radiolka lv
	PojazdPD[45]=CreateVehicle(490,2304.0479,2432.0356,3.4060,179.6371,0,0,SPAWN); // radiolka lv
	PojazdPD[46]=CreateVehicle(490,2250.9258,2431.4807,3.3995,358.9195,0,0,SPAWN); // radiolka lv
	PojazdPD[47]=CreateVehicle(523,2259.5103,2430.6716,2.8285,186.0534,0,0,SPAWN); // radiolka lv
	PojazdPD[48]=CreateVehicle(601,2225.5059,2458.5645,-7.6950,245.6473,1,1,SPAWN); // radiolka lv
	PojazdPD[49]=CreateVehicle(427,2250.9900,2431.8149,-7.3214,359.5583,0,1,SPAWN); // radiolka lv
	PojazdPD[50]=CreateVehicle(428,2315.1401,2455.7002,-7.3277,270.2557,4,75,SPAWN); // radiolka lv
	PojazdPD[51]=CreateVehicle(490,2298.7190,2464.2273,-7.3227,89.0187,0,0,SPAWN); // radiolka lv
	PojazdPD[52]=CreateVehicle(598,2313.6416,2484.8096,-7.7101,270.3753,0,1,SPAWN); // radiolka lv
	PojazdPD[53]=CreateVehicle(525,2269.2446,2442.9150,10.6967,0.1754,22,30,SPAWN); // radiolka lv
	
	//ciê¿arowki i busy
	CreateVehicle(414,2311.0071,2763.9890,10.9140,90.2121,28,1,SPAWN); // bus
	CreateVehicle(499,2295.8572,2748.2329,10.8130,271.4996,109,32,SPAWN); // bus
	CreateVehicle(609,2295.3965,2754.5676,10.8857,270.5961,36,36,SPAWN); // bus
	CreateVehicle(609,2347.0491,2754.1199,10.8871,269.8410,36,36,SPAWN); // bus
	CreateVehicle(414,2347.8394,2770.8708,10.9135,269.2453,43,1,SPAWN); // bus
	CreateVehicle(456,2347.8459,2779.8958,10.9939,269.6905,91,63,SPAWN); // bus
	CreateVehicle(499,2400.3853,2754.8801,10.8088,180.5168,112,32,SPAWN); // bus
	CreateVehicle(456,2259.7896,2763.6418,10.9942,90.3634,102,65,SPAWN); // bus
	CreateVehicle(609,2260.7993,2747.9197,10.8869,89.3076,36,36,SPAWN); // bus
	CreateVehicle(482,2311.6440,2770.2808,10.9420,90.1025,48,48,SPAWN); // bus
	CreateVehicle(482,2368.1650,2754.0090,10.9329,182.0930,52,52,SPAWN); // bus
	CreateVehicle(403,2317.8159,2804.8123,11.4265,180.4881,30,1,SPAWN); // tir
	CreateVehicle(514,2337.5222,2805.1755,11.4103,179.4931,25,1,SPAWN); // tir
	CreateVehicle(515,2342.9092,2805.0005,11.8441,180.7084,24,77,SPAWN); // tir
	CreateVehicle(515,2347.7495,2804.9570,11.8459,180.0310,63,78,SPAWN); // tir
	CreateVehicle(435,2307.6084,2815.1992,10.9447,180.3318,71,71,SPAWN); // przyczepka
	CreateVehicle(591,2312.1775,2815.2847,10.9332,179.9018,64,64,SPAWN); // przyczepka
	CreateVehicle(435,2303.6321,2815.1543,10.9406,180.0920,85,85,SPAWN); // przyczepka
	CreateVehicle(591,2299.9846,2814.9185,10.9340,180.6121,10,10,SPAWN); // przyczepka
	CreateVehicle(456,1665.2975,1028.1313,10.9941,180.1994,105,72,SPAWN); // tir
	CreateVehicle(499,1668.2421,999.9714,10.8125,0.7830,10,32,SPAWN); // bus
	CreateVehicle(609,1677.8937,1038.9404,10.8894,0.2504,36,36,SPAWN); // bus
	CreateVehicle(414,1655.1812,1039.5575,10.9140,180.1107,67,1,SPAWN); // bus
	CreateVehicle(482,1658.4481,1039.5607,10.9435,180.1298,41,41,SPAWN); // bus
	CreateVehicle(482,1677.6862,988.4897,10.9369,180.8095,62,62,SPAWN); // bus
	CreateVehicle(514,1635.6238,984.7650,11.4158,269.2711,28,1,SPAWN); // tir
	CreateVehicle(514,1635.7374,980.0479,11.4123,268.9646,36,1,SPAWN); // tir
	CreateVehicle(403,1634.6945,958.8669,11.3781,270.2846,25,1,SPAWN); // tir
	CreateVehicle(403,1634.8462,963.1311,11.4175,267.4902,28,1,SPAWN); // tir
	CreateVehicle(515,1631.0264,1056.5179,11.8412,270.2427,54,77,SPAWN); // tor
	CreateVehicle(515,1631.1403,1051.6240,11.8455,270.5518,42,76,SPAWN); // tir
	CreateVehicle(435,1668.0574,1084.7648,10.9439,179.3968,48,48,SPAWN); // przyczepka
	CreateVehicle(435,1673.1671,1084.9673,10.9447,180.0114,52,52,SPAWN); // przyczepka
	CreateVehicle(591,1663.3488,1084.5458,10.9368,179.6583,64,64,SPAWN); // przyczepka
	CreateVehicle(591,1701.4664,1045.0643,10.9451,90.0509,71,71,SPAWN); // przyczepka
	CreateVehicle(435,1701.5645,1039.9934,10.9408,92.6422,10,10,SPAWN); // przyczepka
	CreateVehicle(435,1701.6602,1034.9216,10.9362,91.0510,85,85,SPAWN); // przyczepka
	CreateVehicle(515,280.9649,1339.0770,11.5953,90.3783,11,76,SPAWN); // tir
	CreateVehicle(515,281.1323,1344.1147,11.6088,89.6267,39,78,SPAWN); // tir
	CreateVehicle(403,281.1361,1348.8962,11.1930,89.4511,113,1,SPAWN); // tir
	CreateVehicle(403,281.2014,1352.9846,11.1931,90.0113,101,1,SPAWN); // tir
	CreateVehicle(435,281.0659,1359.0925,10.7061,90.0978,62,62,SPAWN); // przyczepka
	CreateVehicle(435,281.2307,1363.4637,10.7072,89.6200,41,41,SPAWN); // przyczepka
	CreateVehicle(435,281.2249,1368.0638,10.7111,89.8796,48,48,SPAWN); // przyczepka
	CreateVehicle(435,281.6437,1372.7913,10.7061,89.1569,52,52,SPAWN); // przyczepka
	CreateVehicle(456,281.7934,1378.2223,10.7591,88.9489,110,93,SPAWN); // bus
	CreateVehicle(414,281.2166,1382.9561,10.6797,90.5572,72,1,SPAWN); // bus
	CreateVehicle(499,281.1668,1387.2590,10.5768,91.2498,30,44,SPAWN); // bus
	CreateVehicle(482,281.8506,1391.4460,10.7046,94.2692,71,71,SPAWN); // bus
	CreateVehicle(482,281.5196,1395.7723,10.7028,90.8613,64,64,SPAWN); // bus
	CreateVehicle(499,-60.4430,-307.3835,5.4215,269.0612,32,52,SPAWN); // bus
	CreateVehicle(414,-61.5061,-318.0318,5.5235,90.8284,9,1,SPAWN); // bus
	CreateVehicle(609,-30.6578,-279.9072,5.4936,90.8196,36,36,SPAWN); // bus
	CreateVehicle(482,-30.2935,-293.8136,5.5443,269.7084,85,85,SPAWN); // bus
	CreateVehicle(514,-2.2432,-304.7859,6.0134,89.3857,54,1,SPAWN); // tir
	CreateVehicle(514,-2.3283,-308.8102,6.0138,90.9112,40,1,SPAWN); // tir
	CreateVehicle(515,-1.8840,-313.6975,6.4484,90.6338,13,76,SPAWN); // tir
	CreateVehicle(515,-1.8206,-318.5291,6.4498,91.8417,24,77,SPAWN); // tir
	CreateVehicle(403,-2.1220,-323.1804,6.0360,90.0182,37,1,SPAWN); // tir
	CreateVehicle(403,-1.9556,-327.3929,6.0353,89.8897,36,1,SPAWN); // tir
	CreateVehicle(435,-1.9019,-333.0806,5.5484,89.1492,10,10,SPAWN); // przyczepka
	CreateVehicle(435,-2.4786,-336.4034,5.5548,90.1768,10,10,SPAWN); // przyczepka
	CreateVehicle(591,-2.9942,-339.7986,5.5504,89.6660,10,10,SPAWN); // przyczepka
	CreateVehicle(591,-3.1092,-343.4930,5.5493,90.4812,10,10,SPAWN); // przyczepka
	CreateVehicle(591,-3.4045,-346.8654,5.5421,89.5194,10,10,SPAWN); // przyczepka
	CreateVehicle(435,-3.4633,-350.5401,5.5456,89.1490,10,10,SPAWN); // przyczepka
	CreateVehicle(514,-475.3481,-487.7929,26.1025,179.8293,113,1,SPAWN); // tir
	CreateVehicle(514,-480.1838,-487.8595,26.1111,179.7600,75,1,SPAWN); // tir
	CreateVehicle(414,-520.2507,-502.4152,24.9474,359.3402,95,1,SPAWN); // bus
	CreateVehicle(403,-485.2526,-487.6130,26.1240,179.0935,30,1,SPAWN); // tir
	CreateVehicle(403,-490.3285,-487.6574,26.1248,179.6279,28,1,SPAWN); // tir
	CreateVehicle(435,-481.5328,-539.3635,25.6475,89.1427,62,62,SPAWN); // przyczepka
	CreateVehicle(591,-481.3817,-535.1353,25.6458,90.2982,41,41,SPAWN); // przyczepka
	CreateVehicle(435,-481.4117,-529.9183,25.6423,88.8686,48,48,SPAWN); // przyczepka
	CreateVehicle(435,-471.9379,-524.3510,25.6412,89.3235,52,52,SPAWN); // przyczepka
	CreateVehicle(499,-514.8950,-471.8510,25.5150,357.2408,84,66,SPAWN); // bus
	CreateVehicle(482,-529.7975,-498.9450,25.2568,0.3225,64,64,SPAWN); // przyczepka
	CreateVehicle(482,-557.5793,-497.9398,25.3433,359.2647,71,71,SPAWN); // przyczepka
	CreateVehicle(515,-548.0521,-499.2165,26.5318,1.1971,63,78,SPAWN); // tir
	CreateVehicle(515,-542.2838,-499.1769,26.5412,359.5015,42,76,SPAWN); // tir
	CreateVehicle(482,-1716.5682,394.2632,7.3023,227.1302,85,85,SPAWN); // bus
	CreateVehicle(414,-1714.4014,396.7476,7.2734,225.8878,24,1,SPAWN); // bus
	CreateVehicle(456,-1699.2637,412.0785,7.3541,223.0623,121,93,SPAWN); // bus
	CreateVehicle(403,-1674.1497,436.8432,7.7857,224.8543,25,1,SPAWN); // tir
	CreateVehicle(514,-1670.7048,440.2315,7.7730,226.1244,10,1,SPAWN); // tir
	CreateVehicle(515,-1667.4596,444.1543,8.2065,224.7720,54,77,SPAWN); // tir
	CreateVehicle(435,-1663.1475,446.9085,7.2996,222.8381,10,10,SPAWN); // przyczepka
	CreateVehicle(435,-1660.0369,450.3135,7.3042,223.8612,62,62,SPAWN); // przyczepka
	CreateVehicle(591,-1656.8699,453.6613,7.3047,226.9082,41,41,SPAWN); // przyczepka
	CreateVehicle(403,-55.4870,-1133.0015,1.6841,67.9868,101,1,SPAWN); // tir
	CreateVehicle(514,-57.6327,-1137.7991,1.6608,67.4059,25,1,SPAWN); // tir
	CreateVehicle(515,-59.1611,-1142.9742,2.0982,66.5671,39,78,SPAWN); // tir
	CreateVehicle(591,-44.4431,-1137.0759,1.1960,70.4657,48,48,SPAWN); // przyczepka
	CreateVehicle(435,-44.8744,-1142.7460,1.2009,70.4315,48,48,SPAWN); // przyczepka
	CreateVehicle(435,-46.1187,-1148.4441,1.1939,68.3204,48,48,SPAWN); // przyczepka
//textdrawy
	for(new p = 0; p < Sloty; p++)
	{
		Licznik[p] = TextDrawCreate(536.000000,399.000000," ");
		TextDrawUseBox(Licznik[p],1);
		TextDrawBoxColor(Licznik[p],0x00000066);
		TextDrawTextSize(Licznik[p],636.000000,0.000000);
		TextDrawAlignment(Licznik[p],0);
		TextDrawFont(Licznik[p],1);
		TextDrawLetterSize(Licznik[p],0.199999,1.000000);
		TextDrawColor(Licznik[p],0xffffffff);
		TextDrawSetOutline(Licznik[p],1);
		TextDrawSetProportional(Licznik[p],1);
		TextDrawSetShadow(Licznik[p],1);
		NapisLadunek[p] = TextDrawCreate(5.000000,435.000000," ");
		NapisLevel[p] = TextDrawCreate(4.000000,423.000000," ");
		TextDrawUseBox(NapisLadunek[p],1);
		TextDrawBoxColor(NapisLadunek[p],0x00000066);
		TextDrawTextSize(NapisLadunek[p],531.000000,0.000000);
		TextDrawAlignment(NapisLadunek[p],0);
		TextDrawAlignment(NapisLevel[p],0);
		TextDrawBackgroundColor(NapisLadunek[p],0x000000ff);
		TextDrawBackgroundColor(NapisLevel[p],0x000000ff);
		TextDrawFont(NapisLadunek[p],1);
		TextDrawLetterSize(NapisLadunek[p],0.199999,1.000000);
		TextDrawFont(NapisLevel[p],3);
		TextDrawLetterSize(NapisLevel[p],0.399999,1.000000);
		TextDrawColor(NapisLadunek[p],0xffffffff);
		TextDrawColor(NapisLevel[p],0xffffffff);
		TextDrawSetOutline(NapisLadunek[p],1);
		TextDrawSetOutline(NapisLevel[p],1);
		TextDrawSetProportional(NapisLadunek[p],1);
		TextDrawSetProportional(NapisLevel[p],1);
		TextDrawSetShadow(NapisLadunek[p],1);
		TextDrawSetShadow(NapisLevel[p],1);
	}

	Napis = TextDrawCreate(38.000000,309.000000," ");
	TextDrawAlignment(Napis,0);
	TextDrawBackgroundColor(Napis,0x000000ff);
	TextDrawFont(Napis,1);
	TextDrawLetterSize(Napis,0.199999,1.000000);
	TextDrawColor(Napis,0xffffffff);
	TextDrawSetOutline(Napis,1);
	TextDrawSetProportional(Napis,1);
	TextDrawSetShadow(Napis,1);
	
//petla na pojazdy
	for(new nr = 1; nr < LIMIT_SAMOCHODOW; nr++)
	{
		SetVehicleParamsEx(nr,false,false,false,false,false,false,false);
		if(nr>54) vCB[nr]=19;
		UstalPaliwo(nr);
		UstalLadownosc(nr);
		vPojazdZycie[nr]=1000.0;
	}

//wczytuje wszystkie dane
	WczytajStacje();
	WczytajLadunki();
	WczytajTexty();
	WczytajDomy();
	return 1;
}

public OnGameModeExit()
{
    DestACOff();
    DOF_Exit();
	return 1;
}

//timery

forward ZmienCzas();
public ZmienCzas()
{
    SendClientMessageToAll(KOLOR_ZOLTY,"Limity prêdkoœci: "C_BIALY"Autostrady: "C_CZERWONY" 130 km/h "C_BIALY"Obszar niezabudowany: "C_CZERWONY"90 km/h "C_BIALY"Obszar zabudowany: "C_CZERWONY"50 km/h");
	Godzina++;
	if(Godzina>24)
	{
	     Godzina=1;
	}
	SetWorldTime(Godzina);
	new p=random(11);
	switch(p)
	{
	    case 0: SetWeather(0);
	    case 1: SetWeather(3);
	    case 2: SetWeather(6);
	    case 3: SetWeather(8);
	    case 4: SetWeather(9);
	    case 5: SetWeather(16);
	    case 6: SetWeather(19);
	    case 7: SetWeather(12);
	    case 8: SetWeather(13);
	    case 9: SetWeather(15);
	    case 10: SetWeather(10);
	}
	format(mstr,sizeof(mstr),"~r~%d:00",Godzina);
	GameTextForAll(mstr,5000,1);
	return 1;
}

forward CoMinute();
public CoMinute()
{
	foreach(Player,i)
	{
	    if(Zalogowany[i]==true)
	    {
	        if(PlayerInfo[i][pJail]>=1)
	        {
	            PlayerInfo[i][pJail]--;
	            if(PlayerInfo[i][pJail]<1)
	            {
	                PlayerInfo[i][pJail]=0;
   					SetPlayerWorldBounds(i, 20000.0000, -20000.0000, 20000.0000, -20000.0000);
   					CallLocalFunction("OnPlayerSpawn", "i",i);
	            }
				else
				{
	            	format(mstr, sizeof(mstr), "~w~jail: ~r~%d min",PlayerInfo[i][pJail]);
	            	GInfo(i,mstr,1);
				}
	        }
	        ZapiszKonto(i);
	    }//jesli gracz jest zalogowany
	}
	return 1;
}

forward PaliwoMinus();
public PaliwoMinus()
{
	PaliwoLicznik++;
	for(new nr = 1; nr < LIMIT_SAMOCHODOW; nr++)
	{
		GetVehicleParamsEx(nr,engine,lights,alarm,doors,bonnet,boot,objective);
		if(engine&&vPaliwo[nr]>=1)
    	{
    	    if(PaliwoLicznik==1)
    	    {
				if(GetVehicleModel(nr)==403||GetVehicleModel(nr)==514||GetVehicleModel(nr)==515)//ciê¿arowe
				{
     				vPaliwo[nr]--;
     			}
			}
			else if(PaliwoLicznik==2)
			{
			    vPaliwo[nr]--;
			}
        }
	}
	if(PaliwoLicznik >= 2) PaliwoLicznik=0;
	return 1;
}

forward LicznikTimer();
public LicznikTimer()
{
	foreach(Player,i)
	{
	    if(GetPlayerState(i)==PLAYER_STATE_DRIVER)
		{
		    lPojazd=GetPlayerVehicleID(i);
		    GetVehicleParamsEx(lPojazd,engine,lights,alarm,doors,bonnet,boot,objective);
		    if(engine)
		    {
			    GetVehicleHealth(lPojazd,lPojazdHP);
			    lPojazdHP = floatsub(lPojazdHP, 250.0);
				if(doors) lText="~r~Tak"; else lText="~g~Nie";

	   			format(dstring, sizeof(dstring), "~y~%s~n~~w~Predkosc: ~r~%d km/h~n~~w~Paliwo: ~r~ %d/%d l~n~~w~HP: ~r~%.0f %%~n~~w~Zamkniety: %s",GetVehicleName(lPojazd),GetPlayerSpeed(i),vPaliwo[lPojazd],vPaliwoMax[lPojazd],(lPojazdHP/750)*100,lText);
				TextDrawSetString(Licznik[i], dstring);

				if(vPaliwo[lPojazd]<1)
				{
	        		SetVehicleParamsEx(lPojazd,false,lights,alarm,doors,bonnet,boot,objective);
	        		TextDrawHideForPlayer(i,Licznik[i]);
		    		GInfo(i,"~r~brak paliwa!",3);
				}
			}//koniec engine
		}//status kierowcy
	}//petla
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
    dUstawHP(playerid,100);
	SetPlayerPos(playerid, -189.6111,-307.9127,2.4297);
	SetPlayerFacingAngle(playerid,315.3905);
	SetPlayerCameraPos(playerid, -186.8163,-305.0795,1.9599);
	SetPlayerCameraLookAt(playerid, -189.6111,-307.9127,2.4297);
	if(classid>=10) GInfo(playerid,"~n~~n~~n~~b~Policja",3); else GInfo(playerid,"~n~~n~~n~~y~trucker",3);
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	new s=GetPlayerSkin(playerid);
	if((s==280||s==282||s==283||s==265||s==266||s==284)&&PlayerInfo[playerid][pFrakcja]!=1)
	{
		return GInfo(playerid,"~r~nie jestes w policji!",3), 0;
	}
	return 1;
}

public OnPlayerConnect(playerid)
{
    TextDrawHideForPlayer(playerid,NapisLadunek[playerid]);
    SetPlayerColor(playerid,KOLOR_CZARNY);
	AntyCheatStart(playerid);
    SetTimerEx("Text",1000,false,"i",playerid);
	Zalogowany[playerid]=false;
	Regulamin[playerid]=true;
	BlokadaPW[playerid]=false;
	Lista[playerid]=true;
	Kierunkowskaz[playerid]=false;
	MandatPD[playerid]=999;
	Spec[playerid]=false;
	Misja[playerid]=false;
	MisjaID[playerid]=999;
	MisjaStopien[playerid]=0;
	MisjaPojazd[playerid]=0;
	Przeladowany[playerid]=false;
	OstatniaMisja[playerid]=999;
	LadunekPkt[playerid]=0;
	LadunekID[playerid]=999;
	DomID[playerid]=9999;
	DomPkt[playerid]=0;
	TextPkt[playerid]=0;
	TextID[playerid]=999;
	
	PlayerInfo[playerid][pKonto]=0;
	PlayerInfo[playerid][pAdmin]=0;
	PlayerInfo[playerid][pPremium]=0;
	PlayerInfo[playerid][pJail]=0;
	PlayerInfo[playerid][pWyciszony]=0;
	PlayerInfo[playerid][pWarny]=0;
	PlayerInfo[playerid][pPoziom]=0;
	PlayerInfo[playerid][pDostarczenia]=0;
	PlayerInfo[playerid][pScigany]=0;
	PlayerInfo[playerid][pMandat]=0;
	PlayerInfo[playerid][pKasa]=0;
	PlayerInfo[playerid][pBank]=0;
	PlayerInfo[playerid][pFrakcja]=0;
	PlayerInfo[playerid][pLider]=0;
	PlayerInfo[playerid][pDom]=9999;
	PlayerInfo[playerid][pWizyty]=1;
	PlayerInfo[playerid][pMisja]=0;
	PlayerInfo[playerid][pPosiadaneAuta]=0;
    PlayerInfo[playerid][pMozliweAuta]=1;
    PlayerInfo[playerid][pAuto]=9999;
    PlayerInfo[playerid][pAuto2]=9999;
    PlayerInfo[playerid][pAuto3]=9999;
    PlayerInfo[playerid][pAuto4]=9999;
    PlayerInfo[playerid][pAuto5]=9999;
	
 	TogglePlayerSpectating(playerid, true);
 	new str[45],nick[MAX_PLAYER_NAME];
	GetPlayerName(playerid, nick, sizeof(nick));
	UpperToLower(nick);
	format(str, sizeof(str), "Truck/Konta/%s.ini",nick);
	if(DOF_FileExists(str))
 	{
		ShowPlayerDialog(playerid,2,DIALOG_STYLE_INPUT,""C_ZOLTY"XxX: "C_BIALY"Logowanie",""C_BIALY"Witaj!\nTen login jest zarejestrowany!\nW celu zalogowania siê wpisz "C_ZOLTY"has³o"C_BIALY":","Zaloguj","WyjdŸ");
 	}
 	else
 	{
 	    SetTimerEx("RegulaminOff",10000,false,"i",playerid);
 	    new s[300],ss[300],sss[600];
 	    format(s, sizeof(s), ""C_ZOLTY"1. Jest to polski serwer, wiêc u¿ywamy wy³¹cznie polskiego jêzyka.\n2. Zabrania siê jakichkolwiek bluzgów, zachowaj kulturê osobist¹.\n3. Zabrania siê zak³ócania pozosta³ym osobom gry.\n4. Zabrania siê spamowania lub pisania bez takiej potrzeby.");
 	    format(ss, sizeof(ss), ""C_ZOLTY"5. Zabrania siê wykorzystywania cheatów lub jakichkolwiek b³êdów skryptu.\n6. Gdy jesteœ œwiadkiem przewinieñ, Twoim obowi¹zkiem jest poinformowanie o tym administracji.\n7. Za z³amanie regulaminu mo¿na otrzymaæ kare, w najgorszym wypadku bana.\n"C_ZIELONY"Czy akceptujesz regulamin?");
 	    format(sss, sizeof(sss), "%s\n%s",s,ss);
 	    ShowPlayerDialog(playerid,1,DIALOG_STYLE_MSGBOX,""C_CZERWONY"Regulamin Serwera",sss,"Tak","Nie");
 	}
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    ZapiszKonto(playerid);
	TextDrawHideForPlayer(playerid,Licznik[playerid]);
 	TextDrawHideForPlayer(playerid,NapisLevel[playerid]);
  	if(Zalogowany[playerid]==true)
  	{
	  	switch(reason)
	  	{
	  		case 0: format(dstring, sizeof(dstring), "%s [%d] "C_SZARY"dosta³ crasha!",Nick(playerid),playerid);
			case 1: format(dstring, sizeof(dstring), "%s [%d] "C_SZARY"wyszed³ z gry!",Nick(playerid),playerid);
			case 2: format(dstring, sizeof(dstring), "%s [%d] "C_SZARY"zosta³ wyrzucony/zbanowany!",Nick(playerid),playerid);
		}
		SendClientMessageToAll(KOLOR_BEZOWY,dstring);
	}
	Zalogowany[playerid]=false;
	return 1;
}

public OnPlayerSpawn(playerid)
{
	if(!Zalogowany[playerid])
	{
        Info(playerid,""C_CZERWONY"Nie zalogowa³eœ siê!");
        Kick(playerid);
        return 1;
	}
	if(ToPD(playerid)) SetPlayerColor(playerid,KOLOR_NIEWIDZIALNY); else SetPlayerColor(playerid,KOLOR_POMARANCZOWY);
	dUsunBronie(playerid);
	dUstawHP(playerid,100);
	dUstawArmor(playerid,0);
	SetPlayerInterior(playerid,0);
	SetPlayerVirtualWorld(playerid,0);

	if(PlayerInfo[playerid][pJail]>=1)
	{
	    Info(playerid,""C_CZERWONY"Nie odsiedzia³eœ do koñca na³o¿onej na Ciebie kary!");
		SetPlayerPos(playerid,264.9535,77.5068,1001.0391);
  		SetPlayerInterior(playerid,6);
    	SetPlayerVirtualWorld(playerid,playerid);
	    SetPlayerWorldBounds(playerid,268.5071,261.3936,81.6285,71.8745);
	    return 1;
	}

	new s=GetPlayerSkin(playerid);
	if(s==280||s==282||s==283||s==265||s==266||s==284)//pd
	{
	    foreach(Player,i)
		{
  			if(PlayerInfo[i][pScigany]>=1)
	    	{
	    	    SetPlayerMarkerForPlayer(playerid, i, KOLOR_ROZOWY);
	    	}
	    	if(ToPD(i))
	    	{
	    	    SetPlayerMarkerForPlayer(i, playerid, KOLOR_NIEBIESKI);
	    	    SetPlayerMarkerForPlayer(playerid, i, KOLOR_NIEBIESKI);
	    	}
		}
		SendClientMessage(playerid,KOLOR_ROZOWY,"Poszukiwani gracze s¹ zaznaczeni kolorem ró¿owym na radarze!");
	    dUstawArmor(playerid,100);
	    new los=random(3);
		switch(los)
		{
		    case 0: SetPlayerPos(playerid,1579.4962,-1635.2378,13.5614);
		    case 1: SetPlayerPos(playerid,-1616.4871,683.1292,7.1875);
		    case 2: SetPlayerPos(playerid,2251.7036,2488.9546,10.9908);
		}
	}
	else
	{
	    if(PlayerInfo[playerid][pScigany]>=1)
	    {
	        SetPlayerWantedLevel(playerid,PlayerInfo[playerid][pScigany]);
	        SendClientMessage(playerid,KOLOR_ROZOWY,"Jesteœ poszukiwany przez policjê za zaleg³e mandaty!");
	        foreach(Player,i)
			{
			    if(ToPD(i))
			    {
	        		format(dstring,sizeof(dstring),"[%d]%s jest poszukiwany za zaleg³e mandaty!",playerid,Nick(playerid));
		 			SendClientMessage(i,KOLOR_ROZOWY,dstring);
		 			SendClientMessage(i,KOLOR_ROZOWY,"Gracz zostaje oznaczony na ró¿owo na radarze!");
		 			SetPlayerMarkerForPlayer(i, playerid, KOLOR_ROZOWY);
				}
			}
	    }
		if(PlayerInfo[playerid][pMandat]>1)
		{
		    SendClientMessage(playerid,KOLOR_ROZOWY,"Masz zaleg³e mandaty! Zap³aæ je szybko komend¹: /rachunek");
		    KillTimer(MandatTimer[playerid]);
			MandatTimer[playerid]=SetTimerEx("MandatPlac",60000,false,"i",playerid);
		}
		if(PlayerInfo[playerid][pDom]!=9999)
		{
		    new p=PlayerInfo[playerid][pDom];
			SetPlayerPos(playerid,DomInfo[p][dWyjscieX],DomInfo[p][dWyjscieY],DomInfo[p][dWyjscieZ]);
	  		SetPlayerInterior(playerid,DomInfo[p][dWyjscieInt]);
	    	SetPlayerVirtualWorld(playerid,p);
	    	return 1;
		}
	    new los=random(7);
		switch(los)
		{
		    case 0: SetPlayerPos(playerid,2326.9631,2785.5002,10.8203);//lv
		    case 1: SetPlayerPos(playerid,1636.6249,1038.6071,10.8203);//lv
		    case 2: SetPlayerPos(playerid,252.8059,1354.8419,10.7075);//pustynia
		    case 3: SetPlayerPos(playerid,-49.9214,-277.7625,5.4297);//wioska
		    case 4: SetPlayerPos(playerid,-501.8290,-518.0654,25.5234);//kolo sf
		    case 5: SetPlayerPos(playerid,-1710.3651,403.0952,7.4190);//sf
		    case 6: SetPlayerPos(playerid,-79.4036,-1135.6272,1.0781);//ls
		}
	}
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	if(Misja[playerid]==true)
	{
    	Info(playerid,""C_CZERWONY"Zgine³eœ podczas misji!\nMisja anulowana!\nGrzywna: 1000$");
		dDodajKase(playerid,-1000);
		AnulujMisje(playerid);
	}
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
    SetVehicleParamsEx(vehicleid,false,false,false,false,false,false,false);
    vPojazdZycie[vehicleid]=1000.0;
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
    if(Misja[killerid]==true&&MisjaPojazd[killerid]==vehicleid)
	{
    	Info(killerid,""C_CZERWONY"Pojazd, którym wioz³eœ towar zosta³ zniszczony!\nMisja anulowana!\nGrzywna: 1000$");
		dDodajKase(killerid,-1000);
		AnulujMisje(killerid);
	}
	return 1;
}

public OnVehicleDamageStatusUpdate(vehicleid, playerid)
{
	new Float:HP;
	GetVehicleHealth(vehicleid,HP);
	if(floatround(vPojazdZycie[vehicleid]-HP)>=100)
	{
	    TogglePlayerControllable(playerid,0);
     	GameTextForPlayer(playerid,"~r~masz wypadek!~n~straciles przytomnosc...",10000,3);
      	SetTimerEx("Unfreeze",10000,false,"iS",playerid,"~w~ockneles sie");
	}
	vPojazdZycie[vehicleid]=HP;
    return 1;
}

public OnPlayerText(playerid, text[])
{
    if(PlayerInfo[playerid][pJail]>=1)
	{
	    Info(playerid,""C_CZERWONY"Jesteœ w wiêzieniu, nie mo¿esz nic pisaæ!");
		return 0;
	}
	if(PlayerInfo[playerid][pWyciszony]>=1)
	{
	    Info(playerid,""C_CZERWONY"Jesteœ wyciszony!");
		return 0;
	}
	if(Bluzg(text))
	{
	    format(dstring,sizeof(dstring),"AC: "C_BIALY"(%d) %s zosta³ wyciszony (5 min), za: "C_CZERWONY"wulgaryzmy",playerid,Nick(playerid));
		SendClientMessageToAll(KOLOR_ROZOWY,dstring);
	    KillTimer(MuteTimer[playerid]);
		MuteTimer[playerid]=SetTimerEx("Odcisz",60000*5,false,"i",playerid);
		PlayerInfo[playerid][pWyciszony]=5;
		ZapiszKonto(playerid);
		return 0;
	}
	UpperToLower(text);
	if(PlayerInfo[playerid][pPremium]>=1)
	{
	    format(dstring,sizeof(dstring),"[%d] %s (VIP): "C_BIALY"%s",playerid,Nick(playerid),text);
		SendClientMessageToAll(KOLOR_POMARANCZOWY,dstring);
	    return 0;
	}
	else if(ToPD(playerid))
	{
	    format(dstring,sizeof(dstring),"[%d] %s: "C_BIALY"%s",playerid,Nick(playerid),text);
		SendClientMessageToAll(KOLOR_NIEBIESKI,dstring);
	    return 0;
	}
	else
	{
		format(dstring,sizeof(dstring),"[%d] %s: "C_BIALY"%s",playerid,Nick(playerid),text);
		SendClientMessageToAll(KOLOR_POMARANCZOWY,dstring);
		return 0;
	}
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    if(ToRadiowoz(vehicleid) && PlayerInfo[playerid][pFrakcja]!=1 && !ispassenger)
	{
	    new Float:Pos[3];
		GetPlayerPos(playerid,Pos[0],Pos[1],Pos[2]);
	    SetPlayerPos(playerid,Pos[0],Pos[1],Pos[2]);
	    Info(playerid,""C_CZERWONY"Nie mo¿esz wsi¹œæ do tego pojazdu!");
	    return 1;
	}
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
	if(doors)
	{
		SetVehicleParamsEx(vehicleid,engine,lights,alarm,false,bonnet,boot,objective);
	}
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
    if(newstate==PLAYER_STATE_DRIVER)
	{
	    SendClientMessage(playerid,KOLOR_BIALY,"Panel zarz¹dzania pojazdem, wpisz: "C_ZIELONY"(/p)ojazd");
	    new v=GetPlayerVehicleID(playerid);
        GetVehicleParamsEx(v,engine,lights,alarm,doors,bonnet,boot,objective);
		if(engine)
		{
		    TextDrawShowForPlayer(playerid,Licznik[playerid]);
		    return 1;
		}
	}

	if(newstate==PLAYER_STATE_ONFOOT)
	{
		TextDrawHideForPlayer(playerid,Licznik[playerid]);
	    return 1;
	}

	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	if(Misja[playerid]==true)
	{
	    DisablePlayerCheckpoint(playerid);
		if(GetPlayerState(playerid)!=PLAYER_STATE_DRIVER)
		{
		    Misja[playerid]=false;
		    dDodajKase(playerid,-2000);
		    Info(playerid,""C_ZOLTY"Nie masz pojazdu, misja anulowana!\n"C_CZERWONY"Grzywna: 2000$");
		    return 1;
		}

		new id=MisjaID[playerid],v=GetPlayerVehicleID(playerid);
	    if(MisjaStopien[playerid]==0 && DoInRange(10.0, playerid, LadunekInfo[id][lPosX],LadunekInfo[id][lPosY],LadunekInfo[id][lPosZ]))//dopiero ³aduje
	    {
			if(GetVehicleModel(v)==403||GetVehicleModel(v)==514||GetVehicleModel(v)==515)//ciê¿arowe
			{
                if(GetVehicleTrailer(v)!=MisjaPojazd[playerid])
			    {
			        Info(playerid,""C_CZERWONY"Nie masz naczepy, któr¹ przyj¹³eœ zlecenie!\nMisja anulowana!\nGrzywna: 1000$");
    				dDodajKase(playerid,-1000);
    				AnulujMisje(playerid);
		        	return 1;
			    }
				MisjaStopien[playerid]=1;
				SetPlayerCheckpoint(playerid,LadunekInfo[id][lPos2X],LadunekInfo[id][lPos2Y],LadunekInfo[id][lPos2Z],5);
                TogglePlayerControllable(playerid,0);
                GameTextForPlayer(playerid,"~r~trwa ladowanie...",10000,3);
                SetTimerEx("Unfreeze",10000,false,"iS",playerid,"~r~zaladowany");
			    if(Przeladowany[playerid]==true)
				{
			 		SendClientMessage(playerid,KOLOR_CZERWONY,"Prze³adowa³eœ towar, uwa¿aj na kontrole!");
			 		format(dstring, sizeof(dstring), "~g~%s ~r~(150 %%) ~w~z ~r~%s ~w~do ~y~%s",LadunekInfo[id][lTowar],LadunekInfo[id][lZaladunek],LadunekInfo[id][lDostarczenie]);
				    LadunekNapis(playerid,dstring);
				}
				else
				{
					SendClientMessage(playerid,KOLOR_ZOLTY,"Towar za³adowany pomyœlnie!");
					format(dstring, sizeof(dstring), "~g~%s ~g~(100 %%) ~w~z ~r~%s ~w~do ~y~%s",LadunekInfo[id][lTowar],LadunekInfo[id][lZaladunek],LadunekInfo[id][lDostarczenie]);
				    LadunekNapis(playerid,dstring);
				}
		    }
		    else
		    {
		        if(v!=MisjaPojazd[playerid])
		        {
		            Info(playerid,""C_CZERWONY"Nie masz pojazdu, którym przyj¹³eœ zlecenie!\nMisja anulowana!\nGrzywna: 1000$");
    				dDodajKase(playerid,-1000);
    				AnulujMisje(playerid);
		        	return 1;
		        }
		        MisjaStopien[playerid]=1;
				SetPlayerCheckpoint(playerid,LadunekInfo[id][lPos2X],LadunekInfo[id][lPos2Y],LadunekInfo[id][lPos2Z],5);
                TogglePlayerControllable(playerid,0);
                GameTextForPlayer(playerid,"~r~trwa ladowanie...",10000,3);
                SetTimerEx("Unfreeze",10000,false,"iS",playerid,"~r~Zaladowany");
			    if(Przeladowany[playerid]==true)
				{
			 		SendClientMessage(playerid,KOLOR_CZERWONY,"Prze³adowa³eœ towar, uwa¿aj na kontrole!");
			 		format(dstring, sizeof(dstring), "~g~%s ~r~(150 %%) ~w~z ~r~%s ~w~do ~y~%s",LadunekInfo[id][lTowar],LadunekInfo[id][lZaladunek],LadunekInfo[id][lDostarczenie]);
				    LadunekNapis(playerid,dstring);
				}
				else
				{
					SendClientMessage(playerid,KOLOR_ZOLTY,"Towar za³adowany pomyœlnie!");
					format(dstring, sizeof(dstring), "~g~%s ~g~(100 %%) ~w~z ~r~%s ~w~do ~y~%s",LadunekInfo[id][lTowar],LadunekInfo[id][lZaladunek],LadunekInfo[id][lDostarczenie]);
				    LadunekNapis(playerid,dstring);
				}
		    }
	        return 1;
	    }

	    if(MisjaStopien[playerid]==1 && DoInRange(10.0, playerid, LadunekInfo[id][lPos2X],LadunekInfo[id][lPos2Y],LadunekInfo[id][lPos2Z]))//roz³adunek
	    {
	        if(GetVehicleModel(v)==403||GetVehicleModel(v)==514||GetVehicleModel(v)==515)//ciê¿arowe
			{
                if(GetVehicleTrailer(v)!=MisjaPojazd[playerid])
			    {
			        Info(playerid,""C_CZERWONY"Nie masz naczepy, któr¹ przyj¹³eœ zlecenie!\nMisja anulowana!\nGrzywna: 1000$");
    				dDodajKase(playerid,-1000);
    				AnulujMisje(playerid);
		        	return 1;
				}
				new wyplata,naczepa=MisjaPojazd[playerid];
				if(Przeladowany[playerid]==true) wyplata=floatround(LadunekInfo[id][lTowarKoszt]*vLadownoscMax[naczepa]); else wyplata=floatround(LadunekInfo[id][lTowarKoszt]*vLadownosc[naczepa]);
				PlayerInfo[playerid][pDostarczenia]++;
				dDodajKase(playerid,wyplata);
				format(dstring, sizeof(dstring), ""C_ZIELONY"Zarobi³eœ: %d$\n"C_ZOLTY"Dostarczy³eœ: %s z %s do %s.",wyplata,LadunekInfo[id][lTowar],LadunekInfo[id][lZaladunek],LadunekInfo[id][lDostarczenie]);
				Info(playerid,dstring);
				PlayerInfo[playerid][pMisja]=0;
				ZapiszKonto(playerid);
				ZmienRange(playerid);
				format(dstring, sizeof(dstring),"[%d]%s dostarczy³ "C_CZERWONY"%s "C_TURKUSOWY"z "C_CZERWONY"%s "C_TURKUSOWY" do "C_CZERWONY"%s.",playerid,Nick(playerid),LadunekInfo[id][lTowar],LadunekInfo[id][lZaladunek],LadunekInfo[id][lDostarczenie]);
  				SendClientMessageToAll(KOLOR_TURKUSOWY,dstring);
				TogglePlayerControllable(playerid,0);
                GameTextForPlayer(playerid,"~r~trwa rozladunek...",10000,3);
                SetTimerEx("Unfreeze",10000,false,"iS",playerid,"~r~rozladowany");
				Misja[playerid]=false;
				MisjaID[playerid]=999;
				MisjaStopien[playerid]=0;
				MisjaPojazd[playerid]=0;
                LadunekNapis(playerid,"         ~y~/zlecenie ~w~aby rozpoczac misje... ~y~/pomoc ~w~spis pomocnych komend");
			}
			else
			{
			    if(v!=MisjaPojazd[playerid])
		        {
		            Info(playerid,""C_CZERWONY"Nie masz pojazdu, którym przyj¹³eœ zlecenie!\nMisja anulowana!\nGrzywna: 1000$");
    				dDodajKase(playerid,-1000);
    				AnulujMisje(playerid);
		        	return 1;
		        }
          		new wyplata;
				if(Przeladowany[playerid]==true) wyplata=floatround(LadunekInfo[id][lTowarKoszt]*vLadownoscMax[v]); else wyplata=floatround(LadunekInfo[id][lTowarKoszt]*vLadownosc[v]);
				PlayerInfo[playerid][pDostarczenia]++;
				dDodajKase(playerid,wyplata);
				format(dstring, sizeof(dstring), ""C_ZIELONY"Zarobi³eœ: %d$\n"C_ZOLTY"Dostarczy³eœ: %s z %s do %s.",wyplata,LadunekInfo[id][lTowar],LadunekInfo[id][lZaladunek],LadunekInfo[id][lDostarczenie]);
				Info(playerid,dstring);
				PlayerInfo[playerid][pMisja]=0;
				ZapiszKonto(playerid);
				ZmienRange(playerid);

				format(dstring, sizeof(dstring),"[%d]%s dostarczy³ "C_CZERWONY"%s "C_TURKUSOWY"z "C_CZERWONY"%s "C_TURKUSOWY" do "C_CZERWONY"%s.",playerid,Nick(playerid),LadunekInfo[id][lTowar],LadunekInfo[id][lZaladunek],LadunekInfo[id][lDostarczenie]);
  				SendClientMessageToAll(KOLOR_TURKUSOWY,dstring);
				TogglePlayerControllable(playerid,0);
                GameTextForPlayer(playerid,"~r~trwa rozladunek...",10000,3);
                SetTimerEx("Unfreeze",10000,false,"iS",playerid,"~r~rozladowany");
				Misja[playerid]=false;
				MisjaID[playerid]=999;
				MisjaStopien[playerid]=0;
				MisjaPojazd[playerid]=0;
				LadunekNapis(playerid,"         ~y~/zlecenie ~w~aby rozpoczac misje... ~y~/pomoc ~w~spis pomocnych komend");
			}
	        return 1;
	    }
	}
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys==KEY_FIRE&&GetPlayerState(playerid)==PLAYER_STATE_ONFOOT)
	{
		ClearAnimations(playerid);
		return 1;
	}

    if(newkeys==KEY_LOOK_RIGHT&&GetPlayerState(playerid)==PLAYER_STATE_DRIVER&&Kierunkowskaz[playerid]==false)
	{
		new v=GetPlayerVehicleID(playerid);
	    Kierunkowskaz[playerid]=true;
	    format(dstring, sizeof(dstring), ""C_ZIELONY"%s "C_ZOLTY"skrêca w "C_CZERWONY"prawo [>>]",Nick(playerid));
		Kierunek[playerid]=Create3DTextLabel(dstring,KOLOR_BIALY,0.0,0.0,0.0,15.0,-1,0);
		Attach3DTextLabelToVehicle(Text3D:Kierunek[playerid],v,0.0,0.0,0.1);
		SetTimerEx("KierunekPrawo",1000,0,"iii",playerid,v,0);
	    return 1;
	}

	if(newkeys==KEY_LOOK_LEFT&&GetPlayerState(playerid)==PLAYER_STATE_DRIVER&&Kierunkowskaz[playerid]==false)
	{
	    new v=GetPlayerVehicleID(playerid);
	    Kierunkowskaz[playerid]=true;
	    format(dstring, sizeof(dstring), ""C_ZIELONY"%s "C_ZOLTY"skrêca w "C_CZERWONY"lewo [<<]",Nick(playerid));
		Kierunek[playerid]=Create3DTextLabel(dstring,KOLOR_BIALY,0.0,0.0,0.0,15.0,-1,0);
		Attach3DTextLabelToVehicle(Text3D:Kierunek[playerid],v,0.0,0.0,0.1);
		SetTimerEx("KierunekLewo",1000,0,"iii",playerid,v,0);
		return 1;
	}

 	if((newkeys==KEY_SPRINT)&&(GetPlayerState(playerid)==PLAYER_STATE_ONFOOT))
	{
		new vir=GetPlayerVirtualWorld(playerid);
		for(new p = 0; p < LIMIT_DOMOW; p++)
		{
			//domy
			if(DoInRange(1.2,playerid,DomInfo[p][dWejscieX],DomInfo[p][dWejscieY],DomInfo[p][dWejscieZ])&&DomInfo[p][dAktywny]==1&&vir==DomInfo[p][dWejscieVir])
			{
			    if(DomInfo[p][dZamkniety]==1){ GInfo(playerid,"~r~drzwi zamkniete",1); return 1; }
			    SetPlayerPos(playerid,DomInfo[p][dWyjscieX],DomInfo[p][dWyjscieY],DomInfo[p][dWyjscieZ]);
			    SetPlayerInterior(playerid,DomInfo[p][dWyjscieInt]);
			    SetPlayerVirtualWorld(playerid,p);
				break;
			}
			if(DoInRange(1.2,playerid,DomInfo[p][dWyjscieX],DomInfo[p][dWyjscieY],DomInfo[p][dWyjscieZ])&&DomInfo[p][dAktywny]==1&&vir==p)
			{
			    if(DomInfo[p][dZamkniety]==1){ GInfo(playerid,"~r~drzwi zamkniete",1); return 1; }
			    SetPlayerPos(playerid,DomInfo[p][dWejscieX],DomInfo[p][dWejscieY],DomInfo[p][dWejscieZ]);
			    SetPlayerInterior(playerid,DomInfo[p][dWejscieInt]);
			    SetPlayerVirtualWorld(playerid,DomInfo[p][dWejscieVir]);
				break;
			}
		}
	}
	return 1;
}

public OnPlayerUpdate(playerid)
{
	if(Zalogowany[playerid]==true)
	{
		SetPlayerScore(playerid,PlayerInfo[playerid][pDostarczenia]);
		format(dstring,sizeof(dstring),"~y~Poziom: ~g~%d/10 ~y~Dostarczenia: ~g~%d",PlayerInfo[playerid][pPoziom],PlayerInfo[playerid][pDostarczenia]);
		TextDrawSetString(NapisLevel[playerid],dstring);

		new upanels, udoors, ulights, utires;
		GetVehicleDamageStatus(GetPlayerVehicleID(playerid), upanels, udoors, ulights, utires);
		if(Kolczatka[0]&&IsPlayerInRangeOfPoint(playerid, 5.0, KolPosX[0], KolPosY[0], KolPosZ[0])&&IsPlayerInAnyVehicle(playerid))
		{
			UpdateVehicleDamageStatus(GetPlayerVehicleID(playerid), upanels, udoors, ulights, 999);
		}
		if(Kolczatka[1]&&IsPlayerInRangeOfPoint(playerid, 5.0, KolPosX[1], KolPosY[1], KolPosZ[1])&&IsPlayerInAnyVehicle(playerid))
		{
			UpdateVehicleDamageStatus(GetPlayerVehicleID(playerid), upanels, udoors, ulights, 999);
		}
		if(Kolczatka[2]&&IsPlayerInRangeOfPoint(playerid, 5.0, KolPosX[2], KolPosY[2], KolPosZ[2])&&IsPlayerInAnyVehicle(playerid))
		{
			UpdateVehicleDamageStatus(GetPlayerVehicleID(playerid), upanels, udoors, ulights, 999);
		}
		if(Kolczatka[3]&&IsPlayerInRangeOfPoint(playerid, 5.0, KolPosX[3], KolPosY[3], KolPosZ[3])&&IsPlayerInAnyVehicle(playerid))
		{
			UpdateVehicleDamageStatus(GetPlayerVehicleID(playerid), upanels, udoors, ulights, 999);
		}
		if(Kolczatka[4]&&IsPlayerInRangeOfPoint(playerid, 5.0, KolPosX[4], KolPosY[4], KolPosZ[4])&&IsPlayerInAnyVehicle(playerid))
		{
			UpdateVehicleDamageStatus(GetPlayerVehicleID(playerid), upanels, udoors, ulights, 999);
		}
	}
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
 	if(dialogid == 1)
   	{
       if(!response)
       {
            Info(playerid,""C_CZERWONY"Zostajesz wyrzucony poniewa¿ nie akceptowa³eœ regulaminu!");
			Kick(playerid);
            return 1;
       }
       else
       {
            if(Regulamin[playerid]==true)
            {
                new s[300],ss[300],sss[600];
		 	    format(s, sizeof(s), ""C_ZOLTY"1. Jest to polski serwer, wiêc u¿ywamy wy³¹cznie polskiego jêzyka.\n2. Zabrania siê jakichkolwiek bluzgów, zachowaj kulturê osobist¹.\n3. Zabrania siê zak³ócania pozosta³ym osobom gry.\n4. Zabrania siê spamowania lub pisania bez takiej potrzeby.");
		 	    format(ss, sizeof(ss), ""C_ZOLTY"5. Zabrania siê wykorzystywania cheatów lub jakichkolwiek b³êdów skryptu.\n6. Gdy jesteœ œwiadkiem przewinieñ, Twoim obowi¹zkiem jest poinformowanie o tym administracji.\n7. Za z³amanie regulaminu mo¿na otrzymaæ kare, w najgorszym wypadku bana.\n"C_ZIELONY"Czy akceptujesz regulamin?");
		 	    format(sss, sizeof(sss), "%s\n%s",s,ss);
		 	    ShowPlayerDialog(playerid,1,DIALOG_STYLE_MSGBOX,""C_CZERWONY"Regulamin Serwera",sss,"Tak","Nie");
		 	    GInfo(playerid,"~r~czytaj...",1);
		 		return 1;
            }
			ShowPlayerDialog(playerid,3,DIALOG_STYLE_INPUT,""C_ZOLTY"XxX: "C_BIALY"Rejestracja",""C_BIALY"Witaj!\nAby zagraæ na tym serwerze musisz siê zarejestrowaæ!\nW celu zarejestrowania siê wpisz "C_ZOLTY"has³o do konta"C_BIALY":","Rejestruj","WyjdŸ");
       }
       return 1;
	}

    else if(dialogid == 2)
   	{
       if(!response) return Kick(playerid);
       if(isnull(inputtext))
	   {
		   ShowPlayerDialog(playerid,2,DIALOG_STYLE_INPUT,""C_ZOLTY"XxX: "C_BIALY"Logowanie",""C_BIALY"Ten login jest zarejestrowany!\nW celu zalogowania siê wpisz "C_ZOLTY"has³o"C_BIALY":","Zaloguj","WyjdŸ");
		   return 1;
	   }
       GraczSieLoguje(playerid,inputtext);
       return 1;
    }
    //
	else if(dialogid == 3)
   	{
       if(!response) return Kick(playerid);
       if(isnull(inputtext))
	   {
		   ShowPlayerDialog(playerid,3,DIALOG_STYLE_INPUT,""C_ZOLTY"XxX: "C_BIALY"Rejestracja",""C_BIALY"Aby zagraæ na tym serwerze musisz siê zarejestrowaæ!\nW celu zarejestrowania siê wpisz "C_ZOLTY"has³o do konta"C_BIALY":","Rejestruj","WyjdŸ");
		   return 1;
	   }
       if(strlen(inputtext)<5||strlen(inputtext)>15)
	   {
		   ShowPlayerDialog(playerid,3,DIALOG_STYLE_INPUT,""C_ZOLTY"XxX: "C_BIALY"Rejestracja",""C_BIALY"Od 5 do 15 liter!\nAby zagraæ na tym serwerze musisz siê zarejestrowaæ!\nW celu zarejestrowania siê wpisz "C_ZOLTY"has³o do konta"C_BIALY":","Rejestruj","WyjdŸ");
		   return 1;
	   }
       GraczSieRejestruje(playerid,inputtext);
       return 1;
    }
    //
	else if(dialogid == 4)
   	{
		if(!response) return 1;
		new v;
		switch(listitem)
		{
		    case 0:
		    {
		        if(GetPlayerState(playerid)!=PLAYER_STATE_DRIVER)
				{
				    Info(playerid,""C_CZERWONY"Nie jesteœ kierowc¹ pojazdu!");
				    return 1;
				}
		        v=GetPlayerVehicleID(playerid);
 				GetVehicleParamsEx(v,engine,lights,alarm,doors,bonnet,boot,objective);
 				if(engine)
 				{
 				    TextDrawHideForPlayer(playerid,Licznik[playerid]);
 				    GInfo(playerid,"~w~silnik ~r~wylaczony",3);
 				    SetVehicleParamsEx(v,false,lights,alarm,doors,bonnet,boot,objective);
 				}
 				else
 				{
 				    if(vPaliwo[v]<=1)
 				    {
 				        Info(playerid,""C_CZERWONY"Ten pojazd nie ma paliwa!");
 				        return 1;
 				    }
 				    SetTimerEx("SilnikUruchom",3000,false,"i",playerid);
 				    GInfo(playerid,"~w~uruchamianie silnika",3);
 				}
 				return 1;
		    }
		    case 1:
		    {
		        if(GetPlayerState(playerid)!=PLAYER_STATE_DRIVER)
				{
				    Info(playerid,""C_CZERWONY"Nie jesteœ kierowc¹ pojazdu!");
				    return 1;
				}
		        v=GetPlayerVehicleID(playerid);
 				GetVehicleParamsEx(v,engine,lights,alarm,doors,bonnet,boot,objective);
 				if(lights)
 				{
 				    GInfo(playerid,"~w~lampy ~r~wylaczone",3);
 				    SetVehicleParamsEx(v,engine,false,alarm,doors,bonnet,boot,objective);
					if(GetVehicleModel(v)==403||GetVehicleModel(v)==514||GetVehicleModel(v)==515)
					{
					    if(GetVehicleTrailer(v)!=0)
					    {
					        SetVehicleParamsEx(GetVehicleTrailer(v),engine,false,alarm,doors,bonnet,boot,objective);
					    }
					}
 				}
 				else
 				{
 				    GInfo(playerid,"~w~lampy ~g~wlaczone",3);
 				    SetVehicleParamsEx(v,engine,true,alarm,doors,bonnet,boot,objective);
 				    if(GetVehicleModel(v)==403||GetVehicleModel(v)==514||GetVehicleModel(v)==515)
					{
					    if(GetVehicleTrailer(v)!=0)
					    {
					        SetVehicleParamsEx(GetVehicleTrailer(v),engine,true,alarm,doors,bonnet,boot,objective);
					    }
					}
 				}
 				return 1;
		    }
		    case 2:
		    {
		        if(GetPlayerState(playerid)!=PLAYER_STATE_DRIVER)
				{
				    Info(playerid,""C_CZERWONY"Nie jesteœ kierowc¹ pojazdu!");
				    return 1;
				}
		        v=GetPlayerVehicleID(playerid);
 				GetVehicleParamsEx(v,engine,lights,alarm,doors,bonnet,boot,objective);
 				if(bonnet)
 				{
 				    GInfo(playerid,"~w~maska ~r~zamknieta",3);
 				    SetVehicleParamsEx(v,engine,lights,alarm,doors,false,boot,objective);
 				}
 				else
 				{
 				    GInfo(playerid,"~w~maska ~g~otwarta",3);
 				    SetVehicleParamsEx(v,engine,lights,alarm,doors,true,boot,objective);
 				}
 				return 1;
		    }
		    case 3:
		    {
		        if(GetPlayerState(playerid)!=PLAYER_STATE_DRIVER)
				{
				    Info(playerid,""C_CZERWONY"Nie jesteœ kierowc¹ pojazdu!");
				    return 1;
				}
		        v=GetPlayerVehicleID(playerid);
 				GetVehicleParamsEx(v,engine,lights,alarm,doors,bonnet,boot,objective);
 				if(boot)
 				{
 				    GInfo(playerid,"~w~bagaznik ~r~zamkniety",3);
 				    SetVehicleParamsEx(v,engine,lights,alarm,doors,bonnet,false,objective);
 				}
 				else
 				{
 				    GInfo(playerid,"~w~bagaznik ~g~otwarty",3);
 				    SetVehicleParamsEx(v,engine,lights,alarm,doors,bonnet,true,objective);
 				}
 				return 1;
		    }
		    case 4:
		    {
		        if(GetPlayerState(playerid)!=PLAYER_STATE_DRIVER)
				{
				    Info(playerid,""C_CZERWONY"Nie jesteœ kierowc¹ pojazdu!");
				    return 1;
				}
		        v=GetPlayerVehicleID(playerid);
 				GetVehicleParamsEx(v,engine,lights,alarm,doors,bonnet,boot,objective);
 				if(doors)
 				{
 				    GInfo(playerid,"~w~drzwi ~g~otwarte",3);
 				    SetVehicleParamsEx(v,engine,lights,alarm,false,bonnet,boot,objective);
 				}
 				else
 				{
 				    GInfo(playerid,"~w~drzwi ~r~zamkniete",3);
 				    SetVehicleParamsEx(v,engine,lights,alarm,true,bonnet,boot,objective);
 				}
 				return 1;
		    }
		    case 5:
		    {
		        if(GetPlayerState(playerid)!=PLAYER_STATE_DRIVER)
				{
				    Info(playerid,""C_CZERWONY"Nie jesteœ kierowc¹ pojazdu!");
				    return 1;
				}
				if(ToRadiowoz(GetPlayerVehicleID(playerid)))
				{
					Info(playerid,""C_CZERWONY"Ten pojazd nie ma CB-Radia!");
				    return 1;
				}
				ShowPlayerDialog(playerid,7,DIALOG_STYLE_LIST,""C_ZOLTY"CB-Radio",""C_ZIELONY"W³¹cz"C_BIALY" / "C_CZERWONY"Wy³¹cz "C_ZOLTY"CB-Radio\n"C_ZOLTY"Zmieñ kana³\n"C_ZOLTY"SprawdŸ kana³\n"C_ZOLTY"Informacja","Wybierz","Zamknij");
 				return 1;
		    }
		}
		return 1;
    }
    else if(dialogid == 5)
   	{
		if(!response) return 1;
        new v=GetPlayerVehicleID(playerid),potrzebne=vPaliwoMax[v]-vPaliwo[v];
        if(isnull(inputtext))
	   	{
			format(dstring, sizeof(dstring), ""C_ZOLTY"Witaj na stacji benzynowej!\n"C_ZIELONY"Do pe³nego baku brakuje Tobie: %d litr/ów.\n1 litr kosztuje 1.2$\n"C_ZOLTY"Ile litrów chcesz zatankowaæ?",potrzebne);
			ShowPlayerDialog(playerid,5,DIALOG_STYLE_INPUT,""C_POMARANCZOWY"Tankowanie",dstring,"Tankuj","Zamknij");
			return 1;
		}
		new id=StacjaPaliw(playerid);
		new paliwo=strval(inputtext),cena=floatround(paliwo*StacjaInfo[id][sCena]);
		if(paliwo<1||paliwo>potrzebne)
		{
		    Info(playerid,""C_CZERWONY"Nie poprawna wartoœæ paliwa!");
		    return 1;
		}
		TankowanePaliwo[playerid]=paliwo;
		format(dstring, sizeof(dstring), ""C_ZOLTY"Czy chcesz zatankowaæ "C_ZIELONY"%d "C_ZOLTY"litr/ów za "C_ZIELONY"%d$ "C_ZOLTY"?",paliwo,cena);
		ShowPlayerDialog(playerid,6,DIALOG_STYLE_MSGBOX,""C_POMARANCZOWY"Tankowanie",dstring,"Tak","Nie");
   	    return 1;
   	}
   	else if(dialogid == 6)
   	{
		if(!response) return 1;
		new v=GetPlayerVehicleID(playerid),paliwo=TankowanePaliwo[playerid],cena,id;
		id=StacjaPaliw(playerid);
		cena=floatround(paliwo*StacjaInfo[id][sCena]);
		if(!dCzyMaKase(playerid,cena))
  		{
    		Info(playerid,""C_CZERWONY"Nie masz tyle pieniêdzy!");
		    return 1;
		}
		dDodajKase(playerid,-cena);
        vPaliwo[v]+=paliwo;
		format(dstring, sizeof(dstring), ""C_ZOLTY"Zatankowa³eœ "C_ZIELONY"%d "C_ZOLTY"litr/ów za "C_ZIELONY" %d$\n"C_ZOLTY"Poziom twojego baku wynosi: "C_ZIELONY"%d"C_ZOLTY"/"C_ZIELONY"%d "C_ZOLTY"l",paliwo,cena,vPaliwo[v],vPaliwoMax[v]);
		Info(playerid,dstring);
   	    return 1;
   	}
	else if(dialogid == 7)
   	{
		if(!response) return 1;
		new v=GetPlayerVehicleID(playerid);
  		switch(listitem)
		{
		    case 0:
		    {
		        if(vCB[v]==0)
		        {
		            vCB[v]=19;
		            Info(playerid,""C_ZOLTY"CB-Radio "C_ZIELONY"w³¹czone!\n"C_ZOLTY"Kana³ domyœlnie ustawiony na: "C_ZIELONY"19");
		            return 1;
		        }
		        else
		        {
		            vCB[v]=0;
		            Info(playerid,""C_ZOLTY"CB-Radio "C_CZERWONY"wy³¹czone!");
		            return 1;
		        }
		    }
		    case 1:
		    {
    			format(dstring, sizeof(dstring), ""C_ZOLTY"Obecny kana³ CB jest ustawiony na: "C_ZIELONY"%d\n"C_ZOLTY"Zmieñ kana³ na (19-100):",vCB[v]);
     			ShowPlayerDialog(playerid,8,DIALOG_STYLE_INPUT,""C_POMARANCZOWY"CB-Radio",dstring,"Zmieñ","");
     			return 1;
     		}
     		case 2:
     		{
     			format(dstring, sizeof(dstring), ""C_ZOLTY"Obecny kana³ jest ustawiony na: "C_ZIELONY"%d",vCB[v]);
				Info(playerid,dstring);
				return 1;
     		}
     		case 3:
     		{
				Info(playerid,""C_ZOLTY"CB-Radio ma zasiêg na 3 kilometry.");
				return 1;
     		}
		}
   	    return 1;
   	}
   	else if(dialogid == 8)
   	{
		if(!response) return 1;
		new kanal=strval(inputtext),v=GetPlayerVehicleID(playerid);
		if(kanal<19||kanal>100)
		{
			Info(playerid,""C_CZERWONY"Nie poprawny kana³!");
		    return 1;
		}
        vCB[v]=kanal;
		format(dstring, sizeof(dstring), ""C_ZOLTY"Zmieni³eœ kana³ na: "C_ZIELONY"%d",kanal);
		Info(playerid,dstring);
   	    return 1;
   	}
   	else if(dialogid == 9)
   	{
		if(!response) return 1;
		switch(listitem)
		{
			case 0:
			{
				new str[300];
				format(str, sizeof(str), ""C_ZOLTY"Punkty Premium: "C_ZIELONY"%d\n"C_ZOLTY"Wizyty na serwerze: "C_ZIELONY"%d\n"C_ZOLTY"Poziom: "C_ZIELONY"%d/10\n"C_ZOLTY"Dostarczenia: "C_ZIELONY"%d\n"C_ZOLTY"Poszukiwany: "C_ZIELONY"%d/6\n"C_ZOLTY"Zaleg³e mandaty: "C_ZIELONY"%d$\n"C_ZOLTY"Gotówka: "C_ZIELONY"%d$\n"C_ZOLTY"Bank: "C_ZIELONY"%d$\n"C_ZOLTY"Ostrze¿enia: "C_ZIELONY"%d/4",
				PlayerInfo[playerid][pPremium],
				PlayerInfo[playerid][pWizyty],
				PlayerInfo[playerid][pPoziom],
				PlayerInfo[playerid][pDostarczenia],
				PlayerInfo[playerid][pScigany],
				PlayerInfo[playerid][pMandat],
				dWyswietlKase(playerid),
				PlayerInfo[playerid][pBank],
				PlayerInfo[playerid][pWarny]);
				Info(playerid,str);
			    return 1;
			}
			case 1:
			{
                format(dstring, sizeof(dstring), ""C_ZOLTY"Obecno has³o: "C_CZERWONY"%s\n"C_ZOLTY"Podaj nowe has³o:",PlayerInfo[playerid][pHaslo]);
     			ShowPlayerDialog(playerid,10,DIALOG_STYLE_INPUT,""C_POMARANCZOWY"Has³o",dstring,"Zmieñ","Zamknij");
			    return 1;
			}
			case 2:
			{
				if(BlokadaPW[playerid]==true)
				{
				    BlokadaPW[playerid]=false;
				    Info(playerid,""C_ZOLTY"Blokada PW "C_ZIELONY"wy³¹czona");
				}
				else
				{
				    BlokadaPW[playerid]=true;
				    Info(playerid,""C_ZOLTY"Blokada PW "C_CZERWONY"w³¹czona");
				}
			    return 1;
			}
		}
		return 1;
	}
	else if(dialogid == 10)
   	{
		if(!response) return 1;
		if(strlen(inputtext)<5||strlen(inputtext)>15)
		{
			Info(playerid,""C_CZERWONY"Nie poprawna d³ugoœæ has³a!");
		    return 1;
		}
        strmid(PlayerInfo[playerid][pHaslo], inputtext, 0, strlen(inputtext), 64);
		format(dstring, sizeof(dstring), ""C_ZOLTY"Zmieni³eœ has³o na: "C_CZERWONY"%s",inputtext);
		Info(playerid,dstring);
		ZapiszKonto(playerid);
   	    return 1;
   	}

   	else if(dialogid == 11)
   	{
		if(!response) return 1;
		Info(playerid,""C_ZOLTY"Anulowa³eœ misjê i otrzyma³eœ grzywnê w wysokoœci: "C_CZERWONY"1000$");
		dDodajKase(playerid,-1000);
		AnulujMisje(playerid);
		return 1;
	}
	return 1;
}

//g³ówne moje funkcje

forward LadunekNapis(playerid,text[]);
public LadunekNapis(playerid,text[])
{
	TextDrawSetString(NapisLadunek[playerid],text);
	return 1;
}

stock Bluzg(text[])
{
	if(strfind(text[0],"huj",false)!=-1||
	strfind(text[0],"chuj",false)!=-1||
	strfind(text[0],"kurwa",false)!=-1||
	strfind(text[0],"suka",false)!=-1||
	strfind(text[0],"szmata",false)!=-1||
	strfind(text[0],"dziwka",false)!=-1||
	strfind(text[0],"jebaæ",false)!=-1||
	strfind(text[0],"jebac",false)!=-1||
	strfind(text[0],"spierdalaj",false)!=-1||
	strfind(text[0],"pierdoliæ",false)!=-1||
	strfind(text[0],"pierdolic",false)!=-1||
	strfind(text[0],"jeb",false)!=-1||
	strfind(text[0],"ssij",false)!=-1||
	strfind(text[0],"suki",false)!=-1||
	strfind(text[0],"skurwysyn",false)!=-1||
	strfind(text[0],"kurwy",false)!=-1)
	{
	    return 1;
	}
    return 0;
}

stock ColouredText(text[])//zmienianie kolorów
{
    enum
        colorEnum
        {
            colorName[16],
            colorID[7]
        }
    ;
    new
        colorInfo[][colorEnum] =
        {
            { "BLUE",           "1B1BE0" },
            { "PINK",           "E81CC9" },
            { "YELLOW",         "DBED15" },
            { "LIGHTGREEN",     "8CED15" },
            { "LIGHTBLUE",      "15D4ED" },
            { "RED",            "FF0000" },
            { "GREY",           "BABABA" },
            { "WHITE",          "FFFFFF" },
            { "ORANGE",         "DB881A" },
            { "GREEN",          "37DB45" },
            { "PURPLE",         "7340DB" }
        },
        string[(128 + 32)],
        tempString[16],
        pos = -1,
        x
    ;
    strmid(string, text, 0, 128, sizeof(string));

    for( ; x != sizeof(colorInfo); ++x)
    {
        format(tempString, sizeof(tempString), "#%s", colorInfo[x][colorName]);

        while((pos = strfind(string, tempString, true, (pos + 1))) != -1)
        {
            new
                tempLen = strlen(tempString),
                tempVar,
                i = pos
            ;
            format(tempString, sizeof(tempString), "{%s}", colorInfo[x][colorID]);

            if(tempLen < 8)
            {
                for(new j; j != (8 - tempLen); ++j)
                {
                    strins(string, " ", pos);
                }
            }
            for( ; ((string[i] != 0) && (tempVar != 8)) ; ++i, ++tempVar)
            {
                string[i] = tempString[tempVar];
            }
            if(tempLen > 8)
            {
                strdel(string, i, (i + (tempLen - 8)));
            }
            x = -1;
        }
    }
    return string;
}

forward KierunekPrawo(playerid,vehicleid,numer);
public KierunekPrawo(playerid,vehicleid,numer)
{
	if(numer>=7)
	{
	    Delete3DTextLabel(Text3D:Kierunek[playerid]);
	    Kierunkowskaz[playerid]=false;
	 	return 1;
	}
	new string[128];
	numer++;
	if(numer==1||numer==3||numer==5) Delete3DTextLabel(Text3D:Kierunek[playerid]);
	if(numer==2||numer==4||numer==6)
	{
	    format(string, sizeof(string), ""C_ZIELONY"%s "C_ZOLTY"skrêca w "C_CZERWONY"prawo [>>]",Nick(playerid));
	    Kierunek[playerid]=Create3DTextLabel(string,KOLOR_BIALY,0.0,0.0,0.0,25.0,-1,0);
		Attach3DTextLabelToVehicle(Text3D:Kierunek[playerid],vehicleid,0.0,0.0,0.1);
	}
	SetTimerEx("KierunekPrawo",1000,0,"iii",playerid,vehicleid,numer);
	return 1;
}

forward KierunekLewo(playerid,vehicleid,numer);
public KierunekLewo(playerid,vehicleid,numer)
{
	if(numer>=7)
	{
	    Delete3DTextLabel(Text3D:Kierunek[playerid]);
	    Kierunkowskaz[playerid]=false;
	 	return 1;
	}
	new string[128];
	numer++;
	if(numer==1||numer==3||numer==5) Delete3DTextLabel(Text3D:Kierunek[playerid]);
	if(numer==2||numer==4||numer==6)
	{
	    format(string, sizeof(string), ""C_ZIELONY"%s "C_ZOLTY"skrêca w "C_CZERWONY"lewo [<<]",Nick(playerid));
	    Kierunek[playerid]=Create3DTextLabel(string,KOLOR_BIALY,0.0,0.0,0.0,25.0,-1,0);
		Attach3DTextLabelToVehicle(Text3D:Kierunek[playerid],vehicleid,0.0,0.0,0.1);
	}
	SetTimerEx("KierunekLewo",1000,0,"iii",playerid,vehicleid,numer);
	return 1;
}

forward SpecSystem(playerid,gracz);//specowanie
public SpecSystem(playerid,gracz)
{
	if(IsPlayerConnected(gracz)&&IsPlayerConnected(playerid)&&Spec[playerid]==true)
 	{
 		if(IsPlayerInAnyVehicle(gracz)) PlayerSpectateVehicle(playerid,GetPlayerVehicleID(gracz)); else PlayerSpectatePlayer(playerid,gracz);
  		SetPlayerInterior(playerid,GetPlayerInterior(gracz));
   		SetPlayerVirtualWorld(playerid,GetPlayerVirtualWorld(gracz));
    	SetTimerEx("SpecSystem",1000,false,"ii",playerid,gracz);
    	format(dstring, sizeof(dstring),"~r~Spec~n~~g~id: %d",gracz);
    	GameTextForPlayer(playerid,dstring,3000,1);
    	return 1;
	}
	else
	{
 		TogglePlayerSpectating(playerid,false);
	}
 	return 1;
}

forward Unfreeze(playerid,text[]);//odmraza
public Unfreeze(playerid,text[])
{
    TogglePlayerControllable(playerid,1);
    GameTextForPlayer(playerid,text,7000,3);
	return 1;
}

forward NapisText(text[]);//wyswietla napis
public NapisText(text[])
{
	if(NapisUzywany==1)
	{
		TextDrawHideForAll(Napis);
		KillTimer(NapisTimer);
	}
	NapisUzywany=1;
	TextDrawSetString(Napis,text);
	TextDrawShowForAll(Napis);
 	NapisTimer=SetTimer("NapisWylacz",20000,false);
	return 1;
}

forward NapisWylacz();//wylacza
public NapisWylacz()
{
    NapisUzywany=0;
    TextDrawHideForAll(Napis);
    KillTimer(NapisTimer);
    return 1;
}

forward RegulaminOff(playerid);//zalicza regulamin
public RegulaminOff(playerid)
{
    Regulamin[playerid]=false;
    return 1;
}

forward Text(playerid);//text powitalny przy polaczeniu
public Text(playerid)
{
    CzyscCzat(playerid,20);
	SendClientMessage(playerid,KOLOR_ZOLTY,"= "C_POMARANCZOWY"XxX "C_ZOLTY"=");
	SendClientMessage(playerid,KOLOR_ZOLTY,"Witaj na serwerze! Zapoznaj siê z komend¹: "C_ZIELONY"/pomoc");
	return 1;
}

forward SilnikUruchom(playerid);//odpala silnik
public SilnikUruchom(playerid)
{
    if(GetPlayerState(playerid)!=PLAYER_STATE_DRIVER) return 1;
    new v,Float:HP;
    v=GetPlayerVehicleID(playerid);
    GetVehicleHealth(v,HP);
    GetVehicleParamsEx(v,engine,lights,alarm,doors,bonnet,boot,objective);

    if(HP>700)
    {
    	GInfo(playerid,"~w~silnik ~g~uruchomiony",3);
    	SetVehicleParamsEx(v,true,lights,alarm,doors,bonnet,boot,objective);
	    TextDrawShowForPlayer(playerid,Licznik[playerid]);
    	return 1;
	}
	else
	{
	    new los = random(4);
	    if(los!=3)
	    {
	        GInfo(playerid,"~w~silnik ~g~uruchomiony",3);
    		SetVehicleParamsEx(v,true,lights,alarm,doors,bonnet,boot,objective);
		    TextDrawShowForPlayer(playerid,Licznik[playerid]);
    		return 1;
	    }
	    else
	    {
	        GInfo(playerid,"~w~silnik ~r~nieuruchomiony",3);
	    }
	}
    return 1;
}

stock LosujMisje(playerid)//losuje misje
{
	new los=random(LIMIT_LADUNKOW);
	if(LadunekInfo[los][lAktywny]==1&&OstatniaMisja[playerid]!=los)
	{
		MisjaID[playerid]=los;
  		return MisjaID[playerid];
	}
	return 999;
}

stock AnulujMisje(playerid)//anuluje misje
{
	if(Misja[playerid]==true)
	{
	    Misja[playerid]=false;
	    MisjaStopien[playerid]=0;
	    PlayerInfo[playerid][pMisja]=0;
	    LadunekNapis(playerid,"         ~y~/zlecenie ~w~aby rozpoczac misje... ~y~/pomoc ~w~spis pomocnych komend");
	    ZapiszKonto(playerid);
	    DisablePlayerCheckpoint(playerid);
	}
}

stock ZmienRange(playerid)//zmienia range
{
	if(PlayerInfo[playerid][pDostarczenia]>=10) PlayerInfo[playerid][pPoziom]=1;//m³okos
	if(PlayerInfo[playerid][pDostarczenia]>=30) PlayerInfo[playerid][pPoziom]=2;//amator
	if(PlayerInfo[playerid][pDostarczenia]>=60) PlayerInfo[playerid][pPoziom]=3;//poczatkujacy trucker
	if(PlayerInfo[playerid][pDostarczenia]>=100) PlayerInfo[playerid][pPoziom]=4;//trucker
	if(PlayerInfo[playerid][pDostarczenia]>=300) PlayerInfo[playerid][pPoziom]=5;//doœwiadczony trucker
	if(PlayerInfo[playerid][pDostarczenia]>=500) PlayerInfo[playerid][pPoziom]=6;//œwietny transporter
	if(PlayerInfo[playerid][pDostarczenia]>=1000) PlayerInfo[playerid][pPoziom]=7;//perfekcyjny transporter
	if(PlayerInfo[playerid][pDostarczenia]>=1500) PlayerInfo[playerid][pPoziom]=8;//w³adca ciê¿arówki
	if(PlayerInfo[playerid][pDostarczenia]>=2500) PlayerInfo[playerid][pPoziom]=9;//doskona³y trucker
	if(PlayerInfo[playerid][pDostarczenia]>=4500) PlayerInfo[playerid][pPoziom]=10;//król szos
	return 1;
}

stock Nick(playerid)//zwraca nick
{
	new nick[MAX_PLAYER_NAME];
	GetPlayerName(playerid, nick, sizeof(nick));
	return nick;
}

strrest(string[], idx)//do pisania
{
    new ret[80];
    strmid(ret, string, idx, strlen(string));
    return ret;
}

//nazwa bryki
stock GetVehicleName(vehicleid)
{
	new tmp = GetVehicleModel(vehicleid) - 400;
	return nazwypojazdow[tmp];
}

//sprawdza czy to radiowoz
stock ToRadiowoz(id)
{
	for(new w = 0; w < 54; w++)
	{
 		if(id==PojazdPD[w])
 		{
 			return 1;
 		}
	}
	return 0;
}

stock ToPD(playerid)//sprawdza czy to policjant
{
    new s=GetPlayerSkin(playerid);
	if((s==280||s==282||s==283||s==265||s==266||s==284)&&PlayerInfo[playerid][pFrakcja]==1)
	{
		return 1;
	}
	return 0;
}

stock GetPlayerSpeed(playerid)// km/h by destroyer
{
	new Float:x,Float:y,Float:z,Float:predkosc;
	if(IsPlayerInAnyVehicle(playerid)) GetVehicleVelocity(GetPlayerVehicleID(playerid),x,y,z); else GetPlayerVelocity(playerid,x,y,z);
	predkosc=floatsqroot((x*x)+(y*y)+(z*z))*198;
	return floatround(predkosc);
}

//czyszczenie czatu
stock CzyscCzat(playerid, linie)
{
	if(IsPlayerConnected(playerid))
	{
		for(new i=0; i<linie; i++)
		{
			SendClientMessage(playerid, KOLOR_BIALY, " ");
		}
	}
	return 1;
}

//wyswietlanie info
stock GInfo(playerid,text[],typ)
{
	GameTextForPlayer(playerid,text,10000,typ);
	return 1;
}

stock Info(playerid,text[])
{
	ShowPlayerDialog(playerid,9999,DIALOG_STYLE_MSGBOX,""C_POMARANCZOWY"XxX",text,"ZatwierdŸ","");
	return 1;
}

//sprawdza lvl adma
stock ToAdminLevel(playerid,level)
{
	if(IsPlayerConnected(playerid)&&PlayerInfo[playerid][pAdmin]>=level)
	{
 		return true;
	}
	return false;
}

//wywalanie i zapis przed tym
stock dKick(playerid)
{
	ZapiszKonto(playerid);
	Kick(playerid);
	return 1;
}

stock dBan(playerid)
{
	PlayerInfo[playerid][pKonto]=2;
	ZapiszKonto(playerid);
	Ban(playerid);
	return 1;
}

stock dBanEx(playerid,text[])
{
	PlayerInfo[playerid][pKonto]=2;
	ZapiszKonto(playerid);
	BanEx(playerid,text);
	return 1;
}
//

stock DoInRange(Float: radi, playerid, Float:x, Float:y, Float:z)//sprawdza odleglosc od miejsca
{
	if(IsPlayerInRangeOfPoint(playerid, radi, x, y, z)) return 1;
	return 0;
}

stock NaStacjiPaliw(playerid)//sprawdza czy wogóle jestesmy na stacji paliw
{
    if(IsPlayerConnected(playerid))
	{
		if(DoInRange(16.0, playerid, -1328.6442,2677.4944,49.7787)||
		DoInRange(8.0, playerid, -737.3889,2742.2444,46.8992)||
		DoInRange(12.0, playerid, -1475.6040,1863.6361,32.3494)||
		DoInRange(10.0, playerid, 70.2113,1218.4081,18.5282)||
		DoInRange(25.0, playerid, 611.5366,1694.5262,6.7086)||
		DoInRange(16.0, playerid, 1596.3970,2197.1189,10.5371)||
		DoInRange(16.0, playerid, 2199.8953,2477.1919,10.5369)||
		DoInRange(16.0, playerid, 2640.4731,1104.9952,10.5366)||
		DoInRange(16.0, playerid, 2115.5632,923.1831,10.5362)||
		DoInRange(10.0, playerid,1380.8798,456.7491,19.6220)||
		DoInRange(12.0, playerid,652.3244,-569.8619,16.0465)||
		DoInRange(12.0, playerid,1003.0161,-939.9588,41.8959)||
		DoInRange(12.0, playerid,1944.4365,-1773.8070,13.1072)||
		DoInRange(12.0, playerid,-89.2281,-1164.0281,2.0001)||
		DoInRange(14.0, playerid,-1606.3033,-2713.9014,48.2523)||
		DoInRange(8.0, playerid,-2244.0728,-2560.5244,31.6372)||
		DoInRange(10.0, playerid,-2029.6616,157.3720,28.5526)||
		DoInRange(16.0, playerid,-2414.1677,976.4759,45.0135)||
		DoInRange(16.0, playerid,-1674.9819,413.9892,7.1797)||
		DoInRange(16.0, playerid,2150.0823,2748.0471,10.8203))
		{
			return 1;
		}
 	}
	return 0;
}

stock StacjaPaliw(playerid)//sprawdza nam stacje paliw na jakiej jestesmy i zwraca jej id
{
    for(new nr = 0; nr < ILOSC_STACJI; nr++)
	{
	    if(DoInRange(StacjaInfo[nr][sOdleglosc], playerid, StacjaInfo[nr][sPosX],StacjaInfo[nr][sPosY],StacjaInfo[nr][sPosZ]))
	    {
	        return nr;
	    }
	}
	return 99;
}

//wczytywanie i zapisywanie wszystkiego

forward WczytajStacje();
public WczytajStacje()
{
	//stacja 0
    CreateDynamic3DTextLabel("Stacja benzynowa\n"C_ZOLTY"/tankuj\n"C_ZIELONY"1.35 $ / 1 litr",KOLOR_POMARANCZOWY,-1328.6442,2677.4944,49.7787,25.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,0,0,0,-1,25.0);
	StacjaInfo[0][sCena]=1.35;
	StacjaInfo[0][sPosX]=-1328.6442; StacjaInfo[0][sPosY]=2677.4944; StacjaInfo[0][sPosZ]=49.7787;
	StacjaInfo[0][sOdleglosc]=16.0;
	//kolejna
	CreateDynamic3DTextLabel("Stacja benzynowa\n"C_ZOLTY"/tankuj\n"C_ZIELONY"1.29 $ / 1 litr",KOLOR_POMARANCZOWY,-737.3889,2742.2444,46.8992,25.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,0,0,0,-1,25.0);
	StacjaInfo[1][sCena]=1.29;
	StacjaInfo[1][sPosX]=-737.3889; StacjaInfo[1][sPosY]=2742.2444; StacjaInfo[1][sPosZ]=46.8992;
	StacjaInfo[1][sOdleglosc]=8.0;
	//kolejna
	CreateDynamic3DTextLabel("Stacja benzynowa\n"C_ZOLTY"/tankuj\n"C_ZIELONY"1.31 $ / 1 litr",KOLOR_POMARANCZOWY,-1475.6040,1863.6361,32.3494,25.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,0,0,0,-1,25.0);
	StacjaInfo[2][sCena]=1.31;
	StacjaInfo[2][sPosX]=-1475.6040; StacjaInfo[2][sPosY]=1863.6361; StacjaInfo[2][sPosZ]=32.3494;
	StacjaInfo[2][sOdleglosc]=12.0;
	//kolejna
	CreateDynamic3DTextLabel("Stacja benzynowa\n"C_ZOLTY"/tankuj\n"C_ZIELONY"1.1 $ / 1 litr",KOLOR_POMARANCZOWY,70.2113,1218.4081,18.5282,25.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,0,0,0,-1,25.0);
	StacjaInfo[3][sCena]=1.1;
	StacjaInfo[3][sPosX]=70.2113; StacjaInfo[3][sPosY]=1218.4081; StacjaInfo[3][sPosZ]=18.5282;
	StacjaInfo[3][sOdleglosc]=10.0;
	//kolejna
	CreateDynamic3DTextLabel("Stacja benzynowa\n"C_ZOLTY"/tankuj\n"C_ZIELONY"1.29 $ / 1 litr",KOLOR_POMARANCZOWY,611.5366,1694.5262,6.7086,25.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,0,0,0,-1,25.0);
	StacjaInfo[4][sCena]=1.29;
	StacjaInfo[4][sPosX]=611.5366; StacjaInfo[4][sPosY]=1694.5262; StacjaInfo[4][sPosZ]=6.7086;
	StacjaInfo[4][sOdleglosc]=25.0;
	//kolejna
	CreateDynamic3DTextLabel("Stacja benzynowa\n"C_ZOLTY"/tankuj\n"C_ZIELONY"1.49 $ / 1 litr",KOLOR_POMARANCZOWY,1596.3970,2197.1189,10.5371,25.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,0,0,0,-1,25.0);
	StacjaInfo[5][sCena]=1.49;
	StacjaInfo[5][sPosX]=1596.3970; StacjaInfo[5][sPosY]=2197.1189; StacjaInfo[5][sPosZ]=10.5371;
	StacjaInfo[5][sOdleglosc]=16.0;
	//kolejna
	CreateDynamic3DTextLabel("Stacja benzynowa\n"C_ZOLTY"/tankuj\n"C_ZIELONY"1.32 $ / 1 litr",KOLOR_POMARANCZOWY,2199.8953,2477.1919,10.5369,25.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,0,0,0,-1,25.0);
	StacjaInfo[6][sCena]=1.32;
	StacjaInfo[6][sPosX]=2199.8953; StacjaInfo[6][sPosY]=2477.1919; StacjaInfo[6][sPosZ]=10.5369;
	StacjaInfo[6][sOdleglosc]=16.0;
	//kolejna
	CreateDynamic3DTextLabel("Stacja benzynowa\n"C_ZOLTY"/tankuj\n"C_ZIELONY"0.98 $ / 1 litr",KOLOR_POMARANCZOWY,2640.4731,1104.9952,10.5366,25.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,0,0,0,-1,25.0);
	StacjaInfo[7][sCena]=0.98;
	StacjaInfo[7][sPosX]=2640.4731; StacjaInfo[7][sPosY]=1104.9952; StacjaInfo[7][sPosZ]=10.5366;
	StacjaInfo[7][sOdleglosc]=16.0;
	//kolejna
	CreateDynamic3DTextLabel("Stacja benzynowa\n"C_ZOLTY"/tankuj\n"C_ZIELONY"1.25 $ / 1 litr",KOLOR_POMARANCZOWY,2115.5632,923.1831,10.5362,25.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,0,0,0,-1,25.0);
	StacjaInfo[8][sCena]=1.25;
	StacjaInfo[8][sPosX]=2115.5632; StacjaInfo[8][sPosY]=923.1831; StacjaInfo[8][sPosZ]=10.5362;
	StacjaInfo[8][sOdleglosc]=16.0;
	//kolejna
	CreateDynamic3DTextLabel("Stacja benzynowa\n"C_ZOLTY"/tankuj\n"C_ZIELONY"1.56 $ / 1 litr",KOLOR_POMARANCZOWY,1380.8798,456.7491,19.6220,25.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,0,0,0,-1,25.0);
	StacjaInfo[9][sCena]=1.56;
	StacjaInfo[9][sPosX]=1380.8798; StacjaInfo[9][sPosY]=456.7491; StacjaInfo[9][sPosZ]=19.6220;
	StacjaInfo[9][sOdleglosc]=10.0;
	//kolejna
	CreateDynamic3DTextLabel("Stacja benzynowa\n"C_ZOLTY"/tankuj\n"C_ZIELONY"1.42 $ / 1 litr",KOLOR_POMARANCZOWY,652.3244,-569.8619,16.0465,25.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,0,0,0,-1,25.0);
	StacjaInfo[10][sCena]=1.42;
	StacjaInfo[10][sPosX]=652.3244; StacjaInfo[10][sPosY]=-569.8619; StacjaInfo[10][sPosZ]=16.0465;
	StacjaInfo[10][sOdleglosc]=12.0;
	//kolejna
	CreateDynamic3DTextLabel("Stacja benzynowa\n"C_ZOLTY"/tankuj\n"C_ZIELONY"1.1 $ / 1 litr",KOLOR_POMARANCZOWY,1003.0161,-939.9588,41.8959,25.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,0,0,0,-1,25.0);
	StacjaInfo[11][sCena]=1.1;
	StacjaInfo[11][sPosX]=1003.0161; StacjaInfo[11][sPosY]=-939.9588; StacjaInfo[11][sPosZ]=41.8959;
	StacjaInfo[11][sOdleglosc]=12.0;
	//kolejna
	CreateDynamic3DTextLabel("Stacja benzynowa\n"C_ZOLTY"/tankuj\n"C_ZIELONY"0.87 $ / 1 litr",KOLOR_POMARANCZOWY,1944.4365,-1773.8070,13.1072,25.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,0,0,0,-1,25.0);
	StacjaInfo[12][sCena]=0.87;
	StacjaInfo[12][sPosX]=1944.4365; StacjaInfo[12][sPosY]=-1773.8070; StacjaInfo[12][sPosZ]=13.1072;
	StacjaInfo[12][sOdleglosc]=12.0;
	//kolejna
	CreateDynamic3DTextLabel("Stacja benzynowa\n"C_ZOLTY"/tankuj\n"C_ZIELONY"1.26 $ / 1 litr",KOLOR_POMARANCZOWY,-89.2281,-1164.0281,2.0001,25.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,0,0,0,-1,25.0);
	StacjaInfo[13][sCena]=1.26;
	StacjaInfo[13][sPosX]=-89.2281; StacjaInfo[13][sPosY]=-1164.0281; StacjaInfo[13][sPosZ]=2.0001;
	StacjaInfo[13][sOdleglosc]=12.0;
	//kolejna
	CreateDynamic3DTextLabel("Stacja benzynowa\n"C_ZOLTY"/tankuj\n"C_ZIELONY"1.21 $ / 1 litr",KOLOR_POMARANCZOWY,-1606.3033,-2713.9014,48.2523,25.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,0,0,0,-1,25.0);
	StacjaInfo[14][sCena]=1.21;
	StacjaInfo[14][sPosX]=-1606.3033; StacjaInfo[14][sPosY]=-2713.9014; StacjaInfo[14][sPosZ]=48.2523;
	StacjaInfo[14][sOdleglosc]=14.0;
	//kolejna
	CreateDynamic3DTextLabel("Stacja benzynowa\n"C_ZOLTY"/tankuj\n"C_ZIELONY"1.16 $ / 1 litr",KOLOR_POMARANCZOWY,-2244.0728,-2560.5244,31.6372,25.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,0,0,0,-1,25.0);
	StacjaInfo[15][sCena]=1.16;
	StacjaInfo[15][sPosX]=-2244.0728; StacjaInfo[15][sPosY]=-2560.5244; StacjaInfo[15][sPosZ]=31.6372;
	StacjaInfo[15][sOdleglosc]=8.0;
	//kolejna
	CreateDynamic3DTextLabel("Stacja benzynowa\n"C_ZOLTY"/tankuj\n"C_ZIELONY"1.36 $ / 1 litr",KOLOR_POMARANCZOWY,-2029.6616,157.3720,28.5526,25.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,0,0,0,-1,25.0);
	StacjaInfo[16][sCena]=1.36;
	StacjaInfo[16][sPosX]=-2029.6616; StacjaInfo[16][sPosY]=157.3720; StacjaInfo[16][sPosZ]=28.5526;
	StacjaInfo[16][sOdleglosc]=10.0;
	//kolejna
	CreateDynamic3DTextLabel("Stacja benzynowa\n"C_ZOLTY"/tankuj\n"C_ZIELONY"1.24 $ / 1 litr",KOLOR_POMARANCZOWY,-2414.1677,976.4759,45.0135,25.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,0,0,0,-1,25.0);
	StacjaInfo[17][sCena]=1.24;
	StacjaInfo[17][sPosX]=-2414.1677; StacjaInfo[17][sPosY]=976.4759; StacjaInfo[17][sPosZ]=45.0135;
	StacjaInfo[17][sOdleglosc]=16.0;
	//kolejna
	CreateDynamic3DTextLabel("Stacja benzynowa\n"C_ZOLTY"/tankuj\n"C_ZIELONY"1.11 $ / 1 litr",KOLOR_POMARANCZOWY,-1674.9819,413.9892,7.1797,25.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,0,0,0,-1,25.0);
	StacjaInfo[18][sCena]=1.11;
	StacjaInfo[18][sPosX]=-1674.9819; StacjaInfo[18][sPosY]=413.9892; StacjaInfo[18][sPosZ]=7.1797;
	StacjaInfo[18][sOdleglosc]=16.0;
	//kolejna
	CreateDynamic3DTextLabel("Stacja benzynowa\n"C_ZOLTY"/tankuj\n"C_ZIELONY"1.19 $ / 1 litr",KOLOR_POMARANCZOWY,2150.0823,2748.0471,10.8203,25.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,0,0,0,-1,25.0);
	StacjaInfo[19][sCena]=1.19;
	StacjaInfo[19][sPosX]=2150.0823; StacjaInfo[19][sPosY]=2748.0471; StacjaInfo[19][sPosZ]=10.8203;
	StacjaInfo[19][sOdleglosc]=16.0;
	return 1;
}

forward WczytajDomy();
public WczytajDomy()
{
	new file[25];
    for(new nr = 0; nr < LIMIT_DOMOW; nr++)
	{
		format(file,sizeof(file),"Truck/Domy/%d.ini",nr);
		if(DOF_FileExists(file))
	 	{
		 	DomInfo[nr][dAktywny]=DOF_GetInt(file,"Aktywny");
		 	DomInfo[nr][dWejscieX]=DOF_GetFloat(file,"WejscieX");
		 	DomInfo[nr][dWejscieY]=DOF_GetFloat(file,"WejscieY");
		 	DomInfo[nr][dWejscieZ]=DOF_GetFloat(file,"WejscieZ");
		 	DomInfo[nr][dWejscieInt]=DOF_GetInt(file,"WejscieInt");
		 	DomInfo[nr][dWejscieVir]=DOF_GetInt(file,"WejscieVir");
		 	DomInfo[nr][dWyjscieX]=DOF_GetFloat(file,"WyjscieX");
		 	DomInfo[nr][dWyjscieY]=DOF_GetFloat(file,"WyjscieY");
		 	DomInfo[nr][dWyjscieZ]=DOF_GetFloat(file,"WyjscieZ");
		 	DomInfo[nr][dWyjscieInt]=DOF_GetInt(file,"WyjscieInt");
		 	DomInfo[nr][dWlasciciel]=DOF_GetString(file,"Wlasciciel");
		 	DomInfo[nr][dOpis]=DOF_GetString(file,"Opis");
		 	DomInfo[nr][dKupiony]=DOF_GetInt(file,"Kupiony");
		 	DomInfo[nr][dKoszt]=DOF_GetInt(file,"Koszt");
		 	DomInfo[nr][dZamkniety]=DOF_GetInt(file,"Zamkniety");

		 	if(DomInfo[nr][dKupiony]==0 && DomInfo[nr][dAktywny]==1)
		 	{
		 		DomPickup[nr]=CreateDynamicPickup(1273,2,DomInfo[nr][dWejscieX],DomInfo[nr][dWejscieY],DomInfo[nr][dWejscieZ],DomInfo[nr][dWejscieVir],DomInfo[nr][dWejscieInt],-1,45.0);
		 	}
	  		else if(DomInfo[nr][dKupiony]==1 && DomInfo[nr][dAktywny]==1)
    		{
		 		DomPickup[nr]=CreateDynamicPickup(1239,2,DomInfo[nr][dWejscieX],DomInfo[nr][dWejscieY],DomInfo[nr][dWejscieZ],DomInfo[nr][dWejscieVir],DomInfo[nr][dWejscieInt],-1,45.0);
			}
		}
		else
		{
			DomInfo[nr][dAktywny]=0;
		}
	}
	print("\nWczytano domy!\n");
	return 1;
}

forward ZapiszDom(nr);
public ZapiszDom(nr)
{
    if(nr<0||nr>LIMIT_DOMOW) return 1;
	new file[25];
	format(file,sizeof(file),"Truck/Domy/%d.ini",nr);
	if(DOF_FileExists(file))
	{
		DOF_SetInt(file,"Aktywny",DomInfo[nr][dAktywny]);
		DOF_SetFloat(file,"WejscieX",DomInfo[nr][dWejscieX]);
		DOF_SetFloat(file,"WejscieY",DomInfo[nr][dWejscieY]);
		DOF_SetFloat(file,"WejscieZ",DomInfo[nr][dWejscieZ]);
        DOF_SetInt(file,"WejscieInt",DomInfo[nr][dWejscieInt]);
        DOF_SetInt(file,"WejscieVir",DomInfo[nr][dWejscieVir]);
        DOF_SetFloat(file,"WyjscieX",DomInfo[nr][dWyjscieX]);
		DOF_SetFloat(file,"WyjscieY",DomInfo[nr][dWyjscieY]);
		DOF_SetFloat(file,"WyjscieZ",DomInfo[nr][dWyjscieZ]);
        DOF_SetInt(file,"WyjscieInt",DomInfo[nr][dWyjscieInt]);
        DOF_SetString(file,"Wlasciciel",DomInfo[nr][dWlasciciel]);
        DOF_SetString(file,"Opis",DomInfo[nr][dOpis]);
        DOF_SetInt(file,"Kupiony",DomInfo[nr][dKupiony]);
        DOF_SetInt(file,"Koszt",DomInfo[nr][dKoszt]);
        DOF_SetInt(file,"Zamkniety",DomInfo[nr][dZamkniety]);
		DOF_SaveFile();
	}
	else
	{
	    DOF_CreateFile(file);
		DOF_SetInt(file,"Aktywny",DomInfo[nr][dAktywny]);
		DOF_SetFloat(file,"WejscieX",DomInfo[nr][dWejscieX]);
		DOF_SetFloat(file,"WejscieY",DomInfo[nr][dWejscieY]);
		DOF_SetFloat(file,"WejscieZ",DomInfo[nr][dWejscieZ]);
        DOF_SetInt(file,"WejscieInt",DomInfo[nr][dWejscieInt]);
        DOF_SetInt(file,"WejscieVir",DomInfo[nr][dWejscieVir]);
        DOF_SetFloat(file,"WyjscieX",DomInfo[nr][dWyjscieX]);
		DOF_SetFloat(file,"WyjscieY",DomInfo[nr][dWyjscieY]);
		DOF_SetFloat(file,"WyjscieZ",DomInfo[nr][dWyjscieZ]);
        DOF_SetInt(file,"WyjscieInt",DomInfo[nr][dWyjscieInt]);
        DOF_SetString(file,"Wlasciciel",DomInfo[nr][dWlasciciel]);
        DOF_SetString(file,"Opis",DomInfo[nr][dOpis]);
        DOF_SetInt(file,"Kupiony",DomInfo[nr][dKupiony]);
        DOF_SetInt(file,"Koszt",DomInfo[nr][dKoszt]);
        DOF_SetInt(file,"Zamkniety",DomInfo[nr][dZamkniety]);
		DOF_SaveFile();
	}
	return 1;
}

forward WczytajLadunki();
public WczytajLadunki()
{
	new file[25];
    for(new nr = 0; nr < LIMIT_LADUNKOW; nr++)
	{
		format(file,sizeof(file),"Truck/Ladunki/%d.ini",nr);
		if(DOF_FileExists(file))
	 	{
		 	LadunekInfo[nr][lAktywny]=DOF_GetInt(file,"Aktywny");
		 	LadunekInfo[nr][lTowar]=DOF_GetString(file,"Towar");
		 	LadunekInfo[nr][lTowarKoszt]=DOF_GetFloat(file,"TowarKoszt");
		 	LadunekInfo[nr][lZaladunek]=DOF_GetString(file,"Zaladunek");
		 	LadunekInfo[nr][lPosX]=DOF_GetInt(file,"PosX");
		 	LadunekInfo[nr][lPosY]=DOF_GetInt(file,"PosY");
		 	LadunekInfo[nr][lPosZ]=DOF_GetInt(file,"PosZ");
		 	LadunekInfo[nr][lDostarczenie]=DOF_GetString(file,"Dostarczenie");
		 	LadunekInfo[nr][lPos2X]=DOF_GetInt(file,"Pos2X");
		 	LadunekInfo[nr][lPos2Y]=DOF_GetInt(file,"Pos2Y");
		 	LadunekInfo[nr][lPos2Z]=DOF_GetInt(file,"Pos2Z");
		 	if(LadunekInfo[nr][lAktywny]==1)
		 	{
		 	    printf("Ladunek [%d] %s wczytano!",nr,LadunekInfo[nr][lTowar]);
		 	}
		}
		else
		{
			LadunekInfo[nr][lAktywny]=0;
		}
	}
	print("\nWczytano ladunki!\n");
	return 1;
}

forward ZapiszLadunek(nr);
public ZapiszLadunek(nr)
{
    if(nr<0||nr>LIMIT_LADUNKOW) return 1;
	new file[25];
	format(file,sizeof(file),"Truck/Ladunki/%d.ini",nr);
	if(DOF_FileExists(file))
	{
		DOF_SetInt(file,"Aktywny",LadunekInfo[nr][lAktywny]);
		DOF_SetString(file,"Towar",LadunekInfo[nr][lTowar]);
		DOF_SetFloat(file,"TowarKoszt",LadunekInfo[nr][lTowarKoszt]);
		DOF_SetString(file,"Zaladunek",LadunekInfo[nr][lZaladunek]);
		DOF_SetFloat(file,"PosX",LadunekInfo[nr][lPosX]);
		DOF_SetFloat(file,"PosY",LadunekInfo[nr][lPosY]);
		DOF_SetFloat(file,"PosZ",LadunekInfo[nr][lPosZ]);
		DOF_SetString(file,"Dostarczenie",LadunekInfo[nr][lDostarczenie]);
		DOF_SetFloat(file,"Pos2X",LadunekInfo[nr][lPos2X]);
		DOF_SetFloat(file,"Pos2Y",LadunekInfo[nr][lPos2Y]);
		DOF_SetFloat(file,"Pos2Z",LadunekInfo[nr][lPos2Z]);
		DOF_SaveFile();
	}
	else
	{
	    DOF_CreateFile(file);
		DOF_SetInt(file,"Aktywny",LadunekInfo[nr][lAktywny]);
		DOF_SetString(file,"Towar",LadunekInfo[nr][lTowar]);
		DOF_SetFloat(file,"TowarKoszt",LadunekInfo[nr][lTowarKoszt]);
		DOF_SetString(file,"Zaladunek",LadunekInfo[nr][lZaladunek]);
		DOF_SetFloat(file,"PosX",LadunekInfo[nr][lPosX]);
		DOF_SetFloat(file,"PosY",LadunekInfo[nr][lPosY]);
		DOF_SetFloat(file,"PosZ",LadunekInfo[nr][lPosZ]);
		DOF_SetString(file,"Dostarczenie",LadunekInfo[nr][lDostarczenie]);
		DOF_SetFloat(file,"Pos2X",LadunekInfo[nr][lPos2X]);
		DOF_SetFloat(file,"Pos2Y",LadunekInfo[nr][lPos2Y]);
		DOF_SetFloat(file,"Pos2Z",LadunekInfo[nr][lPos2Z]);
		DOF_SaveFile();
	}
	return 1;
}

forward WczytajTexty();
public WczytajTexty()
{
	new file[25];
    for(new nr = 0; nr < LIMIT_TEXTOW; nr++)
	{
		format(file,sizeof(file),"Truck/Texty/%d.ini",nr);
		if(DOF_FileExists(file))
	 	{
		 	TextInfo[nr][tAktywny]=DOF_GetInt(file,"Aktywny");
		 	TextInfo[nr][tNapis]=DOF_GetString(file,"Napis");
		 	TextInfo[nr][tPosX]=DOF_GetFloat(file,"PosX");
		 	TextInfo[nr][tPosY]=DOF_GetFloat(file,"PosY");
		 	TextInfo[nr][tPosZ]=DOF_GetFloat(file,"PosZ");
		 	if(TextInfo[nr][tAktywny]==1)
		 	{
		 	    printf("Text3d id: [%d] wczytano!",nr);
		 	    TextNapis[nr]=CreateDynamic3DTextLabel(ColouredText(TextInfo[nr][tNapis]),KOLOR_BIALY,TextInfo[nr][tPosX],TextInfo[nr][tPosY],TextInfo[nr][tPosZ],40.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,-1,-1,-1,-1,40.0);
		 	}
		}
		else
		{
			TextInfo[nr][tAktywny]=0;
		}
	}
	print("\nWczytano texty3d!\n");
	return 1;
}

forward ZapiszText(nr);
public ZapiszText(nr)
{
    if(nr<0||nr>LIMIT_TEXTOW) return 1;
	new file[25];
	format(file,sizeof(file),"Truck/Texty/%d.ini",nr);
	if(DOF_FileExists(file))
	{
		DOF_SetInt(file,"Aktywny",TextInfo[nr][tAktywny]);
        DOF_SetString(file,"Napis",TextInfo[nr][tNapis]);
        DOF_SetFloat(file,"PosX",TextInfo[nr][tPosX]);
        DOF_SetFloat(file,"PosY",TextInfo[nr][tPosY]);
        DOF_SetFloat(file,"PosZ",TextInfo[nr][tPosZ]);
		DOF_SaveFile();
	}
	else
	{
	    DOF_CreateFile(file);
		DOF_SetInt(file,"Aktywny",TextInfo[nr][tAktywny]);
        DOF_SetString(file,"Napis",TextInfo[nr][tNapis]);
        DOF_SetFloat(file,"PosX",TextInfo[nr][tPosX]);
        DOF_SetFloat(file,"PosY",TextInfo[nr][tPosY]);
        DOF_SetFloat(file,"PosZ",TextInfo[nr][tPosZ]);
		DOF_SaveFile();
	}
	return 1;
}

//logowanie
forward GraczSieLoguje(playerid,haslo[]);
public GraczSieLoguje(playerid,haslo[])
{
	if(IsPlayerConnected(playerid)&&Zalogowany[playerid]==false)
	{
		new file[45],nick[MAX_PLAYER_NAME];
		GetPlayerName(playerid,nick,sizeof(nick));
		UpperToLower(nick);
 		format(file,sizeof(file),"Truck/Konta/%s.ini",nick);
	 	PlayerInfo[playerid][pHaslo]=DOF_GetString(file,"Haslo");//wczytujemy has³o
		if(strcmp(PlayerInfo[playerid][pHaslo],haslo,true))//je¿eli has³o nie pasuje kick
		{
		    Info(playerid,""C_CZERWONY"Zosta³eœ wyrzucony!\nPowód: Niepoprawne has³o!");
			Kick(playerid);
			return 0;
		}//jesli sie powiedzie to wczytujemy reszte
		PlayerInfo[playerid][pKonto]=DOF_GetInt(file,"Konto");
		PlayerInfo[playerid][pAdmin]=DOF_GetInt(file,"Admin");
		PlayerInfo[playerid][pPremium]=DOF_GetInt(file,"Premium");
		PlayerInfo[playerid][pJail]=DOF_GetInt(file,"Jail");
		PlayerInfo[playerid][pWyciszony]=DOF_GetInt(file,"Wyciszony");
		PlayerInfo[playerid][pWarny]=DOF_GetInt(file,"Warny");
		PlayerInfo[playerid][pPoziom]=DOF_GetInt(file,"Poziom");
		PlayerInfo[playerid][pDostarczenia]=DOF_GetInt(file,"Dostarczenia");
		PlayerInfo[playerid][pScigany]=DOF_GetInt(file,"Scigany");
		PlayerInfo[playerid][pMandat]=DOF_GetInt(file,"Mandat");
		PlayerInfo[playerid][pKasa]=DOF_GetInt(file,"Kasa");
		PlayerInfo[playerid][pBank]=DOF_GetInt(file,"Bank");
		PlayerInfo[playerid][pFrakcja]=DOF_GetInt(file,"Frakcja");
		PlayerInfo[playerid][pLider]=DOF_GetInt(file,"Lider");
		PlayerInfo[playerid][pDom]=DOF_GetInt(file,"Dom");
		PlayerInfo[playerid][pWizyty]=DOF_GetInt(file,"Wizyty");
		PlayerInfo[playerid][pMisja]=DOF_GetInt(file,"Misja");
		PlayerInfo[playerid][pPosiadaneAuta]=DOF_GetInt(file,"PosiadaneAuta");
		PlayerInfo[playerid][pMozliweAuta]=DOF_GetInt(file,"MozliweAuta");
		PlayerInfo[playerid][pAuto]=DOF_GetInt(file,"Auto");
		PlayerInfo[playerid][pAuto2]=DOF_GetInt(file,"Auto2");
		PlayerInfo[playerid][pAuto3]=DOF_GetInt(file,"Auto3");
		PlayerInfo[playerid][pAuto4]=DOF_GetInt(file,"Auto4");
		PlayerInfo[playerid][pAuto5]=DOF_GetInt(file,"Auto5");
		if(PlayerInfo[playerid][pKonto]==2)//
		{
			Info(playerid,""C_CZERWONY"To konto jest zablokowane!");
			dKick(playerid);
			return 0;
		}
		dUstawKase(playerid,PlayerInfo[playerid][pKasa]);
		if(PlayerInfo[playerid][pMisja]==1)
		{
		    Info(playerid,""C_ZOLTY"Wyszed³eœ z serwera nie ukoñczywszy zlecenia.\n"C_CZERWONY"Zostajesz ukarany: 1000$");
			dDodajKase(playerid,-1000);
			PlayerInfo[playerid][pMisja]=0;
		}
		if(PlayerInfo[playerid][pWyciszony]>=1)
		{
			KillTimer(MuteTimer[playerid]);
			MuteTimer[playerid]=SetTimerEx("Odcisz",60000*PlayerInfo[playerid][pWyciszony],false,"i",playerid);
		}
		TextDrawShowForPlayer(playerid,NapisLadunek[playerid]);
        LadunekNapis(playerid,"         ~y~/zlecenie ~w~aby rozpoczac misje... ~y~/pomoc ~w~spis pomocnych komend");
	 	TogglePlayerSpectating(playerid, false);
		PlayerInfo[playerid][pWizyty]++;
		SendClientMessage(playerid,KOLOR_ZOLTY,"Zalogowa³eœ siê poprawnie! Wybierz postaæ i graj!");
		Zalogowany[playerid]=true;
		format(dstring,sizeof(dstring),"~y~Poziom: ~g~%d/10 ~y~Dostarczenia: ~g~%d",PlayerInfo[playerid][pPoziom],PlayerInfo[playerid][pDostarczenia]);
		TextDrawSetString(NapisLevel[playerid],dstring);
	    TextDrawShowForPlayer(playerid,NapisLevel[playerid]);
		SpawnPlayer(playerid);
		format(dstring, sizeof(dstring), "%s [%d] "C_BIALY"do³¹czy³ do gry!",Nick(playerid),playerid);
		SendClientMessageToAll(KOLOR_BEZOWY,dstring);
		return 1;
	}
	return 0;
}

//rejestrowanie
forward GraczSieRejestruje(playerid, haslo[]);
public GraczSieRejestruje(playerid, haslo[])
{
    if(IsPlayerConnected(playerid)&&Zalogowany[playerid]==false)
	{
		new file[45],nick[MAX_PLAYER_NAME];
		GetPlayerName(playerid,nick,sizeof(nick));
		UpperToLower(nick);
	 	format(file,sizeof(file),"Truck/Konta/%s.ini",nick);
	 	DOF_CreateFile(file);
	 	strmid(PlayerInfo[playerid][pHaslo], haslo, 0, strlen(haslo), 64);
	 	DOF_SetString(file,"Haslo",PlayerInfo[playerid][pHaslo]);
		DOF_SetInt(file,"Konto",PlayerInfo[playerid][pKonto]);
		DOF_SetInt(file,"Admin",PlayerInfo[playerid][pAdmin]);
		DOF_SetInt(file,"Premium",PlayerInfo[playerid][pPremium]);
		DOF_SetInt(file,"Jail",PlayerInfo[playerid][pJail]);
		DOF_SetInt(file,"Wyciszony",PlayerInfo[playerid][pWyciszony]);
		DOF_SetInt(file,"Warny",PlayerInfo[playerid][pWarny]);
		DOF_SetInt(file,"Poziom",PlayerInfo[playerid][pPoziom]);
		DOF_SetInt(file,"Dostarczenia",PlayerInfo[playerid][pDostarczenia]);
		DOF_SetInt(file,"Scigany",PlayerInfo[playerid][pScigany]);
		DOF_SetInt(file,"Mandat",PlayerInfo[playerid][pMandat]);
		DOF_SetInt(file,"Kasa",PlayerInfo[playerid][pKasa]);
		DOF_SetInt(file,"Bank",PlayerInfo[playerid][pBank]);
		DOF_SetInt(file,"Frakcja",PlayerInfo[playerid][pFrakcja]);
		DOF_SetInt(file,"Lider",PlayerInfo[playerid][pLider]);
		DOF_SetInt(file,"Dom",PlayerInfo[playerid][pDom]);
		DOF_SetInt(file,"Wizyty",PlayerInfo[playerid][pWizyty]);
		DOF_SetInt(file,"Misja",PlayerInfo[playerid][pMisja]);
		DOF_SetInt(file,"PosiadaneAuta",PlayerInfo[playerid][pPosiadaneAuta]);
	    DOF_SetInt(file,"MozliweAuta",PlayerInfo[playerid][pMozliweAuta]);
	    DOF_SetInt(file,"Auto",PlayerInfo[playerid][pAuto]);
	    DOF_SetInt(file,"Auto2",PlayerInfo[playerid][pAuto2]);
	    DOF_SetInt(file,"Auto3",PlayerInfo[playerid][pAuto3]);
	    DOF_SetInt(file,"Auto4",PlayerInfo[playerid][pAuto4]);
	    DOF_SetInt(file,"Auto5",PlayerInfo[playerid][pAuto5]);
 		DOF_SaveFile();
 		TogglePlayerSpectating(playerid, false);
 		Zalogowany[playerid]=true;
 		SendClientMessage(playerid,KOLOR_ZOLTY,"Konto utworzone poprawnie! Wybierz postaæ i graj!");
 		dUstawKase(playerid,2500);
	    TextDrawSetString(NapisLevel[playerid],"~y~Poziom: ~g~0/10 ~y~Dostarczenia: ~g~0");
	    TextDrawShowForPlayer(playerid,NapisLevel[playerid]);
	    format(dstring, sizeof(dstring), "%s [%d] "C_BIALY"do³¹czy³ do gry!",Nick(playerid),playerid);
		SendClientMessageToAll(KOLOR_BEZOWY,dstring);
	}
	return 1;
}

//zapisywanie
forward ZapiszKonto(playerid);
public ZapiszKonto(playerid)
{
	if(IsPlayerConnected(playerid)&&Zalogowany[playerid]==true)
	{
		new file[45],nick[MAX_PLAYER_NAME];
		GetPlayerName(playerid,nick,sizeof(nick));
		UpperToLower(nick);
		format(file,sizeof(file),"Truck/Konta/%s.ini",nick);
		PlayerInfo[playerid][pKasa]=dWyswietlKase(playerid);
		DOF_SetString(file,"Haslo",PlayerInfo[playerid][pHaslo]);
		DOF_SetInt(file,"Konto",PlayerInfo[playerid][pKonto]);
		DOF_SetInt(file,"Admin",PlayerInfo[playerid][pAdmin]);
		DOF_SetInt(file,"Premium",PlayerInfo[playerid][pPremium]);
		DOF_SetInt(file,"Jail",PlayerInfo[playerid][pJail]);
		DOF_SetInt(file,"Wyciszony",PlayerInfo[playerid][pWyciszony]);
		DOF_SetInt(file,"Warny",PlayerInfo[playerid][pWarny]);
		DOF_SetInt(file,"Poziom",PlayerInfo[playerid][pPoziom]);
		DOF_SetInt(file,"Dostarczenia",PlayerInfo[playerid][pDostarczenia]);
		DOF_SetInt(file,"Scigany",PlayerInfo[playerid][pScigany]);
		DOF_SetInt(file,"Mandat",PlayerInfo[playerid][pMandat]);
		DOF_SetInt(file,"Kasa",PlayerInfo[playerid][pKasa]);
		DOF_SetInt(file,"Bank",PlayerInfo[playerid][pBank]);
		DOF_SetInt(file,"Frakcja",PlayerInfo[playerid][pFrakcja]);
		DOF_SetInt(file,"Lider",PlayerInfo[playerid][pLider]);
		DOF_SetInt(file,"Dom",PlayerInfo[playerid][pDom]);
		DOF_SetInt(file,"Wizyty",PlayerInfo[playerid][pWizyty]);
		DOF_SetInt(file,"Misja",PlayerInfo[playerid][pMisja]);
		DOF_SetInt(file,"PosiadaneAuta",PlayerInfo[playerid][pPosiadaneAuta]);
	    DOF_SetInt(file,"MozliweAuta",PlayerInfo[playerid][pMozliweAuta]);
	    DOF_SetInt(file,"Auto",PlayerInfo[playerid][pAuto]);
	    DOF_SetInt(file,"Auto2",PlayerInfo[playerid][pAuto2]);
	    DOF_SetInt(file,"Auto3",PlayerInfo[playerid][pAuto3]);
	    DOF_SetInt(file,"Auto4",PlayerInfo[playerid][pAuto4]);
	    DOF_SetInt(file,"Auto5",PlayerInfo[playerid][pAuto5]);
		DOF_SaveFile();
 	}
	return 1;
}

//publice od streamera

public OnDynamicObjectMoved(objectid)//gdy dynamiczny obiekt siê porusza
{
	return 1;
}
public OnPlayerPickUpDynamicPickup(playerid, pickupid)//gdy gracz podnosi dynamiczny pickup
{
    for(new p = 0; p < 100; p++)
	{
		if(pickupid==DomPickup[p]&&DomInfo[p][dAktywny]==1)
 		{
 		    if(DomInfo[p][dKupiony] == 1)
			{
				format(dstring, sizeof(dstring), "~g~Dom kupiony przez~n~~w~%s",DomInfo[p][dWlasciciel]);
				GInfo(playerid,dstring,3);
				return 1;
			}
			else
			{
				format(dstring, sizeof(dstring), "~g~Dom na sprzedaz~n~~w~%s~n~~y~cena: %d$~n~~p~/kupdom",DomInfo[p][dOpis],DomInfo[p][dKoszt]);
				GInfo(playerid,dstring,3);
				return 1;
			}
		}
	}
	return 1;
}
public OnPlayerEnterDynamicCP(playerid, checkpointid)//jak gracz wchodzi w checkopoint
{
	return 1;
}
public OnPlayerLeaveDynamicCP(playerid, checkpointid)//jak gracz opusci dynamiczny checkpoint
{
	return 1;
}
public OnPlayerEnterDynamicRaceCP(playerid, checkpointid)//jak gracz wejdzie w dynamiczny checkpoint wyscigowy
{
	return 1;
}
public OnPlayerLeaveDynamicRaceCP(playerid, checkpointid)//jak gracz opusci dynamiczny checkpoint wyscigowy
{
	return 1;
}
public OnPlayerEnterDynamicArea(playerid, areaid)//jak gracz wchodzi w dynamiczna strefe
{
	return 1;
}
public OnPlayerLeaveDynamicArea(playerid, areaid)//jak gracz opuszcza
{
	return 1;
}

//publice od zcmd I WSZYSTKIE KOMENDY

public OnPlayerCommandReceived(playerid, cmdtext[])
{
	if(Zalogowany[playerid]==false)
	{
		Info(playerid,""C_CZERWONY"Nie zalogowa³eœ siê!");
		return 0;
	}
	if(PlayerInfo[playerid][pJail]>=1)
	{
	    Info(playerid,""C_CZERWONY"Jesteœ w wiêzieniu, nie mo¿esz u¿ywaæ komend!");
		return 0;
	}
	return 1;
}

public OnPlayerCommandPerformed(playerid, cmdtext[], success)
{
	if(!success)
	{
		Info(playerid,""C_CZERWONY"Nie poprawna komenda!\n"C_ZOLTY"Spis komend: /pomoc");
	}
	return 1;
}

	CMD:pomoc(playerid, cmdtext[])
	{
		Info(playerid,""C_POMARANCZOWY"/regulamin = /konto = /premium = /autorzy = /raport = /admini\n(/p)ojazd = /cb = /w = /respawn = /odczep = /lider = /frakcja\n/skin = /napraw = /obrot = /paliwo = /rachunek = /dajkase\n/anim = /kupdom = /sprzedajdom = /zamek = /limity = /poziomy\n/taryfikator\n"C_ZIELONY"Komendy przydatne do pracowania:\n"C_ZOLTY"/zlecenie = /anuluj = /przeladowany");
		return 1;
	}

	CMD:anim(playerid, cmdtext[])
	{
		Info(playerid,""C_ZOLTY"- /gleba - /raczkuj - /kryj - /rece - /machaj - /odskocz - /tupnij - /fuckyou - /sikaj\n- /poddajsie - /tam - /odejdz - /bacznosc - /salutuj - /taxi - /zmeczony\n- /tancz - /szafka - /mysl - /ranny - /spij - /bar - /jedz - /pij - /lez - /silownia\n- /wymiotuj - /turlaj - /tak - /nie - /siema - /opieraj - /yeah - /kibic - /caluj\n- /podnies - /poloz - /ratuj - /daj - /smiech - /dawaj - /stop - /krzeslo - /lawka\n/astop lub PPM - wy³¹czenie");
		return 1;
	}

	CMD:astop(playerid, cmdtext[])
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        Info(playerid,"Nie mo¿esz u¿ywaæ tej komendy bêd¹c w pojeŸdzie!");
	        return 1;
	    }
		ClearAnimations(playerid);
		Info(playerid,""C_ZOLTY"Usune³eœ animacjê!");
	    return 1;
	}

	CMD:apomoc(playerid, cmdtext[])
	{
		if(!ToAdminLevel(playerid,1)) return 1;
		SendClientMessage(playerid,KOLOR_BIALY,"=== "C_CZERWONY"Spis komend admina"C_BIALY"===");
		if(PlayerInfo[playerid][pAdmin]>=1)
		{
		    SendClientMessage(playerid,KOLOR_BIALY,"=== "C_BEZOWY"Junior Admin"C_BIALY"===");
		    SendClientMessage(playerid,KOLOR_BIALY,"/lista - /podglad - /kick - /warn - /blok - /ban - /aj");
		}
		if(PlayerInfo[playerid][pAdmin]>=2)
		{
		    SendClientMessage(playerid,KOLOR_BIALY,"=== "C_ZOLTY"Administrator"C_BIALY"===");
		    SendClientMessage(playerid,KOLOR_BIALY,"/spec - /specoff - /rsp - /rspall - /tankujall - /wycisz - /sprawdzip");
		}
		if(PlayerInfo[playerid][pAdmin]>=3)
		{
		    SendClientMessage(playerid,KOLOR_BIALY,"=== "C_CZERWONY"Head Administrator"C_BIALY"===");
		    SendClientMessage(playerid,KOLOR_BIALY,"/ladunek - /text - /dom - /dajadmin - /dajpremium - /dajlider");
		}
		return 1;
	}
	
	CMD:szlaban(playerid, cmdtext[])
	{
	    if(!IsPlayerInAnyVehicle(playerid))
	    {
   	 		Info(playerid,""C_CZERWONY"Nie jesteœ w pojeŸdzie!");
		    return 1;
	    }
	    if(DoInRange(12.0, playerid,1737.2573242188, 527.54992675781, 27.342805862427))
  		{
  		    if(SzlabanUzywany[0]==true) return 1;
  		    SzlabanUzywany[0]=true;
  		    SzlabanTimer[0]=SetTimer("SzlabanOtworz",100,true);
  		    GInfo(playerid,"~g~szlaban sie otwiera!~n~~r~-10$",3);
  		    dDodajKase(playerid,-10);
  		    return 1;
  		}
  		else if(DoInRange(12.0, playerid,1747.2440185547, 538.67596435547, 26.485975265503))
  		{
  		    if(SzlabanUzywany[1]==true) return 1;
  		    SzlabanUzywany[1]=true;
  		    SzlabanTimer[1]=SetTimer("Szlaban2Otworz",100,true);
  		    GInfo(playerid,"~g~szlaban sie otwiera!~n~~r~-10$",3);
  		    dDodajKase(playerid,-10);
  		    return 1;
  		}
  		else if(DoInRange(12.0, playerid,-1653.5545654297, 574.41876220703, 39.123199462891))
  		{
  		    if(SzlabanUzywany[2]==true) return 1;
  		    SzlabanUzywany[2]=true;
  		    SzlabanTimer[2]=SetTimer("Szlaban3Otworz",100,true);
  		    GInfo(playerid,"~g~szlaban sie otwiera!~n~~r~-10$",3);
  		    dDodajKase(playerid,-10);
  		    return 1;
  		}
  		else if(DoInRange(12.0, playerid,-1628.6497802734, 569.43347167969, 39.624629974365))
  		{
  		    if(SzlabanUzywany[3]==true) return 1;
  		    SzlabanUzywany[3]=true;
  		    SzlabanTimer[3]=SetTimer("Szlaban4Otworz",100,true);
  		    GInfo(playerid,"~g~szlaban sie otwiera!~n~~r~-10$",3);
  		    dDodajKase(playerid,-10);
  		    return 1;
  		}
  		else if(DoInRange(6.0, playerid,-2671.6857910156, 1285.1840820313, 55.327934265137))
  		{
  		    if(SzlabanUzywany[4]==true) return 1;
  		    SzlabanUzywany[4]=true;
  		    SzlabanTimer[4]=SetTimer("Szlaban5Otworz",100,true);
  		    GInfo(playerid,"~g~szlaban sie otwiera!~n~~r~-10$",3);
  		    dDodajKase(playerid,-10);
  		    return 1;
  		}
  		else if(DoInRange(6.0, playerid,-2673.1394042969, 1285.1458740234, 55.326545715332))
  		{
  		    if(SzlabanUzywany[5]==true) return 1;
  		    SzlabanUzywany[5]=true;
  		    SzlabanTimer[5]=SetTimer("Szlaban6Otworz",100,true);
  		    GInfo(playerid,"~g~szlaban sie otwiera!~n~~r~-10$",3);
  		    dDodajKase(playerid,-10);
  		    return 1;
  		}
  		else if(DoInRange(6.0, playerid,-2689.8010253906, 1264.5959472656, 55.353748321533))
  		{
  		    if(SzlabanUzywany[6]==true) return 1;
  		    SzlabanUzywany[6]=true;
  		    SzlabanTimer[6]=SetTimer("Szlaban7Otworz",100,true);
  		    GInfo(playerid,"~g~szlaban sie otwiera!~n~~r~-10$",3);
  		    dDodajKase(playerid,-10);
  		    return 1;
  		}
  		else if(DoInRange(6.0, playerid,-2691.2211914063, 1264.6124267578, 55.319801330566))
  		{
  		    if(SzlabanUzywany[7]==true) return 1;
  		    SzlabanUzywany[7]=true;
  		    SzlabanTimer[7]=SetTimer("Szlaban8Otworz",100,true);
  		    GInfo(playerid,"~g~szlaban sie otwiera!~n~~r~-10$",3);
  		    dDodajKase(playerid,-10);
  		    return 1;
  		}
	    return 1;
	}
	
	forward Szlaban8Otworz();
	public Szlaban8Otworz()
	{
	    new Float:Rot[3];
	    GetObjectRot(Szlaban[7],Rot[0],Rot[1],Rot[2]);
	    if(Rot[1]!=360.0)
	    {
	        SetObjectRot(Szlaban[7],Rot[0],Rot[1]+2.0,Rot[2]);
	    }
	    else
	    {
	        KillTimer(SzlabanTimer[7]);
	        SetTimer("Szlaban8Zamknij",8000,false);
	    }
		return 1;
	}

	forward Szlaban8Zamknij();
	public Szlaban8Zamknij()
	{
	    new Float:Rot[3];
	    GetObjectRot(Szlaban[7],Rot[0],Rot[1],Rot[2]);
	    if(Rot[1]!=270.0)
	    {
	        SetObjectRot(Szlaban[7],Rot[0],Rot[1]-2.0,Rot[2]);
	        SetTimer("Szlaban8Zamknij",100,false);
	    }
	    else
	    {
	        SzlabanUzywany[7]=false;
	    }
		return 1;
	}
	
	forward Szlaban7Otworz();
	public Szlaban7Otworz()
	{
	    new Float:Rot[3];
	    GetObjectRot(Szlaban[6],Rot[0],Rot[1],Rot[2]);
	    if(Rot[1]!=0.0)
	    {
	        SetObjectRot(Szlaban[6],Rot[0],Rot[1]-2.0,Rot[2]);
	    }
	    else
	    {
	        KillTimer(SzlabanTimer[6]);
	        SetTimer("Szlaban7Zamknij",8000,false);
	    }
		return 1;
	}

	forward Szlaban7Zamknij();
	public Szlaban7Zamknij()
	{
	    new Float:Rot[3];
	    GetObjectRot(Szlaban[6],Rot[0],Rot[1],Rot[2]);
	    if(Rot[1]!=90.0)
	    {
	        SetObjectRot(Szlaban[6],Rot[0],Rot[1]+2.0,Rot[2]);
	        SetTimer("Szlaban7Zamknij",100,false);
	    }
	    else
	    {
	        SzlabanUzywany[6]=false;
	    }
		return 1;
	}
	
	forward Szlaban6Otworz();
	public Szlaban6Otworz()
	{
	    new Float:Rot[3];
	    GetObjectRot(Szlaban[5],Rot[0],Rot[1],Rot[2]);
	    if(Rot[1]!=360.0)
	    {
	        SetObjectRot(Szlaban[5],Rot[0],Rot[1]+2.0,Rot[2]);
	    }
	    else
	    {
	        KillTimer(SzlabanTimer[5]);
	        SetTimer("Szlaban6Zamknij",8000,false);
	    }
		return 1;
	}

	forward Szlaban6Zamknij();
	public Szlaban6Zamknij()
	{
	    new Float:Rot[3];
	    GetObjectRot(Szlaban[5],Rot[0],Rot[1],Rot[2]);
	    if(Rot[1]!=270.0)
	    {
	        SetObjectRot(Szlaban[5],Rot[0],Rot[1]-2.0,Rot[2]);
	        SetTimer("Szlaban6Zamknij",100,false);
	    }
	    else
	    {
	        SzlabanUzywany[5]=false;
	    }
		return 1;
	}
	
	forward Szlaban5Otworz();
	public Szlaban5Otworz()
	{
	    new Float:Rot[3];
	    GetObjectRot(Szlaban[4],Rot[0],Rot[1],Rot[2]);
	    if(Rot[1]!=0.0)
	    {
	        SetObjectRot(Szlaban[4],Rot[0],Rot[1]-2.0,Rot[2]);
	    }
	    else
	    {
	        KillTimer(SzlabanTimer[4]);
	        SetTimer("Szlaban5Zamknij",8000,false);
	    }
		return 1;
	}

	forward Szlaban5Zamknij();
	public Szlaban5Zamknij()
	{
	    new Float:Rot[3];
	    GetObjectRot(Szlaban[4],Rot[0],Rot[1],Rot[2]);
	    if(Rot[1]!=90.0)
	    {
	        SetObjectRot(Szlaban[4],Rot[0],Rot[1]+2.0,Rot[2]);
	        SetTimer("Szlaban5Zamknij",100,false);
	    }
	    else
	    {
	        SzlabanUzywany[4]=false;
	    }
		return 1;
	}
	
	forward Szlaban4Otworz();
	public Szlaban4Otworz()
	{
	    new Float:Rot[3];
	    GetObjectRot(Szlaban[3],Rot[0],Rot[1],Rot[2]);
	    if(Rot[1]!=360.0)
	    {
	        SetObjectRot(Szlaban[3],Rot[0],Rot[1]+2.0,Rot[2]);
	    }
	    else
	    {
	        KillTimer(SzlabanTimer[3]);
	        SetTimer("Szlaban4Zamknij",8000,false);
	    }
		return 1;
	}

	forward Szlaban4Zamknij();
	public Szlaban4Zamknij()
	{
	    new Float:Rot[3];
	    GetObjectRot(Szlaban[3],Rot[0],Rot[1],Rot[2]);
	    if(Rot[1]!=270.0)
	    {
	        SetObjectRot(Szlaban[3],Rot[0],Rot[1]-2.0,Rot[2]);
	        SetTimer("Szlaban4Zamknij",100,false);
	    }
	    else
	    {
	        SzlabanUzywany[3]=false;
	    }
		return 1;
	}
	
	forward Szlaban3Otworz();
	public Szlaban3Otworz()
	{
	    new Float:Rot[3];
	    GetObjectRot(Szlaban[2],Rot[0],Rot[1],Rot[2]);
	    if(Rot[1]!=0.0)
	    {
	        SetObjectRot(Szlaban[2],Rot[0],Rot[1]-2.0,Rot[2]);
	    }
	    else
	    {
	        KillTimer(SzlabanTimer[2]);
	        SetTimer("Szlaban3Zamknij",8000,false);
	    }
		return 1;
	}

	forward Szlaban3Zamknij();
	public Szlaban3Zamknij()
	{
	    new Float:Rot[3];
	    GetObjectRot(Szlaban[2],Rot[0],Rot[1],Rot[2]);
	    if(Rot[1]!=90.0)
	    {
	        SetObjectRot(Szlaban[2],Rot[0],Rot[1]+2.0,Rot[2]);
	        SetTimer("Szlaban3Zamknij",100,false);
	    }
	    else
	    {
	        SzlabanUzywany[2]=false;
	    }
		return 1;
	}
	
	forward Szlaban2Otworz();
	public Szlaban2Otworz()
	{
	    new Float:Rot[3];
	    GetObjectRot(Szlaban[1],Rot[0],Rot[1],Rot[2]);
	    if(Rot[1]!=0.0)
	    {
	        SetObjectRot(Szlaban[1],Rot[0],Rot[1]-2.0,Rot[2]);
	    }
	    else
	    {
	        KillTimer(SzlabanTimer[1]);
	        SetTimer("Szlaban2Zamknij",8000,false);
	    }
		return 1;
	}

	forward Szlaban2Zamknij();
	public Szlaban2Zamknij()
	{
	    new Float:Rot[3];
	    GetObjectRot(Szlaban[1],Rot[0],Rot[1],Rot[2]);
	    if(Rot[1]!=90.0)
	    {
	        SetObjectRot(Szlaban[1],Rot[0],Rot[1]+2.0,Rot[2]);
	        SetTimer("Szlaban2Zamknij",100,false);
	    }
	    else
	    {
	        SzlabanUzywany[1]=false;
	    }
		return 1;
	}
	
	forward SzlabanOtworz();
	public SzlabanOtworz()
	{
	    new Float:Rot[3];
	    GetObjectRot(Szlaban[0],Rot[0],Rot[1],Rot[2]);
	    if(Rot[1]!=360.0)
	    {
	        SetObjectRot(Szlaban[0],Rot[0],Rot[1]+2.0,Rot[2]);
	    }
	    else
	    {
	        KillTimer(SzlabanTimer[0]);
	        SetTimer("SzlabanZamknij",8000,false);
	    }
		return 1;
	}
	
	forward SzlabanZamknij();
	public SzlabanZamknij()
	{
	    new Float:Rot[3];
	    GetObjectRot(Szlaban[0],Rot[0],Rot[1],Rot[2]);
	    if(Rot[1]!=270.0)
	    {
	        SetObjectRot(Szlaban[0],Rot[0],Rot[1]-2.0,Rot[2]);
	        SetTimer("SzlabanZamknij",100,false);
	    }
	    else
	    {
	        SzlabanUzywany[0]=false;
	    }
		return 1;
	}

	CMD:limity(playerid, cmdtext[])
	{
		Info(playerid,""C_ZOLTY"Limity prêdkoœci obowi¹zuj¹ce na drogach:\n"C_BIALY"Autostrady: "C_CZERWONY"130 "C_BIALY"km/h\nObszar niezabudowany: "C_CZERWONY"90 "C_BIALY"km/h\nObszar zabudowany: "C_CZERWONY"50 "C_BIALY"km/h");
	    return 1;
	}

	CMD:poziomy(playerid, cmdtext[])
	{
		Info(playerid,""C_ZOLTY"Poziomy jakie uzyskujemy podczas dostarczania ³adunków:\n"C_BIALY"1 - 10 dostarczeñ\n2 - 30 dostarczeñ\n3 - 60 dostarczeñ\n4 - 100 dostarczeñ\n5 - 300 dostarczeñ\n6 - 500 dostarczeñ\n7 - 1000 dostarczeñ\n8 - 1500 dostarczeñ\n9 - 2500 dostarczeñ\n10 - 4500 dostarczeñ");
	    return 1;
	}

	CMD:zamek(playerid, cmdtext[])
	{
		if(PlayerInfo[playerid][pDom]==9999)
		{
		    Info(playerid,""C_CZERWONY"Nie masz domu!");
		    return 1;
		}
	    new nr=PlayerInfo[playerid][pDom];
	    if(DoInRange(5.0, playerid,DomInfo[nr][dWejscieX],DomInfo[nr][dWejscieY],DomInfo[nr][dWejscieZ])||DoInRange(5.0, playerid,DomInfo[nr][dWyjscieX],DomInfo[nr][dWyjscieY],DomInfo[nr][dWyjscieZ]))
  		{
  		    if(DomInfo[nr][dZamkniety]==1)
  		    {
  		        Info(playerid,""C_ZOLTY"Drzwi otwarte!");
  		        DomInfo[nr][dZamkniety]=0;
				ZapiszDom(nr);
  		    }
  		    else
  		    {
  		        Info(playerid,""C_ZOLTY"Drzwi zamkniete!");
  		        DomInfo[nr][dZamkniety]=1;
  		        ZapiszDom(nr);
  		    }
  		}
  		else
  		{
  		    Info(playerid,""C_CZERWONY"Nie jesteœ przy drzwiach swojego domu!");
  		}
		return 1;
	}

	CMD:sprzedajdom(playerid, cmdtext[])
	{
		if(PlayerInfo[playerid][pDom]==9999)
		{
		    Info(playerid,""C_CZERWONY"Nie masz ¿adnego domu!");
		    return 1;
		}
		new nr=PlayerInfo[playerid][pDom];
		if((DoInRange(5.0, playerid,DomInfo[nr][dWejscieX],DomInfo[nr][dWejscieY],DomInfo[nr][dWejscieZ]))&&DomInfo[nr][dAktywny]==1)
  		{
		    PlayerInfo[playerid][pDom]=9999;
		    dDodajKase(playerid,DomInfo[nr][dKoszt]);
		    ZapiszKonto(playerid);
		    DomInfo[nr][dKupiony]=0;
		    DomInfo[nr][dZamkniety]=1;
			ZapiszDom(nr);
			DestroyDynamicPickup(DomPickup[nr]);
			DomPickup[nr]=CreateDynamicPickup(1273,2,DomInfo[nr][dWejscieX],DomInfo[nr][dWejscieY],DomInfo[nr][dWejscieZ],DomInfo[nr][dWejscieVir],DomInfo[nr][dWejscieInt],-1,45.0);
			format(dstring, sizeof(dstring),""C_ZOLTY"Sprzeda³eœ dom (%s) za %d$",DomInfo[nr][dOpis],DomInfo[nr][dKoszt]);
			Info(playerid,dstring);
    	}
	   	else
	    {
     		Info(playerid,""C_CZERWONY"Nie jesteœ przed w³asnym domem!");
	    }
		return 1;
	}

	CMD:kupdom(playerid, cmdtext[])
	{
		if(PlayerInfo[playerid][pDom]!=9999)
		{
		    Info(playerid,""C_CZERWONY"Masz ju¿ dom!");
		    return 1;
		}
		if(PlayerInfo[playerid][pPoziom]<1)
		{
		    Info(playerid,""C_CZERWONY"Musisz mieæ minimum 1 poziom aby kupiæ dom!");
		    return 1;
		}
		for(new nr = 0; nr < LIMIT_DOMOW; nr++)
		{
		    if((DoInRange(5.0, playerid,DomInfo[nr][dWejscieX],DomInfo[nr][dWejscieY],DomInfo[nr][dWejscieZ]))&&DomInfo[nr][dAktywny]==1)
		    {
		        if(DomInfo[nr][dKupiony]==1)
		        {
		            Info(playerid,""C_CZERWONY"Ktoœ ju¿ kupi³ ten dom!");
		    		return 1;
		        }
		        if(!dCzyMaKase(playerid,DomInfo[nr][dKoszt]))
			    {
			        Info(playerid,""C_CZERWONY"Nie staæ ciebie na zakup tego domu!");
					return 1;
				}
				dDodajKase(playerid,-DomInfo[nr][dKoszt]);
				PlayerInfo[playerid][pDom]=nr;
				ZapiszKonto(playerid);
				new nick[MAX_PLAYER_NAME];
				GetPlayerName(playerid, nick, sizeof(nick));
				strmid(DomInfo[nr][dWlasciciel], nick, 0, strlen(nick), 64);
				DomInfo[nr][dKupiony]=1;
				ZapiszDom(nr);
				DestroyDynamicPickup(DomPickup[nr]);
				DomPickup[nr]=CreateDynamicPickup(1239,2,DomInfo[nr][dWejscieX],DomInfo[nr][dWejscieY],DomInfo[nr][dWejscieZ],DomInfo[nr][dWejscieVir],DomInfo[nr][dWejscieInt],-1,45.0);
				format(dstring, sizeof(dstring),""C_ZOLTY"Kupi³eœ dom (%s) za %d$",DomInfo[nr][dOpis],DomInfo[nr][dKoszt]);
 				Info(playerid,dstring);
				return 1;
		    }
		}
		Info(playerid,""C_CZERWONY"Nie jesteœ przed ¿adnym domem!");
		return 1;
	}

	CMD:dom(playerid, cmdtext[])
	{
		if(!ToAdminLevel(playerid,3)) return 1;
		new tmp[64],idx,text[80];
		tmp = strtok(cmdtext, idx);
		if(isnull(tmp))
		{
			Info(playerid,"U¿yj: /dom (nr)\n1 - tworzenie nowego domu\n2 - edycja domu\n3 - lista istniej¹cych domów\n4 - usuñ dom");
	 		return 1;
	 	}
	 	new numer = strval(tmp);
		if(numer==1)
		{
		    if(DomTworzenie==false&&DomPkt[playerid]==0)
			{
				Info(playerid,"Ten panel aktualnie jest u¿ywany przez kogoœ innego!\nMusisz poczekaæ!");
				return 1;
			}
			tmp = strtok(cmdtext, idx);
			if(isnull(tmp))
			{
				Info(playerid,"U¿yj: /dom 1 (nr)\n1 - miejsce wejœcia\n2 - miejsce wyjœcia (interior)\n3 - opis\n4 - koszt\n5 - zapisz i dodaj\n99 - anuluj");
		 		return 1;
		 	}
		 	new punkt = strval(tmp);
		 	switch(punkt)
		 	{
		 	    case 1:
		 	    {
		 	        if(DomPkt[playerid]!=0)
			 		{
				 		Info(playerid,"Ta opcja zosta³a ju¿ wykonana lub nie robisz punktów w odpowiedniej kolejnoœci!");
				 		return 1;
		 			}
     				for(new nr = 0; nr < LIMIT_DOMOW; nr++)
					{
						if(DomInfo[nr][dAktywny]==0)
				 		{
				 			DomID[playerid]=nr;
							DomTworzenie=false;
							DomPkt[playerid]=1;
							GetPlayerPos(playerid,DomInfo[nr][dWejscieX],DomInfo[nr][dWejscieY],DomInfo[nr][dWejscieZ]);
							DomInfo[nr][dWejscieInt]=GetPlayerInterior(playerid);
							DomInfo[nr][dWejscieVir]=GetPlayerVirtualWorld(playerid);
							Info(playerid,"Pozycja wejœcia ustalona!");
							return 1;
						}
					}
					return 1;
		 	    }//koniec przypadku
		 	    case 2:
		 	    {
		 	        if(DomPkt[playerid]!=1)
			 		{
				 		Info(playerid,"Ta opcja zosta³a ju¿ wykonana lub nie robisz punktów w odpowiedniej kolejnoœci!");
				 		return 1;
		 			}
		 			new nr=DomID[playerid];
		            GetPlayerPos(playerid,DomInfo[nr][dWyjscieX],DomInfo[nr][dWyjscieY],DomInfo[nr][dWyjscieZ]);
					DomInfo[nr][dWyjscieInt]=GetPlayerInterior(playerid);
					DomPkt[playerid]=2;
					Info(playerid,"Pozycja wyjœcia (interior) ustalona!");
				 	return 1;
				}//koniec przypadku
				case 3:
		 	    {
		 	        if(DomPkt[playerid]!=2)
			 		{
				 		Info(playerid,"Ta opcja zosta³a ju¿ wykonana lub nie robisz punktów w odpowiedniej kolejnoœci!");
				 		return 1;
		 			}
		 			text=strrest(cmdtext,idx);
					if(isnull(text))
					{
						Info(playerid,"U¿yj: /dom 1 3 (opis domu)");
				 		return 1;
				 	}
				 	if(strlen(text)<3||strlen(text)>30)
					{
                        Info(playerid,"Nie poprawna d³ugoœæ nazwy!\nOd 3 do 30 liter!");
						return 1;
					}
				 	new nr=DomID[playerid];
				 	DomPkt[playerid]=3;
				 	strmid(DomInfo[nr][dOpis], text, 0, strlen(text), 64);
				 	Info(playerid,"Opis domu ustalony!");
				 	return 1;
				}//koniec przypadku
				case 4:
		 	    {
		 	        if(DomPkt[playerid]!=3)
			 		{
				 		Info(playerid,"Ta opcja zosta³a ju¿ wykonana lub nie robisz punktów w odpowiedniej kolejnoœci!");
				 		return 1;
		 			}
		 			tmp = strtok(cmdtext, idx);
					if(isnull(tmp))
					{
						Info(playerid,"U¿yj: /dom 1 4 (cena)");
				 		return 1;
				 	}
				 	new kwota=strval(tmp);
				 	if(kwota<5000||kwota>1000000)
				 	{
				 	    Info(playerid,"Od 5000$ do 1000000$");
				 	    return 1;
				 	}
				 	new nr=DomID[playerid];
				 	DomPkt[playerid]=4;
                    DomInfo[nr][dKoszt]=kwota;
                    Info(playerid,"Koszt domu ustalony!");
				 	return 1;
				}//koniec przypadku
				case 5:
		 	    {
		 	        if(DomPkt[playerid]!=4)
			 		{
				 		Info(playerid,"Nie wykona³eœ jeszcze wszystkich punktów!");
				 		return 1;
		 			}
		 			new nr=DomID[playerid];
		 			DomInfo[nr][dAktywny]=1;
		 			DomInfo[nr][dKupiony]=0;
		 			DomInfo[nr][dZamkniety]=1;
		 			ZapiszDom(nr);
		 			DomPickup[nr]=CreateDynamicPickup(1273,2,DomInfo[nr][dWejscieX],DomInfo[nr][dWejscieY],DomInfo[nr][dWejscieZ],DomInfo[nr][dWejscieVir],DomInfo[nr][dWejscieInt],-1,45.0);
		 			DomID[playerid]=9999;
					DomPkt[playerid]=0;
					DomTworzenie=true;
		 			format(dstring, sizeof(dstring),"Poprawnie doda³eœ dom o ID: %d",nr);
		 			Info(playerid,dstring);
		 			SetPlayerPos(playerid,DomInfo[nr][dWejscieX],DomInfo[nr][dWejscieY],DomInfo[nr][dWejscieZ]);
		 			SetPlayerInterior(playerid,DomInfo[nr][dWejscieInt]);
		 			SetPlayerVirtualWorld(playerid,DomInfo[nr][dWejscieVir]);
		 	        return 1;
		 	    }//koniec przypadku
		 	    case 99:
		 	    {
		 	        if(DomPkt[playerid]==0)
			 		{
				 		Info(playerid,"Nie mo¿esz anulowaæ pracy, poniewa¿ jej nie zacze³eœ!");
				 		return 1;
		 			}
		 			DomID[playerid]=9999;
					DomPkt[playerid]=0;
					DomTworzenie=true;
					Info(playerid,"Praca anulowana!");
		 	        return 1;
		 	    }//koniec przypadku
			}
			return 1;
		}
		else if(numer==2)
		{
			tmp = strtok(cmdtext, idx);
			if(isnull(tmp))
			{
				Info(playerid,"U¿yj: /dom 2 (id domu) (nr)\n1 - miejsce wejœcia\n2 - miejsce wyjœcia (interior)\n3 - opis\n4 - koszt");
		 		return 1;
		 	}
		 	new nr = strval(tmp);
		 	tmp = strtok(cmdtext, idx);
		 	new punkt = strval(tmp);
		 	if(DomInfo[nr][dAktywny]==0)
 			{
 			    Info(playerid,"Nie poprawne id domu!");
 			    return 1;
 			}
		 	switch(punkt)
		 	{
		 	    case 1:
				{
					GetPlayerPos(playerid,DomInfo[nr][dWejscieX],DomInfo[nr][dWejscieY],DomInfo[nr][dWejscieZ]);
					DomInfo[nr][dWejscieInt]=GetPlayerInterior(playerid);
					DomInfo[nr][dWejscieVir]=GetPlayerVirtualWorld(playerid);
					DestroyDynamicPickup(DomPickup[nr]);
					DomPickup[nr]=CreateDynamicPickup(1273,2,DomInfo[nr][dWejscieX],DomInfo[nr][dWejscieY],DomInfo[nr][dWejscieZ],DomInfo[nr][dWejscieVir],DomInfo[nr][dWejscieInt],-1,45.0);
					Info(playerid,"Pozycja wejœcia zmieniona!");
					ZapiszDom(nr);
					return 1;
		 	    }//koniec przypadku
		 	    case 2:
		 	    {
		            GetPlayerPos(playerid,DomInfo[nr][dWyjscieX],DomInfo[nr][dWyjscieY],DomInfo[nr][dWyjscieZ]);
					DomInfo[nr][dWyjscieInt]=GetPlayerInterior(playerid);
					Info(playerid,"Pozycja wyjœcia (interior) zmieniona!");
					ZapiszDom(nr);
				 	return 1;
				}//koniec przypadku
				case 3:
		 	    {
		 			text=strrest(cmdtext,idx);
					if(isnull(text))
					{
						Info(playerid,"U¿yj: /dom 2 (id) 3 (opis domu)");
				 		return 1;
				 	}
				 	if(strlen(text)<3||strlen(text)>30)
					{
                        Info(playerid,"Nie poprawna d³ugoœæ nazwy!\nOd 3 do 30 liter!");
						return 1;
					}
				 	strmid(DomInfo[nr][dOpis], text, 0, strlen(text), 64);
				 	Info(playerid,"Opis domu ustalony!");
				 	ZapiszDom(nr);
				 	return 1;
				}//koniec przypadku
				case 4:
		 	    {
		 			tmp = strtok(cmdtext, idx);
					if(isnull(tmp))
					{
						Info(playerid,"U¿yj: /dom 2 (id) 4 (cena)");
				 		return 1;
				 	}
				 	new kwota=strval(tmp);
				 	if(kwota<5000||kwota>1000000)
				 	{
				 	    Info(playerid,"Od 5000$ do 1000000$");
				 	    return 1;
				 	}
                    DomInfo[nr][dKoszt]=kwota;
                    Info(playerid,"Koszt domu zmieniony!");
                    ZapiszDom(nr);
				 	return 1;
				}//koniec przypadku
			}
			return 1;
		}
		else if(numer==3)
		{
		    SendClientMessage(playerid,KOLOR_ZOLTY,"Istniej¹ce domy:");
		    for(new nr = 0; nr < LIMIT_DOMOW; nr++)
			{
				if(DomInfo[nr][dAktywny]==1)
	 			{
		    		format(dstring, sizeof(dstring),"Dom [%d], opis: %s",nr,DomInfo[nr][dOpis]);
		    		SendClientMessage(playerid,KOLOR_BIALY,dstring);
				}
			}
			return 1;
		}
		else if(numer==4)
		{
			tmp = strtok(cmdtext, idx);
			if(isnull(tmp))
			{
				Info(playerid,"U¿yj: /dom 4 (id)");
	 			return 1;
		 	}
		 	new nr=strval(tmp);
		 	if(DomInfo[nr][dAktywny]==0)
 			{
 			    Info(playerid,"Taki dom nie istnieje!");
 			    return 1;
 			}
 			DestroyDynamicPickup(DomPickup[nr]);
 			DomInfo[nr][dAktywny]=0;
 			ZapiszDom(nr);
 			Info(playerid,"Dom zosta³ usuniêty!");
			return 1;
		}
		return 1;
	}

	CMD:rsp(playerid, cmdtext[])
	{
		if(!ToAdminLevel(playerid,2)) return 1;
		new bool:Uzywany[LIMIT_SAMOCHODOW]=false,v;
        foreach(Player,i)
		{
		    if(IsPlayerInAnyVehicle(i))
		    {
				v=GetPlayerVehicleID(i);
		        Uzywany[v]=true;
		        if(IsTrailerAttachedToVehicle(v)) Uzywany[GetVehicleTrailer(v)]=true;
		    }
		}
		for(new nr = 1; nr < LIMIT_SAMOCHODOW; nr++)
		{
			if(Uzywany[nr]==false)
			{
				SetVehicleToRespawn(nr);
				SetVehicleParamsEx(nr,false,false,false,false,false,false,false);
				vPojazdZycie[nr]=1000.0;
			}
		}
        format(dstring, sizeof(dstring),"~r~(%d)%s ~w~zrespawnowal wszystkie nieuzywane pojazdy!",playerid,Nick(playerid));
  		NapisText(dstring);
		return 1;
	}

	CMD:rspall(playerid, cmdtext[])
	{
		if(!ToAdminLevel(playerid,2)) return 1;
		for(new nr = 1; nr < LIMIT_SAMOCHODOW; nr++)
		{
			SetVehicleToRespawn(nr);
			SetVehicleParamsEx(nr,false,false,false,false,false,false,false);
			vPojazdZycie[nr]=1000.0;
		}
        format(dstring, sizeof(dstring),"~r~(%d)%s ~w~zrespawnowal wszystkie pojazdy!",playerid,Nick(playerid));
  		NapisText(dstring);
		return 1;
	}

	CMD:tankujall(playerid, cmdtext[])
	{
		if(!ToAdminLevel(playerid,2)) return 1;
		for(new nr = 1; nr < LIMIT_SAMOCHODOW; nr++)
		{
			vPaliwo[nr]=vPaliwoMax[nr];
		}
        format(dstring, sizeof(dstring),"~r~(%d)%s ~w~zatankowal wszystkie pojazdy!",playerid,Nick(playerid));
  		NapisText(dstring);
		return 1;
	}

	CMD:frakcja(playerid, cmdtext[])
	{
	    if(PlayerInfo[playerid][pFrakcja]==0)
		{
		    Info(playerid,""C_CZERWONY"Nie pracujesz w PD!");
		    return 1;
		}
        if(!ToPD(playerid))
        {
            Info(playerid,""C_CZERWONY"Nie jesteœ w mundurze!\nKomenda /skin s³u¿y do zmiany skinu.");
            return 1;
        }
        Info(playerid,""C_ZOLTY"Police Department\n/blokada = (/kol)czatka - /zbierz - (/m)andat - /scigany - /scigani - /areszt - (/s)uszarka - /sprawdz - (/r)adio - /taryfikator");
	    return 1;
	}

	COMMAND:radio(playerid,cmdtext[])
	{
	  return cmd_r(playerid,cmdtext);
	}

	CMD:taryfikator(playerid, cmdtext[])
	{
        Info(playerid,""C_BIALY"Jazda pod pr¹d: "C_CZERWONY"300-800$\n"C_BIALY"Jazda z zgaszonymi œwiat³ami noc¹: "C_CZERWONY"200$\n"C_BIALY"Prze³adowany ³adunek: "C_CZERWONY"2500$\n"C_BIALY"Przekroczenie prêdkoœci: "C_CZERWONY"300-1000$\n"C_BIALY"Ucieczka przed policj¹: "C_CZERWONY"3000-5000$");
        return 1;
 	}

	CMD:r(playerid, cmdtext[])
	{
	    if(!ToPD(playerid))
        {
            Info(playerid,""C_CZERWONY"Nie jesteœ w mundurze lub nie pracujesz w policji!");
            return 1;
        }
        if(PlayerInfo[playerid][pWyciszony]>=1)
		{
		    Info(playerid,""C_CZERWONY"Jesteœ wyciszony!");
			return 1;
		}
	    new text[80],idx;
		text=strrest(cmdtext,idx);
		if(isnull(text))
		{
			Info(playerid,"U¿yj: (/r)adio (tekst)");
			return 1;
		}
		UpperToLower(text);
		foreach(Player,i)
		{
  			if(ToPD(i))
	    	{
    			format(dstring,sizeof(dstring),"(PD-Radio)[%d]%s: "C_BIALY"%s",playerid,Nick(playerid),text);
	 			SendClientMessage(i,KOLOR_ZOLTY,dstring);
			}
		}
		return 1;
	}

	CMD:dajkase(playerid, cmdtext[])
	{
	    if(PlayerInfo[playerid][pPoziom]<1)
	    {
	    	Info(playerid,""C_CZERWONY"Musisz mieæ co najmniej 1-szy poziom aby u¿yæ tej komendy!");
	 	    return 1;
	    }
        new tmp[64],idx;
		tmp = strtok(cmdtext, idx);
		if(isnull(tmp))
		{
			Info(playerid,"U¿yj: /dajkase (id) (kwota)");
			return 1;
 		}
	 	new playa = strval(tmp);
	 	tmp = strtok(cmdtext, idx);
	 	new kwota = strval(tmp);
	 	if(kwota<1||kwota>dKasa[playerid])
	 	{
	 	    Info(playerid,""C_CZERWONY"Nie poprawna kwota!");
	 	    return 1;
	 	}
		if(IsPlayerConnected(playa)&&playa!=playerid)
	 	{
	 	    dDodajKase(playa,kwota);
	 	    dDodajKase(playerid,-kwota);
	 	    format(dstring,sizeof(dstring),""C_ZOLTY"Gracz [%d]%s da³ tobie %d$",playerid,Nick(playerid),kwota);
			Info(playa,dstring);
			format(dstring,sizeof(dstring),""C_ZOLTY"Da³eœ %d$ graczowi [%d]%s",kwota,playa,Nick(playa));
			Info(playerid,dstring);
	 	    return 1;
		}
		else
		{
		    Info(playerid,""C_CZERWONY"Nie poprawne id!");
		}
		return 1;
	}
	
	CMD:sprawdz(playerid, cmdtext[])
	{
        if(!ToPD(playerid))
        {
            Info(playerid,""C_CZERWONY"Nie jesteœ w mundurze lub nie pracujesz w policji!");
            return 1;
        }
        new tmp[64],idx;
		tmp = strtok(cmdtext, idx);
		if(isnull(tmp))
		{
			Info(playerid,"U¿yj: /sprawdz (id)");
			return 1;
 		}
	 	new playa = strval(tmp);
	 	if(IsPlayerConnected(playa)&&playa!=playerid)
	 	{
	 	    if(!OdlegloscGracze(20.0,playerid,playa))
		 	{
		 	    GInfo(playerid,"~r~gracz jest za daleko od ciebie",3);
		 	    return 1;
		 	}
		 	if(GetPlayerState(playa)!=PLAYER_STATE_DRIVER)
		 	{
                GInfo(playerid,"~r~gracz nie jest kierowca zadnego pojazdu",3);
		 	    return 1;
		 	}
			if(Misja[playa]==false||MisjaStopien[playa]==0)
			{
			    format(dstring,sizeof(dstring),"Pojazd %s,kierowca: [%d]%s, towar (brak).",GetVehicleName(GetPlayerVehicleID(playa)),playa,Nick(playa));
 				SendClientMessage(playerid,KOLOR_NIEBIESKI,dstring);
 				format(dstring,sizeof(dstring),"Policjant [%d]%s skontrolowa³ ciebie, ale nie wieziesz towaru!",playerid,Nick(playerid));
 				SendClientMessage(playa,KOLOR_NIEBIESKI,dstring);
		 	    return 1;
			}

			format(dstring,sizeof(dstring),"Policjant [%d]%s kontroluje ³adunek,który wieziesz!",playerid,Nick(playerid));
			SendClientMessage(playerid,KOLOR_NIEBIESKI,dstring);

			if(Przeladowany[playa]==true)
			{
				format(dstring,sizeof(dstring),"Pojazd %s,kierowca: [%d]%s, towar(%s): "C_CZERWONY"prze³adowany!",GetVehicleName(GetPlayerVehicleID(playa)),playa,Nick(playa),LadunekInfo[MisjaID[playa]][lTowar]);
 				SendClientMessage(playerid,KOLOR_NIEBIESKI,dstring);
 				format(dstring,sizeof(dstring),"Policjant [%d]%s skontrolowa³ twój pojazd i wykry³, ¿e jesteœ: "C_CZERWONY"prze³adowany!",playerid,Nick(playerid));
 				SendClientMessage(playa,KOLOR_NIEBIESKI,dstring);
			}
			else
			{
			    format(dstring,sizeof(dstring),"Pojazd %s,kierowca: [%d]%s, towar(%s): "C_ZIELONY"nie prze³adowany!",GetVehicleName(GetPlayerVehicleID(playa)),playa,Nick(playa),LadunekInfo[MisjaID[playa]][lTowar]);
 				SendClientMessage(playerid,KOLOR_NIEBIESKI,dstring);
 				format(dstring,sizeof(dstring),"Policjant [%d]%s skontrolowa³ twój pojazd i wykry³, ¿e jesteœ: "C_ZIELONY"nie prze³adowany!",playerid,Nick(playerid));
 				SendClientMessage(playa,KOLOR_NIEBIESKI,dstring);
			}
			return 1;
		}
		else
		{
		    Info(playerid,""C_CZERWONY"Nie poprawne id!");
		}
		return 1;
	}
	
	COMMAND:s(playerid,cmdtext[])
	{
	  return cmd_suszarka(playerid,cmdtext);
	}

	CMD:suszarka(playerid, cmdtext[])
	{
        if(!ToPD(playerid))
        {
            Info(playerid,""C_CZERWONY"Nie jesteœ w mundurze lub nie pracujesz w policji!");
            return 1;
        }
        if(GetPlayerInterior(playerid)!=0)
        {
        	Info(playerid,""C_CZERWONY"Nie mo¿esz u¿ywaæ tej komendy w interiorze!");
            return 1;
        }
        new Float:Pos[3];
        GetPlayerPos(playerid,Pos[0],Pos[1],Pos[2]);
        SendClientMessage(playerid,KOLOR_BIALY,"Pojazdy namierzone suszark¹:");
        foreach(Player,i)
		{
		    if(GetPlayerState(i)==PLAYER_STATE_DRIVER&&GetPlayerSpeed(i)>5&&DoInRange(90.0, i,Pos[0],Pos[1],Pos[2])&&i!=playerid)
		    {
		        new w=GetPlayerSpeed(i);
		        format(dstring,sizeof(dstring),"Policjant [%d]%s namierzy³ twój pojazd 'suszark¹',wskaza³o: "C_ZOLTY"%d km/h",playerid,Nick(playerid),w);
		 		SendClientMessage(i,KOLOR_NIEBIESKI,dstring);
		 		format(dstring,sizeof(dstring),"Pojazd %s,kierowca: [%d]%s, prêdkoœæ: "C_ZOLTY"%d km/h",GetVehicleName(GetPlayerVehicleID(i)),i,Nick(i),w);
		 		SendClientMessage(playerid,KOLOR_NIEBIESKI,dstring);
		    }
		}
		return 1;
	}

	CMD:areszt(playerid, cmdtext[])
	{
        if(!ToPD(playerid))
        {
            Info(playerid,""C_CZERWONY"Nie jesteœ w mundurze lub nie pracujesz w policji!");
            return 1;
        }
        new tmp[64],idx;
		tmp = strtok(cmdtext, idx);
		if(isnull(tmp))
		{
			Info(playerid,"U¿yj: /areszt (id)");
			return 1;
 		}
	 	new playa = strval(tmp);
	 	if(IsPlayerConnected(playa)&&playa!=playerid)
	 	{
		 	if(PlayerInfo[playa][pScigany]==0)
	 	    {
	 	        GInfo(playerid,"~r~gracz nie jest poszukiwany",3);
	 	        return 1;
	 	    }
	 	    if(!OdlegloscGracze(15.0,playerid,playa))
		 	{
		 	    GInfo(playerid,"~r~gracz jest za daleko od ciebie",3);
		 	    return 1;
		 	}
			if(Misja[playa]==true)
			{
			    Info(playa,""C_ZOLTY"Misja przerwana, otrzyma³eœ grzywnê w wysokoœci: "C_CZERWONY"1000$");
				dDodajKase(playa,-1000);
				AnulujMisje(playa);
			}
		 	new kara=PlayerInfo[playa][pScigany]*2;
		 	SetPlayerPos(playa,264.9535,77.5068,1001.0391);
		    SetPlayerInterior(playa,6);
		    SetPlayerVirtualWorld(playa,playa);
		    SetPlayerWorldBounds(playa,268.5071,261.3936,81.6285,71.8745);
		    dUstawHP(playa,100);
            format(dstring,sizeof(dstring),"Policjant [%d]%s aresztowa³ ciebie na %d minut/y.",playerid,Nick(playerid),kara);
		 	SendClientMessage(playa,KOLOR_NIEBIESKI,dstring);
		 	format(dstring,sizeof(dstring),"Aresztowa³eœ [%d]%s na %d minut/y. Zarobi³eœ: %d$",playa,Nick(playa),kara,PlayerInfo[playa][pMandat]);
		 	SendClientMessage(playerid,KOLOR_NIEBIESKI,dstring);
		 	format(dstring,sizeof(dstring),"Policjant [%d]%s "C_ZOLTY"aresztowa³ "C_NIEBIESKI"[%d]%s na "C_ZOLTY"%d minut/y.",playerid,Nick(playerid),playa,Nick(playa),kara);
		 	SendClientMessageToAll(KOLOR_BIALY,dstring);
		 	PlayerInfo[playa][pJail]=kara;
			PlayerInfo[playa][pScigany]=0;
			SetPlayerWantedLevel(playa,0);
			dDodajKase(playa,-PlayerInfo[playa][pMandat]);
			dDodajKase(playerid,PlayerInfo[playa][pMandat]);
			PlayerInfo[playa][pMandat]=0;
		 	ZapiszKonto(playa);
	 	    return 1;
		}
		else
		{
		    Info(playerid,""C_CZERWONY"Nie poprawne id!");
		}
		return 1;
	}

	CMD:scigani(playerid, cmdtext[])
	{
        if(!ToPD(playerid))
        {
            Info(playerid,""C_CZERWONY"Nie jesteœ w mundurze lub nie pracujesz w policji!");
            return 1;
        }
        SendClientMessage(playerid,KOLOR_BIALY," ");
        SendClientMessage(playerid,KOLOR_BIALY,"* Poszukiwane osoby:");
		foreach(Player,i)
		{
		    if(PlayerInfo[i][pScigany]>=1)
		    {
		        format(dstring,sizeof(dstring),"[%d] %s - poziom: "C_ZOLTY"%d/6",playerid,Nick(playerid),PlayerInfo[i][pScigany]);
		 		SendClientMessage(playerid,KOLOR_NIEBIESKI,dstring);
		    }
		}
		return 1;
	}

	CMD:scigany(playerid, cmdtext[])
	{
        if(!ToPD(playerid))
        {
            Info(playerid,""C_CZERWONY"Nie jesteœ w mundurze lub nie pracujesz w policji!");
            return 1;
        }
        new tmp[64],idx;
		tmp = strtok(cmdtext, idx);
		if(isnull(tmp))
		{
			Info(playerid,"U¿yj: /scigany (id) (wartoœæ 1-6)");
			return 1;
 		}
	 	new playa = strval(tmp);
	 	tmp = strtok(cmdtext, idx);
	 	new kara = strval(tmp);
	 	if(kara<1||kara>6)
		{
		    Info(playerid,""C_CZERWONY"Poziom poszukiwañ od 1 do 6!");
		    return 1;
		}
	 	if(IsPlayerConnected(playa)&&playa!=playerid)
	 	{
		 	if(PlayerInfo[playa][pScigany]==0)
	 	    {
	 	        Info(playerid,""C_CZERWONY"Ten gracz nie jest poszukiwany!");
	 	        return 1;
	 	    }
		 	PlayerInfo[playa][pScigany]=kara;
		 	SetPlayerWantedLevel(playa,PlayerInfo[playa][pScigany]);
		 	ZapiszKonto(playa);
		 	format(dstring,sizeof(dstring),"Policjant [%d]%s ustawi³ tobie poziom poszukiwañ na: "C_ZOLTY"%d/6",playerid,Nick(playerid),kara);
		 	SendClientMessage(playa,KOLOR_NIEBIESKI,dstring);
		 	format(dstring,sizeof(dstring),"Ustawi³eœ [%d]%s poziom poszukiwañ na "C_ZOLTY"%d/6",playa,Nick(playa),kara);
		 	SendClientMessage(playerid,KOLOR_NIEBIESKI,dstring);
	 	}
	 	else
	 	{
	 	    Info(playerid,""C_CZERWONY"Nie poprawne id!");
	 	}
		return 1;
	}

	CMD:rachunek(playerid, cmdtext[])
	{
	    if(PlayerInfo[playerid][pMandat]<1)
	    {
	        Info(playerid,""C_CZERWONY"Nie masz ¿adnych zaleg³ych mandatów!");
            return 1;
	    }
	    if(PlayerInfo[playerid][pScigany]>=1)
	    {
	        Info(playerid,""C_CZERWONY"Teraz ju¿ za póŸno na sp³atê d³ugów\nPoddaj siê policji!");
            return 1;
	    }
	    if(!dCzyMaKase(playerid,PlayerInfo[playerid][pMandat]))
	    {
	        Info(playerid,""C_CZERWONY"Nie staæ ciebie na zap³acenie mandatu!");
			return 1;
		}
	    new pd=MandatPD[playerid];
	    if(IsPlayerConnected(pd)&&ToPD(pd))
	    {
	 		format(dstring,sizeof(dstring),"Zap³aci³eœ mandat [%d]%s w wysokoœci: "C_ZOLTY"%d$",pd,Nick(pd),PlayerInfo[playerid][pMandat]);
            Info(playerid,dstring);
            format(dstring,sizeof(dstring),"[%d]%s zap³aci³ tobie mandat: "C_ZOLTY"(%d$)",playerid,Nick(playerid),PlayerInfo[playerid][pMandat]);
            Info(pd,dstring);
            dDodajKase(playerid,-PlayerInfo[playerid][pMandat]);
            dDodajKase(pd,PlayerInfo[playerid][pMandat]);
            PlayerInfo[playerid][pMandat]=0;
            ZapiszKonto(playerid);
            MandatPD[playerid]=999;
		}
		else
		{
            format(dstring,sizeof(dstring),"Zap³aci³eœ mandat w wysokoœci: "C_ZOLTY"%d$",PlayerInfo[playerid][pMandat]);
            Info(playerid,dstring);
            dDodajKase(playerid,-PlayerInfo[playerid][pMandat]);
            PlayerInfo[playerid][pMandat]=0;
            ZapiszKonto(playerid);
            MandatPD[playerid]=999;
		}
	    return 1;
	}
	
	COMMAND:m(playerid,cmdtext[])
	{
	  return cmd_mandat(playerid,cmdtext);
	}

	CMD:mandat(playerid, cmdtext[])
	{
        if(!ToPD(playerid))
        {
            Info(playerid,""C_CZERWONY"Nie jesteœ w mundurze lub nie pracujesz w policji!");
            return 1;
        }
        new tmp[64],idx;
		tmp = strtok(cmdtext, idx);
		if(isnull(tmp))
		{
			Info(playerid,"U¿yj: (/m)andat (id) (wartoœæ)");
			return 1;
 		}
	 	new playa = strval(tmp);
	 	tmp = strtok(cmdtext, idx);
	 	new kara = strval(tmp);
	 	if(kara<100||kara>5000)
		{
		    Info(playerid,""C_CZERWONY"Mandat od 100$ do 5000$!");
		    return 1;
		}
	 	if(IsPlayerConnected(playa)&&playa!=playerid)
	 	{
	 	    if(!OdlegloscGracze(20.0,playerid,playa))
		 	{
		 	    GInfo(playerid,"~r~gracz jest za daleko od ciebie",3);
		 	    return 1;
		 	}
		 	if(PlayerInfo[playa][pScigany]>=1)
	 	    {
	 	        GInfo(playerid,"~r~ten gracz jest juz poszukiwany, aresztuj go!",3);
	 	        return 1;
	 	    }
	 	    if(PlayerInfo[playa][pMandat]>=1)
	 	    {
	 	        GInfo(playerid,"~r~ten gracz ma juz zalegly mandat!",3);
	 	        return 1;
	 	    }
	 	    MandatPD[playa]=playerid;
		 	PlayerInfo[playa][pMandat]+=kara;
		 	ZapiszKonto(playa);
		 	KillTimer(MandatTimer[playa]);
			MandatTimer[playa]=SetTimerEx("MandatPlac",60000,false,"i",playa);
		 	format(dstring,sizeof(dstring),"Policjant [%d]%s wystawi³ tobie mandat (%d$). "C_ZOLTY"U¿yj: /rachunek - aby zap³aciæ mandat!",playerid,Nick(playerid),kara);
		 	SendClientMessage(playa,KOLOR_NIEBIESKI,dstring);
		 	format(dstring,sizeof(dstring),"Wystawi³eœ [%d]%s mandat na kwotê %d$. "C_ZOLTY"Poczekaj na zap³atê.",playa,Nick(playa),kara);
		 	SendClientMessage(playerid,KOLOR_NIEBIESKI,dstring);
	 	}
	 	else
	 	{
	 	    Info(playerid,""C_CZERWONY"Nie poprawne id!");
	 	}
		return 1;
	}

	forward MandatPlac(playerid);
	public MandatPlac(playerid)
	{
	    if(PlayerInfo[playerid][pMandat]>0)
	    {
			PlayerInfo[playerid][pScigany]=1;
			SetPlayerWantedLevel(playerid,1);
			ZapiszKonto(playerid);
			SendClientMessage(playerid,KOLOR_ROZOWY,"Nie zap³aci³eœ mandatu! Jesteœ poszukiwany przez policjê!");
			foreach(Player,i)
			{
			    if(ToPD(i))
			    {
	        		format(dstring,sizeof(dstring),"[%d]%s nie zap³aci³ mandatu na czas! Jego poziom poszukiwañ wzrasta do 1 gwiazdki!",playerid,Nick(playerid));
		 			SendClientMessage(i,KOLOR_ROZOWY,dstring);
		 			SendClientMessage(i,KOLOR_ROZOWY,"Gracz zostaje oznaczony na ró¿owo na radarze!");
		 			SetPlayerMarkerForPlayer(i, playerid, KOLOR_ROZOWY);
				}
			}
	    }
	    return 1;
	}

	stock OdlegloscGracze(Float:odleglosc, playerid, gracz)
	{
		if(IsPlayerConnected(playerid)&&IsPlayerConnected(gracz))
		{
			new Float:Pos[3];
			GetPlayerPos(gracz,Pos[0],Pos[1],Pos[2]);
			if(IsPlayerInRangeOfPoint(playerid, odleglosc, Pos[0],Pos[1],Pos[2]))
			{
			    return 1;
			}
		}
		return 0;
	}

	CMD:skin(playerid, cmdtext[])
	{
	    if(Misja[playerid]==true)
		{
		    Info(playerid,""C_CZERWONY"Podczas misji nie mo¿na u¿yæ tej komendy!");
		    return 1;
		}
		if(IsPlayerInAnyVehicle(playerid))
		{
		    Info(playerid,""C_CZERWONY"Nie mo¿esz byæ w pojeŸdzie!");
		    return 1;
		}
		if(PlayerInfo[playerid][pScigany]>=1)
		{
			Info(playerid,""C_CZERWONY"Jesteœ poszukiwany, nie mo¿esz u¿yæ tej komendy");
			return 1;
		}
		if(PlayerInfo[playerid][pMandat]>=1)
		{
			Info(playerid,""C_CZERWONY"Masz zaleg³e mandaty, nie mo¿esz u¿yæ tej komendy zanim nie zap³acisz mandatu!");
			return 1;
		}
		if(!dCzyMaKase(playerid,1))
	    {
	        Info(playerid,""C_CZERWONY"Nie masz pieniêdzy!");
			return 1;
		}
        ForceClassSelection(playerid);
    	dUstawHP(playerid,0);
	    return 1;
	}

	CMD:zbierz(playerid, cmdtext[])
	{
 		if(!ToPD(playerid))
        {
            Info(playerid,""C_CZERWONY"Nie jesteœ w mundurze lub nie pracujesz w policji!");
            return 1;
        }
        if(Kolczatki==0)
		{
  			Info(playerid,""C_CZERWONY"¯adna kolczatka nie jest postawiona!");
	    	return 1;
		}
		Kolczatki=0;
		for(new c=0;c<5;c++)
		{
			DestroyObject(KolczatkaObiekt[c]);
			Kolczatka[c]=false;
		}
		Info(playerid,""C_ZOLTY"Kolczatki usuniête!");
		return 1;
	}

	COMMAND:kol(playerid,cmdtext[])
	{
	  return cmd_kolczatka(playerid,cmdtext);
	}

	CMD:kolczatka(playerid, cmdtext[])
	{
        if(!ToPD(playerid))
        {
            Info(playerid,""C_CZERWONY"Nie jesteœ w mundurze lub nie pracujesz w policji!");
            return 1;
        }
        if(IsPlayerInAnyVehicle(playerid))
 		{
			Info(playerid,""C_CZERWONY"Nie mo¿esz po³o¿yæ blokady bêd¹c w pojeŸdzie!");
   			return 1;
   		}
   		if(Kolczatki>=5)
   		{
   		    Info(playerid,""C_CZERWONY"Nie mo¿na po³o¿yæ wiêkszej iloœci kolczatek! U¿yj cmd: /zbierz");
   			return 1;
   		}
   		new Float:pos[4],n=Kolczatki;
   		Kolczatki++;
		GetPlayerPos(playerid,pos[0],pos[1],pos[2]);
		GetPlayerFacingAngle(playerid,pos[3]);
		switch(n)
		{
		    case 0:
		    {
		        Kolczatka[0]=true;
				KolczatkaObiekt[0]=CreateObject(2892,pos[0],pos[1],pos[2]-1,0,0,pos[3]+90);
				KolPosX[0]=pos[0]; KolPosY[0]=pos[1]; KolPosZ[0]=pos[2];
				Info(playerid,""C_ZOLTY"Rozstawi³eœ kolczatkê numer 1!");
				return 1;
		    }
		    case 1:
		    {
      			Kolczatka[1]=true;
			 	KolczatkaObiekt[1]=CreateObject(2892,pos[0],pos[1],pos[2]-1,0,0,pos[3]+90);
			 	KolPosX[1]=pos[0]; KolPosY[1]=pos[1]; KolPosZ[1]=pos[2];
			 	Info(playerid,""C_ZOLTY"Rozstawi³eœ kolczatkê numer 2!");
			 	return 1;
		    }
		    case 2:
		    {
		    	Kolczatka[2]=true;
			 	KolczatkaObiekt[2]=CreateObject(2892,pos[0],pos[1],pos[2]-1,0,0,pos[3]+90);
			 	KolPosX[2]=pos[0]; KolPosY[2]=pos[1]; KolPosZ[2]=pos[2];
			 	Info(playerid,""C_ZOLTY"Rozstawi³eœ kolczatkê numer 3!");
			 	return 1;
		    }
		    case 3:
		    {
		        Kolczatka[3]=true;
			 	KolczatkaObiekt[3]=CreateObject(2892,pos[0],pos[1],pos[2]-1,0,0,pos[3]+90);
			 	KolPosX[3]=pos[0]; KolPosY[3]=pos[1]; KolPosZ[3]=pos[2];
			 	Info(playerid,""C_ZOLTY"Rozstawi³eœ kolczatkê numer 4!");
			 	return 1;
		    }
		    case 4:
		    {
		    	Kolczatka[4]=true;
			 	KolczatkaObiekt[4]=CreateObject(2892,pos[0],pos[1],pos[2]-1,0,0,pos[3]+90);
			 	KolPosX[4]=pos[0]; KolPosY[4]=pos[1]; KolPosZ[4]=pos[2];
			 	Info(playerid,""C_ZOLTY"Rozstawi³eœ kolczatkê numer 5!");
			 	return 1;
		    }
		}
   		return 1;
	}

	CMD:blokada(playerid, cmdtext[])
	{
        if(!ToPD(playerid))
        {
            Info(playerid,""C_CZERWONY"Nie jesteœ w mundurze lub nie pracujesz w policji!");
            return 1;
        }
        if(IsPlayerInAnyVehicle(playerid))
 		{
			Info(playerid,""C_CZERWONY"Nie mo¿esz po³o¿yæ kolczatki bêd¹c w pojeŸdzie!");
   			return 1;
   		}
        new tmp[64],idx;
		tmp = strtok(cmdtext, idx);
		if(isnull(tmp))
		{
			Info(playerid,"U¿yj: /blokada (numer)\n1 - 6 (ró¿ne blokadki)\n7 - usuwasz wszystkie blokady");
			return 1;
 		}
	 	new id = strval(tmp);
		if(id<1||id>7) return 1;
		new n=Blokady,Float:Pos[4];
		Blokady++;
  		GetPlayerPos(playerid,Pos[0],Pos[1],Pos[2]);
    	GetPlayerFacingAngle(playerid,Pos[3]);
        switch(id)
        {
            case 1:
			{
			    if(Blokady>=14)
			    {
				    Info(playerid,""C_CZERWONY"Maskymalna iloœæ blokadek, usuñ je za pomoc¹ komendy /blokada 7");
				    return 1;
			    }
				Blokadka[n]=CreateObject(979,Pos[0]+1.0, Pos[1]+1.0, Pos[2]-0.3, 0.0, 0.0000, Pos[3]); Info(playerid,""C_ZOLTY"Blokada postawiona!");
			}
            case 2:
			{
			    if(Blokady>=14)
			    {
				    Info(playerid,""C_CZERWONY"Maskymalna iloœæ blokadek, usuñ je za pomoc¹ komendy /usun-blokady");
				    return 1;
			    }
		 		Blokadka[n]=CreateObject(1228,Pos[0]+1.0, Pos[1]+1.0, Pos[2]-0.4, 0.0, 0.0000, Pos[3]); Info(playerid,""C_ZOLTY"Blokada postawiona!");
			}
            case 3:
			{
			    if(Blokady>=14)
			    {
				    Info(playerid,""C_CZERWONY"Maskymalna iloœæ blokadek, usuñ je za pomoc¹ komendy /usun-blokady");
				    return 1;
			    }
		 		Blokadka[n]=CreateObject(1237,Pos[0]+1.0, Pos[1]+1.0, Pos[2]-0.8, 0.0, 0.0000, Pos[3]); Info(playerid,""C_ZOLTY"Blokada postawiona!");
			}
            case 4:
			{
			    if(Blokady>=14)
			    {
				    Info(playerid,""C_CZERWONY"Maskymalna iloœæ blokadek, usuñ je za pomoc¹ komendy /usun-blokady");
				    return 1;
			    }
		 		Blokadka[n]=CreateObject(1427,Pos[0]+1.0, Pos[1]+1.0, Pos[2]-0.4, 0.0, 0.0000, Pos[3]); Info(playerid,""C_ZOLTY"Blokada postawiona!");
			}
            case 5:
			{
			    if(Blokady>=14)
			    {
				    Info(playerid,""C_CZERWONY"Maskymalna iloœæ blokadek, usuñ je za pomoc¹ komendy /usun-blokady");
				    return 1;
			    }
				Blokadka[n]=CreateObject(1424,Pos[0]+1.0, Pos[1]+1.0, Pos[2]-0.5, 0.0, 0.0000, Pos[3]); Info(playerid,""C_ZOLTY"Blokada postawiona!");
			}
            case 6:
			{
			    if(Blokady>=14)
			    {
				    Info(playerid,""C_CZERWONY"Maskymalna iloœæ blokadek, usuñ je za pomoc¹ komendy /usun-blokady");
				    return 1;
			    }
		 		Blokadka[n]=CreateObject(1459,Pos[0]+1.0, Pos[1]+1.0, Pos[2]-0.5, 0.0, 0.0000, Pos[3]); Info(playerid,""C_ZOLTY"Blokada postawiona!");
			}
            case 7:
            {
				if(Blokady==0)
				{
                    Info(playerid,""C_CZERWONY"¯adna blokada nie jest postawiona!");
				    return 1;
				}
                Info(playerid,""C_ZOLTY"Blokady usuniête!");
			    Blokady=0;
				for(new c=0;c<15;c++)
				{
					DestroyObject(Blokadka[c]);
				}
				return 1;
            }
        }
	    return 1;
	}

	CMD:obrot(playerid, cmdtext[])
	{
	    if(GetPlayerState(playerid)!=PLAYER_STATE_DRIVER)
	    {
	        Info(playerid,""C_CZERWONY"Nie jesteœ kierowc¹ ¿adnego pojazdu!");
            return 1;
	    }
	    if(!dCzyMaKase(playerid,500))
	    {
	        Info(playerid,""C_CZERWONY"Nie staæ ciebie na us³ugê mechanika! (500$)");
			return 1;
		}
		dDodajKase(playerid,-500);
	    new Float:Pos[4],v=GetPlayerVehicleID(playerid);
	    GetVehiclePos(v,Pos[0],Pos[1],Pos[2]);
     	GetVehicleZAngle(v,Pos[3]);
		SetVehiclePos(v,Pos[0],Pos[1],Pos[2]);
		SetVehicleZAngle(v,Pos[3]);
		Info(playerid,""C_ZOLTY"Obróci³eœ pojazd na cztery ko³a za 500$!");
	    return 1;
	}

	CMD:paliwo(playerid, cmdtext[])
	{
	 	if(GetPlayerState(playerid)!=PLAYER_STATE_DRIVER)
		{
		    Info(playerid,""C_CZERWONY"Nie jesteœ kierowc¹ pojazdu!");
		    return 1;
		}
		new v=GetPlayerVehicleID(playerid),potrzebne=vPaliwoMax[v]-vPaliwo[v];
		if(potrzebne<20)
		{
			Info(playerid, ""C_CZERWONY"Twój pojazd ma jeszcze paliwo!");
			return 1;
		}
		if(GetPlayerSpeed(playerid)>1)
	    {
	    	Info(playerid,""C_CZERWONY"Musisz siê zatrzymaæ, aby u¿yæ tej komendy!");
            return 1;
	    }
		Info(playerid,""C_ZOLTY"Mechanik z paliwem wezwany! Poczekaj cierpliwie!");
		new Float:Pos[3];
		GetVehiclePos(v,Pos[0],Pos[1],Pos[2]);
		KillTimer(PaliwoTimer[playerid]);
		PaliwoTimer[playerid]=SetTimerEx("PaliwoPojazd",15000,false,"iifff",playerid,v,Pos[0],Pos[1],Pos[2]);
		return 1;
	}

	CMD:napraw(playerid, cmdtext[])
	{
	    if(GetPlayerState(playerid)!=PLAYER_STATE_DRIVER)
	    {
	        Info(playerid,""C_CZERWONY"Nie jesteœ kierowc¹ ¿adnego pojazdu!");
            return 1;
	    }
	    if(GetPlayerSpeed(playerid)>1)
	    {
	    	Info(playerid,""C_CZERWONY"Musisz siê zatrzymaæ, aby u¿yæ tej komendy!");
            return 1;
	    }
	    new Float:HP;
	    GetVehicleHealth(GetPlayerVehicleID(playerid),HP);
	    if(HP>=999.0)
	    {
	    	Info(playerid,""C_CZERWONY"Twój pojazd jest w perfekcyjnym stanie!");
            return 1;
	    }
		Info(playerid,""C_ZOLTY"Mechanik wezwany! Poczekaj cierpliwie!");
		new Float:Pos[3];
		GetVehiclePos(GetPlayerVehicleID(playerid),Pos[0],Pos[1],Pos[2]);
		KillTimer(NaprawTimer[playerid]);
		NaprawTimer[playerid]=SetTimerEx("NaprawPojazd",15000,false,"iifff",playerid,GetPlayerVehicleID(playerid),Pos[0],Pos[1],Pos[2]);
	    return 1;
	}

	forward PaliwoPojazd(playerid,vehicleid,Float:PosX,Float:PosY,Float:PosZ);
	public PaliwoPojazd(playerid,vehicleid,Float:PosX,Float:PosY,Float:PosZ)
	{
	    if(!IsPlayerInVehicle(playerid,vehicleid))
	    {
	        GInfo(playerid,"~r~przegapiles mechanika~n~nie jestes w odpowiednim pojezdzie!",3);
	        return 1;
	    }
	    if(GetPlayerSpeed(playerid)>1)
	    {
	    	GInfo(playerid,"~r~przegapiles mechanika~n~nie stales w miejscu!",3);
            return 1;
	    }
	    if(!DoInRange(7.0, playerid,PosX,PosY,PosZ))
		{
            GInfo(playerid,"~r~przegapiles mechanika~n~nie stales odpowiednim w miejscu!",3);
			return 1;
		}
	    new v=GetPlayerVehicleID(playerid),potrzebne=vPaliwoMax[v]-vPaliwo[v];
		if(potrzebne<20)
		{
			Info(playerid, ""C_CZERWONY"Twój pojazd ma jeszcze paliwo!");
			return 1;
		}
	    if(!dCzyMaKase(playerid,350))
	    {
			Info(playerid,""C_CZERWONY"Nie staæ ciebie na us³ugê mechanika!(350$)!");
			return 1;
		}
		dDodajKase(playerid,-350);
        vPaliwo[v]+=20;
		Info(playerid,""C_ZOLTY"Pojazd dotankowany!\nZap³aci³eœ:350$ za 20 litrów");
	    return 1;
	}

	forward NaprawPojazd(playerid,vehicleid,Float:PosX,Float:PosY,Float:PosZ);
	public NaprawPojazd(playerid,vehicleid,Float:PosX,Float:PosY,Float:PosZ)
	{
	    if(!IsPlayerInVehicle(playerid,vehicleid))
	    {
	        GInfo(playerid,"~r~przegapiles mechanika~n~nie jestes w odpowiednim pojezdzie!",3);
	        return 1;
	    }
	    if(GetPlayerSpeed(playerid)>1)
	    {
	    	GInfo(playerid,"~r~przegapiles mechanika~n~nie stales w miejscu!",3);
            return 1;
	    }
	    if(!DoInRange(7.0, playerid,PosX,PosY,PosZ))
		{
            GInfo(playerid,"~r~przegapiles mechanika~n~nie stales odpowiednim w miejscu!",3);
			return 1;
		}
	    new Float:HP,koszt;
	    GetVehicleHealth(vehicleid,HP);
		koszt=floatround((1000.0-HP)*3.1);
	    if(!dCzyMaKase(playerid,koszt))
	    {
	        format(dstring,sizeof(dstring),""C_CZERWONY"Nie staæ ciebie na us³ugê mechanika! (%d$)",koszt);
			Info(playerid,dstring);
			return 1;
		}
		dDodajKase(playerid,-koszt);
		RepairVehicle(vehicleid);
		SetVehicleHealth(vehicleid,1000.0);
		format(dstring,sizeof(dstring),""C_ZOLTY"Pojazd naprawiony!\nZap³aci³eœ: %d$",koszt);
		Info(playerid,dstring);
	    return 1;
	}

	CMD:lider(playerid, cmdtext[])
	{
		if(PlayerInfo[playerid][pLider]==0)
		{
		    Info(playerid,""C_CZERWONY"Nie jesteœ liderem!");
		    return 1;
		}
		new tmp[64],idx,f=PlayerInfo[playerid][pLider];
		tmp = strtok(cmdtext, idx);
		if(isnull(tmp))
		{
			Info(playerid,"U¿yj: /lider (nr)\n1 - zatrudnij\n2 - wyrzuæ");
			return 1;
 		}
	 	new id = strval(tmp);
		if(id==1)
		{
		    tmp = strtok(cmdtext, idx);
		    if(isnull(tmp))
			{
				Info(playerid,"U¿yj: /lider 1 (id)");
				return 1;
	 		}
		    new playa = strval(tmp);
		    if(IsPlayerConnected(playa)&&playerid!=playa)
		    {
		        if(Misja[playa])
		        {
		            Info(playerid,""C_CZERWONY"Ten gracz aktualnie wykonuje zlecenie!");
		            return 1;
		        }
		        PlayerInfo[playa][pFrakcja]=f;
		        ZapiszKonto(playa);
			    format(dstring, sizeof(dstring),""C_ZOLTY"%s zatrudni³ ciebie do frakcji: %d\nAby zmieniæ skin u¿yj /skin",Nick(playerid),f);
			    Info(playa,dstring);
			    format(dstring, sizeof(dstring),""C_ZOLTY"Zatrudni³eœ %s do twojej frakcji",Nick(playa));
			    Info(playerid,dstring);
		        return 1;
		    }
		    else
		    {
				Info(playerid,""C_CZERWONY"Nie poprawne id gracza!");
		    }
		    return 1;
		}
		else if(id==2)
		{
		    tmp = strtok(cmdtext, idx);
		    if(isnull(tmp))
			{
				Info(playerid,"U¿yj: /lider 2 (id)");
				return 1;
	 		}
		    new playa = strval(tmp);
		    if(IsPlayerConnected(playa)&&playerid!=playa)
		    {
		        if(PlayerInfo[playa][pFrakcja]!=PlayerInfo[playerid][pFrakcja])
		        {
		            Info(playerid,"Ten gracz nie pracuje w twojej frakcji!");
		            return 1;
		        }
		        PlayerInfo[playa][pFrakcja]=0;
		        ZapiszKonto(playa);
			    format(dstring, sizeof(dstring),""C_ZOLTY"%s zwolni³ ciebie.",Nick(playerid));
			    Info(playa,dstring);
			    format(dstring, sizeof(dstring),""C_ZOLTY"Zwolni³eœ %s z twojej frakcji.",Nick(playa));
			    Info(playerid,dstring);
		        return 1;
		    }
		    else
		    {
				Info(playerid,""C_CZERWONY"Nie poprawne id gracza!");
		    }
		    return 1;
		}
		else
		{
		    Info(playerid,""C_CZERWONY"Nie poprawny numer!");
		}
		return 1;
	}

	CMD:dajlider(playerid, cmdtext[])
	{
		if(!ToAdminLevel(playerid,3)) return 1;
		new tmp[64],idx;
		tmp = strtok(cmdtext, idx);
		if(isnull(tmp))
		{
			Info(playerid,"U¿yj: /dajlider (ID) (frakcja)\n1 - pd, 0 - zabierasz lidera");
			return 1;
 		}
	 	new playa = strval(tmp);
	 	tmp = strtok(cmdtext, idx);
	 	new level = strval(tmp);
	 	if(level<0||level>1){ Info(playerid,"Poziom od 0 do 1!"); return 1; }
		if(IsPlayerConnected(playa))
		{
		    PlayerInfo[playa][pLider]=level;
		    PlayerInfo[playa][pFrakcja]=level;
		    ZapiszKonto(playa);
		    format(dstring, sizeof(dstring),"%s da³ tobie lidera frakcji: %d",Nick(playerid),level);
		    Info(playa,dstring);
		    format(dstring, sizeof(dstring),"Da³eœ %s lidera frakcji: %d",Nick(playa),level);
		    Info(playerid,dstring);
		    return 1;
		}
		return 1;
	}

	CMD:dajpremium(playerid, cmdtext[])
	{
		if(!ToAdminLevel(playerid,3)) return 1;
		new tmp[64],idx;
		tmp = strtok(cmdtext, idx);
		if(isnull(tmp))
		{
			Info(playerid,"U¿yj: /dajpremium (ID) (pkt premium)");
			return 1;
 		}
	 	new playa = strval(tmp);
	 	tmp = strtok(cmdtext, idx);
	 	new pkt = strval(tmp);
	 	if(pkt<1||pkt>10){ Info(playerid,"Od 1 do 10!"); return 1; }
		if(IsPlayerConnected(playa))
		{
		    PlayerInfo[playa][pPremium]+=pkt;
		    ZapiszKonto(playa);
		    format(dstring, sizeof(dstring),"%s da³ tobie %d pkt premium, ³¹cznie masz: %d",Nick(playerid),pkt,PlayerInfo[playa][pPremium]);
		    Info(playa,dstring);
		    format(dstring, sizeof(dstring),"Da³eœ %s %d pkt premium, ³¹cznie posiada:",Nick(playa),pkt,PlayerInfo[playa][pPremium]);
		    Info(playa,dstring);
		    return 1;
		}
		return 1;
	}

	CMD:dajadmin(playerid, cmdtext[])
	{
		if(!ToAdminLevel(playerid,3)) return 1;
		new tmp[64],idx;
		tmp = strtok(cmdtext, idx);
		if(isnull(tmp))
		{
			Info(playerid,"U¿yj: /dajadmin (ID) (poziom)\n0 - zabierasz admina");
			return 1;
 		}
	 	new playa = strval(tmp);
	 	tmp = strtok(cmdtext, idx);
	 	new level = strval(tmp);
	 	if(level<0||level>3){ Info(playerid,"Poziom od 0 do 3!"); return 1; }
	 	if(playa==playerid){ Info(playerid,"Nie mo¿esz wrzuciæ sam siebie!"); return 1; }
		if(IsPlayerConnected(playa))
		{
		    PlayerInfo[playa][pAdmin]=level;
		    ZapiszKonto(playa);
		    format(dstring, sizeof(dstring),"%s ustawi³ tobie poziom admina na: %d",Nick(playerid),level);
		    Info(playa,dstring);
		    format(dstring, sizeof(dstring),"Ustawi³eœ %s poziom admina na: %d",Nick(playa),level);
		    Info(playerid,dstring);
		    return 1;
		}
		return 1;
	}
	
	CMD:sprawdzip(playerid, cmdtext[])
	{
	    if(!ToAdminLevel(playerid,2)) return 1;
		new tmp[64],idx;
		tmp = strtok(cmdtext, idx);
		if(isnull(tmp))
		{
			Info(playerid,"U¿yj: /sprawdzip (ID)");
			return 1;
 		}
	 	new playa = strval(tmp);
	 	if(playa==playerid){ Info(playerid,"Nie mo¿esz sprawdziæ sam siebie!"); return 1; }
		if(IsPlayerConnected(playa))
		{
		    if(PlayerInfo[playa][pAdmin]>PlayerInfo[playerid][pAdmin])
		    {
				Info(playerid,""C_CZERWONY"Nie mo¿esz sprawdziæ admina z wiêksz¹ rang¹ od twojej!");
				return 1;
		    }
	     	new plrIP[16];
    		GetPlayerIp(playa, plrIP, sizeof(plrIP));
            format(dstring, sizeof(dstring),"Gracz: [%d]%s, ip: %s",playa,Nick(playa),plrIP);
		    SendClientMessage(playerid,KOLOR_ROZOWY,dstring);
            return 1;
		}
		else
		{
			Info(playerid,"Nie poprawne id gracza!");
		}
		return 1;
	}

    CMD:spec(playerid, cmdtext[])
	{
	    if(!ToAdminLevel(playerid,2)) return 1;
		new tmp[64],idx;
		tmp = strtok(cmdtext, idx);
		if(isnull(tmp))
		{
			Info(playerid,"U¿yj: /spec (ID)");
			return 1;
 		}
	 	new playa = strval(tmp);
	 	if(playa==playerid){ Info(playerid,"Nie mo¿esz specowaæ sam siebie!"); return 1; }
		if(IsPlayerConnected(playa))
		{
		    if(PlayerInfo[playa][pAdmin]>PlayerInfo[playerid][pAdmin])
		    {
				Info(playerid,""C_CZERWONY"Nie mo¿esz specowaæ admina z wiêksz¹ rang¹ od twojej!");
				return 1;
		    }
		    Spec[playerid]=true;
		    TogglePlayerSpectating(playerid,true);
            SetTimerEx("SpecSystem",1000,false,"ii",playerid,playa);
            return 1;
		}
		else
		{
			Info(playerid,"Nie poprawne id gracza!");
		}
		return 1;
	}

	CMD:specoff(playerid, cmdtext[])
	{
	    if(!ToAdminLevel(playerid,2)) return 1;
        if(Spec[playerid]==true)
        {
            Spec[playerid]=false;
            TogglePlayerSpectating(playerid,false);
        }
        else
        {
   			Info(playerid,"Nie jesteœ na specu!");
        }
		return 1;
	}

	CMD:odczep(playerid, cmdtext[])
	{
	    new v=GetPlayerVehicleID(playerid);
		if(GetVehicleModel(v)==403||GetVehicleModel(v)==514||GetVehicleModel(v)==515)//ciê¿arowe
		{
		    if(!GetVehicleTrailer(v))
		    {
		        Info(playerid,""C_CZERWONY"Nie masz podczepionej naczepy!");
	        	return 1;
		    }
		    DetachTrailerFromVehicle(v);
		    Info(playerid,""C_ZOLTY"Odczepi³eœ naczepê");
		    return 1;
		}
		else
		{
		    Info(playerid,""C_CZERWONY"Nie jesteœ kierowc¹ ciê¿arówki!");
		}
	    return 1;
	}

	CMD:respawn(playerid, cmdtext[])
	{
		if(Misja[playerid]==true)
		{
		    Info(playerid,""C_CZERWONY"Podczas misji nie mo¿na u¿yæ tej komendy!");
		    return 1;
		}
		if(IsPlayerInAnyVehicle(playerid))
		{
		    Info(playerid,""C_CZERWONY"Nie mo¿esz byæ w pojeŸdzie!");
		    return 1;
		}
		if(!dCzyMaKase(playerid,500))
	    {
			Info(playerid,""C_CZERWONY"Nie masz tyle pieniêdzy! (500$)");
			return 1;
		}
		if(PlayerInfo[playerid][pScigany]>=1)
		{
			Info(playerid,""C_CZERWONY"Jesteœ poszukiwany, nie mo¿esz u¿yæ tej komendy");
			return 1;
		}
		if(PlayerInfo[playerid][pMandat]>=1)
		{
			Info(playerid,""C_CZERWONY"Masz zaleg³e mandaty, nie mo¿esz u¿yæ tej komendy zanim nie zap³acisz mandatu!");
			return 1;
		}
		dDodajKase(playerid,-500);
		GInfo(playerid,"~g~zespawnowany",1);
		CallLocalFunction("OnPlayerSpawn", "i",playerid);
		return 1;
	}

	CMD:przeladowany(playerid, cmdtext[])
	{
		if(Misja[playerid]==true)
		{
		    Info(playerid,""C_CZERWONY"Gdy przyje³eœ ju¿ zlecenie nie mo¿esz u¿yæ tej komendy!");
		    return 1;
		}
		if(Przeladowany[playerid]==true)
		{
		    Info(playerid,""C_ZIELONY"Od tego momentu towar,który za³adujesz nie bêdzie prze³adowany!");
		    Przeladowany[playerid]=false;
		}
		else
		{
		    Info(playerid,""C_CZERWONY"Od tego momentu towar,który za³adujesz bêdzie prze³adowany!");
		    Przeladowany[playerid]=true;
		}
		return 1;
	}

	CMD:anuluj(playerid, cmdtext[])
	{
		if(Misja[playerid]==true)
		{
		    ShowPlayerDialog(playerid,11,DIALOG_STYLE_MSGBOX,""C_POMARANCZOWY"Anulowanie misji",""C_ZOLTY"Anulowanie misji wi¹¿e siê z grzywn¹ wynosz¹c¹: "C_CZERWONY"1000$\n"C_ZOLTY"Czy na pewno chcesz anulowaæ misjê?","Tak","Nie");
		}
		else
		{
		    Info(playerid,""C_CZERWONY"Nie wykonujesz ¿adnej misji!");
		}
		return 1;
	}

	CMD:zlecenie(playerid, cmdtext[])
	{
	    if(GetPlayerState(playerid)!=PLAYER_STATE_DRIVER)
	    {
	        Info(playerid,""C_CZERWONY"Nie jesteœ kierowc¹ ¿adnego pojazdu!");
	        return 1;
	    }
	    if(ToPD(playerid))
	    {
	        Info(playerid,""C_CZERWONY"Bed¹c policjantem na s³u¿bie nie mo¿esz przyjmowaæ zleceñ\nZmieñ postaæ za pomoc¹ komendy /skin!");
	        return 1;
	    }
	    if(Misja[playerid]==true)
	    {
	        Info(playerid,""C_CZERWONY"Aktualnie wykonujesz ju¿ misjê!");
	        return 1;
	    }
	    new v=GetPlayerVehicleID(playerid),id;
		if(GetVehicleModel(v)==403||GetVehicleModel(v)==514||GetVehicleModel(v)==515)//ciê¿arowe
		{
		    if(GetVehicleTrailer(v)==0)
		    {
		        Info(playerid,""C_CZERWONY"Nie masz podczepionej naczepy!");
	        	return 1;
		    }
		    new naczepa=GetVehicleModel(GetVehicleTrailer(v));
		    if(naczepa==435||naczepa==450||naczepa==591||naczepa==584)
		    {
				id=LosujMisje(playerid);
				if(id!=999)
				{
				    PlayerInfo[playerid][pMisja]=1;
				    ZapiszKonto(playerid);
				    Misja[playerid]=true;
				    MisjaID[playerid]=id;
					MisjaStopien[playerid]=0;
					MisjaPojazd[playerid]=GetVehicleTrailer(v);
					OstatniaMisja[playerid]=id;
				    format(dstring, sizeof(dstring), "~g~%s ~w~z ~y~%s ~w~do ~y~%s",LadunekInfo[id][lTowar],LadunekInfo[id][lZaladunek],LadunekInfo[id][lDostarczenie]);
				    LadunekNapis(playerid,dstring);
				    Info(playerid,""C_ZIELONY"Zlecenie przyjetê!\nJedŸ na miejsce za³adunku!\n"C_CZERWONY"Towar musisz za³adowaæ do tej naczepy, nie zgub jej!");
				    SetPlayerCheckpoint(playerid,LadunekInfo[id][lPosX],LadunekInfo[id][lPosY],LadunekInfo[id][lPosZ],5);
					return 1;
				}
				else
				{
				    Info(playerid,""C_CZERWONY"Losowanie misji nie powiod³o siê, wpisz ponownie komendê!");
				}
				return 1;
		    }
		    else
		    {
		        Info(playerid,""C_CZERWONY"Masz nie odpowiedni¹ naczepê!");
		    }
		    return 1;
		}
		else if(ToBus(v))
		{
		    id=LosujMisje(playerid);
			if(id!=999)
			{
			    PlayerInfo[playerid][pMisja]=1;
			    ZapiszKonto(playerid);
   				Misja[playerid]=true;
			    MisjaID[playerid]=id;
				MisjaStopien[playerid]=0;
				MisjaPojazd[playerid]=v;
				OstatniaMisja[playerid]=id;
    			format(dstring, sizeof(dstring), "~g~%s ~w~z ~y~%s ~w~do ~y~%s",LadunekInfo[id][lTowar],LadunekInfo[id][lZaladunek],LadunekInfo[id][lDostarczenie]);
    			LadunekNapis(playerid,dstring);
			    Info(playerid,""C_ZIELONY"Zlecenie przyjetê!\nJedŸ na miejsce za³adunku!\n"C_CZERWONY"Towar musisz za³adowaæ do tego pojazdu, nie zmieniaj go!");
			    SetPlayerCheckpoint(playerid,LadunekInfo[id][lPosX],LadunekInfo[id][lPosY],LadunekInfo[id][lPosZ],5);
				return 1;
			}
			else
			{
   				Info(playerid,""C_CZERWONY"Losowanie misji nie powiod³o siê, wpisz ponownie komendê!");
			}
			return 1;
		}
		else
		{
			Info(playerid,""C_CZERWONY"Ten pojazd nie mo¿e przewoziæ towarów!");
		}
		return 1;
	}

	CMD:text(playerid, cmdtext[])
	{
		if(!ToAdminLevel(playerid,3)) return 1;
		new tmp[64],idx,text[80];
		tmp = strtok(cmdtext, idx);
		if(isnull(tmp))
		{
			Info(playerid,"U¿yj: /text (nr)\n1 - tworzenie nowego textu\n2 - edycja textu\n3 - lista istniejacych textow\n4 - usun text");
	 		return 1;
	 	}
	 	new numer = strval(tmp);
		if(numer==1)
		{
		    if(TextTworzenie==false&&TextPkt[playerid]==0)
			{
				Info(playerid,"Ten panel aktualnie jest u¿ywany przez kogoœ innego!\nMusisz poczekaæ!");
				return 1;
			}
			tmp = strtok(cmdtext, idx);
			if(isnull(tmp))
			{
				Info(playerid,"U¿yj: /text 1 (nr)\n1 - treœæ textu\n2 - pozycja textu\n3 - zapisz i dodaj\n99 - anuluj");
		 		return 1;
		 	}
		 	new punkt = strval(tmp);
		 	switch(punkt)
		 	{
		 	    case 1:
		 	    {
		 	        if(TextPkt[playerid]!=0)
			 		{
				 		Info(playerid,"Ta opcja zosta³a ju¿ wykonana lub nie robisz punktów w odpowiedniej kolejnoœci!");
				 		return 1;
		 			}
		 	        text=strrest(cmdtext,idx);
					if(isnull(text))
					{
						Info(playerid,"U¿yj: /text 1 1 (treœæ textu)");
						return 1;
					}
					if(strlen(text)<3||strlen(text)>64)
					{
                        Info(playerid,"Nie poprawna d³ugoœæ nazwy!\nOd 3 do 64 liter!");
						return 1;
					}
					for(new nr = 0; nr < LIMIT_TEXTOW; nr++)
					{
						if(TextInfo[nr][tAktywny]==0)
				 		{
				 			TextID[playerid]=nr;
							TextTworzenie=false;
							TextPkt[playerid]=1;
							strmid(TextInfo[nr][tNapis], text, 0, strlen(text), 64);
							Info(playerid,"Treœæ textu3d ustalona!");
							return 1;
						}
					}
					return 1;
		 	    }//koniec przypadku
		 	    case 2:
		 	    {
		 	        if(TextPkt[playerid]!=1)
			 		{
				 		Info(playerid,"Ta opcja zosta³a ju¿ wykonana lub nie robisz punktów w odpowiedniej kolejnoœci!");
				 		return 1;
		 			}
	                new nr=TextID[playerid];
				 	TextPkt[playerid]=2;
				 	GetPlayerPos(playerid,TextInfo[nr][tPosX],TextInfo[nr][tPosY],TextInfo[nr][tPosZ]);
				 	Info(playerid,"Pozycja textu pobrana!");
					return 1;
		 	    }//koniec przypadku
		 	    case 3:
		 	    {
		 	        if(TextPkt[playerid]!=2)
			 		{
				 		Info(playerid,"Nie wykona³eœ jeszcze wszystkich punktów!");
				 		return 1;
		 			}
		 			new nr=TextID[playerid];
		 			TextInfo[nr][tAktywny]=1;
		 			TextNapis[nr]=CreateDynamic3DTextLabel(ColouredText(TextInfo[nr][tNapis]),KOLOR_BIALY,TextInfo[nr][tPosX],TextInfo[nr][tPosY],TextInfo[nr][tPosZ],40.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,-1,-1,-1,-1,40.0);
		 			ZapiszText(nr);
		 			TextID[playerid]=9999;
					TextPkt[playerid]=0;
					TextTworzenie=true;
		 			format(dstring, sizeof(dstring),"Poprawnie doda³eœ text3d o ID: %d",nr);
		 			Info(playerid,dstring);
		 	        return 1;
		 	    }//koniec przypadku
		 	    case 99:
		 	    {
		 	        if(TextPkt[playerid]==0)
			 		{
				 		Info(playerid,"Nie mo¿esz anulowaæ pracy, poniewa¿ jej nie zacze³eœ!");
				 		return 1;
		 			}
		 			TextID[playerid]=9999;
					TextPkt[playerid]=0;
					TextTworzenie=true;
					Info(playerid,"Praca anulowana!");
		 	        return 1;
		 	    }//koniec przypadku
			}//switch
		}//punkt
		else if(numer==2)
		{
			tmp = strtok(cmdtext, idx);
			if(isnull(tmp))
			{
				Info(playerid,"U¿yj: /text 2 (ID) (nr)\n1 - treœæ textu\n2 - pozycja textu");
		 		return 1;
		 	}
		 	new nr = strval(tmp);
		 	tmp = strtok(cmdtext, idx);
		 	new punkt = strval(tmp);
		 	if(TextInfo[nr][tAktywny]==0)
	 		{
	 		    Info(playerid,"Nie poprawne id textu3d!");
	 		    return 1;
			}
		 	switch(punkt)
		 	{
		 	    case 1:
		 	    {
		 	        text=strrest(cmdtext,idx);
					if(isnull(text))
					{
						Info(playerid,"U¿yj: /text 2 (id) 1 (treœæ textu)");
						return 1;
					}
					if(strlen(text)<3||strlen(text)>64)
					{
                        Info(playerid,"Nie poprawna d³ugoœæ nazwy!\nOd 3 do 64 liter!");
						return 1;
					}
					strmid(TextInfo[nr][tNapis], text, 0, strlen(text), 64);
					DestroyDynamic3DTextLabel(TextNapis[nr]);
					TextNapis[nr]=CreateDynamic3DTextLabel(ColouredText(TextInfo[nr][tNapis]),KOLOR_BIALY,TextInfo[nr][tPosX],TextInfo[nr][tPosY],TextInfo[nr][tPosZ],30.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,-1,-1,-1,-1,30.0);
					Info(playerid,"Treœæ textu3d zmieniona!");
					ZapiszText(nr);
					return 1;
		 	    }//koniec przypadku
		 	    case 2:
		 	    {
				 	GetPlayerPos(playerid,TextInfo[nr][tPosX],TextInfo[nr][tPosY],TextInfo[nr][tPosZ]);
				 	Info(playerid,"Pozycja textu zmieniona!");
				 	DestroyDynamic3DTextLabel(TextNapis[nr]);
					TextNapis[nr]=CreateDynamic3DTextLabel(TextInfo[nr][tNapis],KOLOR_BIALY,TextInfo[nr][tPosX],TextInfo[nr][tPosY],TextInfo[nr][tPosZ],30.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,-1,-1,-1,-1,30.0);
					ZapiszText(nr);
					return 1;
		 	    }//koniec przypadku
			}//switch
			return 1;
		}//punkt
		else if(numer==3)
		{
		    SendClientMessage(playerid,KOLOR_ZOLTY,"Istniej¹ce texty 3d:");
		    for(new nr = 0; nr < LIMIT_TEXTOW; nr++)
			{
				if(TextInfo[nr][tAktywny]==1)
				{
				    format(dstring, sizeof(dstring),"Text 3d ID: %d Treœæ: %s",nr,TextInfo[nr][tNapis]);
		    		SendClientMessage(playerid,KOLOR_BIALY,dstring);
				}
			}
		    return 1;
		}
	 	else if(numer==4)
		{
			tmp = strtok(cmdtext, idx);
			if(isnull(tmp))
			{
				Info(playerid,"U¿yj: /text 4 (ID)");
		 		return 1;
		 	}
		 	new nr = strval(tmp);
		 	if(TextInfo[nr][tAktywny]==0)
	 		{
	 		    Info(playerid,"Nie poprawne id textu3d!");
	 		    return 1;
			}
            DestroyDynamic3DTextLabel(TextNapis[nr]);
            TextInfo[nr][tAktywny]=0;
            ZapiszText(nr);
            Info(playerid,"Text usuniêty!");
			return 1;
		}
		return 1;
	}//komenda


	CMD:ladunek(playerid, cmdtext[])
	{
		if(!ToAdminLevel(playerid,3)) return 1;
		new tmp[64],idx,text[80];
		tmp = strtok(cmdtext, idx);
		if(isnull(tmp))
		{
			Info(playerid,"U¿yj: /ladunek (nr)\n1 - tworzenie nowego ³adunku\n2 - edycja ³adunku\n3 - lista istniej¹cych ³adunków\n4 - usuñ ³adunek");
	 		return 1;
	 	}
	 	new numer = strval(tmp);
		if(numer==1)
		{
		    if(LadunekTworzenie==false&&LadunekPkt[playerid]==0)
			{
				Info(playerid,"Ten panel aktualnie jest u¿ywany przez kogoœ innego!\nMusisz poczekaæ!");
				return 1;
			}
			tmp = strtok(cmdtext, idx);
			if(isnull(tmp))
			{
				Info(playerid,"U¿yj: /³adunek 1 (nr)\n1 - nazwa towaru\n2 - cena za 1 kg. towaru\n3 - Miejsce za³adunku\n4 - pozycja za³adunku\n5 - miejsce roz³adunku\n6 - pozycja roz³adunku\n7 - zapisz i dodaj ³adunek\n99 - anuluj");
		 		return 1;
		 	}
		 	new punkt = strval(tmp);
		 	switch(punkt)
		 	{
		 	    case 1:
		 	    {
		 	        if(LadunekPkt[playerid]!=0)
			 		{
				 		Info(playerid,"Ta opcja zosta³a ju¿ wykonana lub nie robisz punktów w odpowiedniej kolejnoœci!");
				 		return 1;
		 			}
		 	        text=strrest(cmdtext,idx);
					if(isnull(text))
					{
						Info(playerid,"U¿yj: /ladunek 1 1 (nazwa towaru)");
						return 1;
					}
					if(strlen(text)<3||strlen(text)>30)
					{
                        Info(playerid,"Nie poprawna d³ugoœæ nazwy!\nOd 3 do 30 liter!");
						return 1;
					}
					for(new nr = 0; nr < LIMIT_LADUNKOW; nr++)
					{
						if(LadunekInfo[nr][lAktywny]==0)
				 		{
				 			LadunekID[playerid]=nr;
							LadunekTworzenie=false;
							LadunekPkt[playerid]=1;
							strmid(LadunekInfo[nr][lTowar], text, 0, strlen(text), 64);
							Info(playerid,"Nazwa towaru ustalona! PrzejdŸ do kolejnego punktu!");
							return 1;
						}
					}
					return 1;
		 	    }//koniec przypadku
		 	    case 2:
		 	    {
		 	        if(LadunekPkt[playerid]!=1)
			 		{
				 		Info(playerid,"Ta opcja zosta³a ju¿ wykonana lub nie robisz punktów w odpowiedniej kolejnoœci!");
				 		return 1;
		 			}
		 			tmp = strtok(cmdtext, idx);
					if(isnull(tmp))
					{
						Info(playerid,"U¿yj: /ladunek 1 2 (kwota za 1 kg)");
				 		return 1;
				 	}
				 	new Float:kwota=floatstr(tmp);
				 	if(kwota<0.5||kwota>5.0)
				 	{
				 	    Info(playerid,"Od 0.5$ do 5.0$");
				 	    return 1;
				 	}
				 	new nr=LadunekID[playerid];
				 	LadunekPkt[playerid]=2;
				 	LadunekInfo[nr][lTowarKoszt]=kwota;
				 	Info(playerid,"Kwota za kg towaru ustalona!");
				 	return 1;
				}//koniec przypadku
				case 3:
		 	    {
		 	        if(LadunekPkt[playerid]!=2)
			 		{
				 		Info(playerid,"Ta opcja zosta³a ju¿ wykonana lub nie robisz punktów w odpowiedniej kolejnoœci!");
				 		return 1;
		 			}
		 			text=strrest(cmdtext,idx);
					if(isnull(text))
					{
						Info(playerid,"U¿yj: /ladunek 1 3 (nazwa miejsca za³adunku)");
				 		return 1;
				 	}
				 	if(strlen(text)<3||strlen(text)>30)
					{
                        Info(playerid,"Nie poprawna d³ugoœæ nazwy!\nOd 3 do 30 liter!");
						return 1;
					}
				 	new nr=LadunekID[playerid];
				 	LadunekPkt[playerid]=3;
				 	strmid(LadunekInfo[nr][lZaladunek], text, 0, strlen(text), 64);
				 	Info(playerid,"Nazwa miejsca za³adunku ustalona!");
				 	return 1;
				}//koniec przypadku
				case 4:
		 	    {
		 	        if(LadunekPkt[playerid]!=3)
			 		{
				 		Info(playerid,"Ta opcja zosta³a ju¿ wykonana lub nie robisz punktów w odpowiedniej kolejnoœci!");
				 		return 1;
		 			}
		 			if(GetPlayerInterior(playerid)!=0)
		 			{
		 			    Info(playerid,"Nie mo¿e byæ to w interiorze!");
		 			    return 1;
		 			}
				 	new nr=LadunekID[playerid];
				 	LadunekPkt[playerid]=4;
				 	GetPlayerPos(playerid,LadunekInfo[nr][lPosX],LadunekInfo[nr][lPosY],LadunekInfo[nr][lPosZ]);
				 	Info(playerid,"Pozycja miejsca za³adunku pobrana!");
				 	return 1;
				}//koniec przypadku
				case 5:
		 	    {
		 	        if(LadunekPkt[playerid]!=4)
			 		{
				 		Info(playerid,"Ta opcja zosta³a ju¿ wykonana lub nie robisz punktów w odpowiedniej kolejnoœci!");
				 		return 1;
		 			}
		 			text=strrest(cmdtext,idx);
					if(isnull(text))
					{
						Info(playerid,"U¿yj: /ladunek 1 5 (nazwa miejsca roz³adunku)");
				 		return 1;
				 	}
				 	if(strlen(text)<3||strlen(text)>30)
					{
                        Info(playerid,"Nie poprawna d³ugoœæ nazwy!\nOd 3 do 30 liter!");
						return 1;
					}
				 	new nr=LadunekID[playerid];
				 	LadunekPkt[playerid]=5;
				 	strmid(LadunekInfo[nr][lDostarczenie], text, 0, strlen(text), 64);
				 	Info(playerid,"Nazwa miejsca roz³adunku ustalona!");
				 	return 1;
				}//koniec przypadku
				case 6:
		 	    {
		 	        if(LadunekPkt[playerid]!=5)
			 		{
				 		Info(playerid,"Ta opcja zosta³a ju¿ wykonana lub nie robisz punktów w odpowiedniej kolejnoœci!");
				 		return 1;
		 			}
		 			if(GetPlayerInterior(playerid)!=0)
		 			{
		 			    Info(playerid,"Nie mo¿e byæ to w interiorze!");
		 			    return 1;
		 			}
				 	new nr=LadunekID[playerid];
				 	LadunekPkt[playerid]=6;
				 	GetPlayerPos(playerid,LadunekInfo[nr][lPos2X],LadunekInfo[nr][lPos2Y],LadunekInfo[nr][lPos2Z]);
				 	Info(playerid,"Pozycja miejsca roz³adunku pobrana!");
				 	return 1;
				}//koniec przypadku
				case 7:
		 	    {
		 	        if(LadunekPkt[playerid]!=6)
			 		{
				 		Info(playerid,"Nie wykona³eœ jeszcze wszystkich punktów!");
				 		return 1;
		 			}
		 			new nr=LadunekID[playerid];
		 			LadunekInfo[nr][lAktywny]=1;
		 			ZapiszLadunek(nr);
		 			LadunekID[playerid]=9999;
					LadunekPkt[playerid]=0;
					LadunekTworzenie=true;
		 			format(dstring, sizeof(dstring),"Poprawnie doda³eœ ofertê transportow¹ o ID: %d",nr);
		 			Info(playerid,dstring);
		 	        return 1;
		 	    }//koniec przypadku
		 	    case 99:
		 	    {
		 	        if(LadunekPkt[playerid]==0)
			 		{
				 		Info(playerid,"Nie mo¿esz anulowaæ pracy, poniewa¿ jej nie zacze³eœ!");
				 		return 1;
		 			}
		 			LadunekID[playerid]=9999;
					LadunekPkt[playerid]=0;
					LadunekTworzenie=true;
					Info(playerid,"Praca anulowana!");
		 	        return 1;
		 	    }//koniec przypadku
			}
			return 1;
		}
		else if(numer==2)
		{
			tmp = strtok(cmdtext, idx);
			if(isnull(tmp))
			{
				Info(playerid,"U¿yj: /³adunek 2 (id ³adunku) (nr)\n1 - nazwa towaru\n2 - cena za 1 kg. towaru\n3 - Miejsce za³adunku\n4 - pozycja za³adunku\n5 - miejsce roz³adunku\n6 - pozycja roz³adunku");
		 		return 1;
		 	}
		 	new nr = strval(tmp);
		 	tmp = strtok(cmdtext, idx);
		 	new punkt = strval(tmp);
		 	if(LadunekInfo[nr][lAktywny]==0)
 			{
 			    Info(playerid,"Nie poprawne id ³adunku!");
 			    return 1;
 			}
		 	switch(punkt)
		 	{
		 	    case 1:
				{
		 	        text=strrest(cmdtext,idx);
					if(isnull(text))
					{
						Info(playerid,"U¿yj: /ladunek 2 (id) 1 (nazwa towaru)");
						return 1;
					}
					if(strlen(text)<3||strlen(text)>30)
					{
                        Info(playerid,"Nie poprawna d³ugoœæ nazwy!\nOd 3 do 30 liter!");
						return 1;
					}
					strmid(LadunekInfo[nr][lTowar], text, 0, strlen(text), 64);
					Info(playerid,"Nazwa towaru zmieniona!");
					ZapiszLadunek(nr);
					return 1;
		 	    }//koniec przypadku
		 	    case 2:
		 	    {
		 			tmp = strtok(cmdtext, idx);
					if(isnull(tmp))
					{
						Info(playerid,"U¿yj: /ladunek 2 (id) 2 (kwota za 1 kg)");
				 		return 1;
				 	}
				 	new Float:kwota=floatstr(tmp);
				 	if(kwota<0.5||kwota>5.0)
				 	{
				 	    Info(playerid,"Od 0.5$ do 5.0$");
				 	    return 1;
				 	}
				 	LadunekInfo[nr][lTowarKoszt]=kwota;
				 	Info(playerid,"Kwota za kg towaru zmieniona!");
				 	ZapiszLadunek(nr);
				 	return 1;
				}//koniec przypadku
				case 3:
		 	    {
		 			text=strrest(cmdtext,idx);
					if(isnull(text))
					{
						Info(playerid,"U¿yj: /ladunek 2 (id) 3 (nazwa miejsca za³adunku)");
				 		return 1;
				 	}
				 	if(strlen(text)<3||strlen(text)>30)
					{
                        Info(playerid,"Nie poprawna d³ugoœæ nazwy!\nOd 3 do 30 liter!");
						return 1;
					}
				 	strmid(LadunekInfo[nr][lZaladunek], text, 0, strlen(text), 64);
				 	Info(playerid,"Nazwa miejsca za³adunku zmieniona!");
				 	ZapiszLadunek(nr);
				 	return 1;
				}//koniec przypadku
				case 4:
		 	    {
		 			if(GetPlayerInterior(playerid)!=0)
		 			{
		 			    Info(playerid,"Nie mo¿e byæ to w interiorze!");
		 			    return 1;
		 			}
				 	GetPlayerPos(playerid,LadunekInfo[nr][lPosX],LadunekInfo[nr][lPosY],LadunekInfo[nr][lPosZ]);
				 	Info(playerid,"Pozycja miejsca za³adunku zmieniona!");
				 	ZapiszLadunek(nr);
				 	return 1;
				}//koniec przypadku
				case 5:
		 	    {
		 			text=strrest(cmdtext,idx);
					if(isnull(text))
					{
						Info(playerid,"U¿yj: /ladunek 2 (id) 5 (nazwa miejsca roz³adunku)");
				 		return 1;
				 	}
				 	if(strlen(text)<3||strlen(text)>30)
					{
                        Info(playerid,"Nie poprawna d³ugoœæ nazwy!\nOd 3 do 30 liter!");
						return 1;
					}
				 	strmid(LadunekInfo[nr][lDostarczenie], text, 0, strlen(text), 64);
				 	Info(playerid,"Nazwa miejsca roz³adunku zmieniona!");
				 	ZapiszLadunek(nr);
				 	return 1;
				}//koniec przypadku
				case 6:
		 	    {
		 			if(GetPlayerInterior(playerid)!=0)
		 			{
		 			    Info(playerid,"Nie mo¿e byæ to w interiorze!");
		 			    return 1;
		 			}
				 	GetPlayerPos(playerid,LadunekInfo[nr][lPos2X],LadunekInfo[nr][lPos2Y],LadunekInfo[nr][lPos2Z]);
				 	Info(playerid,"Pozycja miejsca roz³adunku zmieniona!");
				 	ZapiszLadunek(nr);
				 	return 1;
				}//koniec przypadku
			}
			return 1;
		}
		else if(numer==3)
		{
		    SendClientMessage(playerid,KOLOR_ZOLTY,"Istniej¹ce oferty transportowe:");
		    for(new nr = 0; nr < LIMIT_LADUNKOW; nr++)
			{
				if(LadunekInfo[nr][lAktywny]==1)
	 			{
		    		format(dstring, sizeof(dstring),"£adunek [%d]: %s z %s do %s za %f/kg",nr,LadunekInfo[nr][lTowar],LadunekInfo[nr][lZaladunek],LadunekInfo[nr][lDostarczenie],LadunekInfo[nr][lTowarKoszt]);
		    		SendClientMessage(playerid,KOLOR_BIALY,dstring);
				}
			}
			return 1;
		}
		else if(numer==4)
		{
			tmp = strtok(cmdtext, idx);
			if(isnull(tmp))
			{
				Info(playerid,"U¿yj: /ladunek 4 (id)");
	 			return 1;
		 	}
		 	new nr=strval(tmp);
		 	if(LadunekInfo[nr][lAktywny]==0)
 			{
 			    Info(playerid,"Taka oferta transportowa nie istnieje!");
 			    return 1;
 			}
 			LadunekInfo[nr][lAktywny]=0;
 			ZapiszLadunek(nr);
 			Info(playerid,"Oferta transportowa usuniêta");
			return 1;
		}
		return 1;
	}

	CMD:wycisz(playerid, cmdtext[])
	{
	    if(!ToAdminLevel(playerid,1)) return 1;
		new tmp[64],idx;
		tmp = strtok(cmdtext, idx);
		if(isnull(tmp))
		{
			Info(playerid,"U¿yj: /wycisz (ID) (czas) (powód)");
			return 1;
 		}
	 	new playa = strval(tmp);
	 	tmp = strtok(cmdtext, idx);
	 	new czas = strval(tmp);
	 	if(playa==playerid){ Info(playerid,"Nie mo¿esz wsadziæ sam siebie!"); return 1; }
	 	if(czas<2||czas>=20){ Info(playerid,"Od 2 do 20 minut!"); return 1; }
		if(IsPlayerConnected(playa)&&Zalogowany[playa]==true)
		{
		    if(PlayerInfo[playa][pAdmin]>PlayerInfo[playerid][pAdmin])
		    {
				Info(playerid,""C_CZERWONY"Nie mo¿esz ukaraæ admina z wiêksz¹ rang¹ od twojej!");
				return 1;
		    }
			new text[80];
			text=strrest(cmdtext,idx);
			if(isnull(text))
			{
				Info(playerid,"U¿yj: /wycisz (ID) (czas) (powód)");
				return 1;
			}
			KillTimer(MuteTimer[playa]);
			MuteTimer[playa]=SetTimerEx("Odcisz",60000*czas,false,"i",playa);
			PlayerInfo[playa][pWyciszony]=czas;
			ZapiszKonto(playa);
		    format(dstring, sizeof(dstring),"Zosta³eœ wyciszony przez %s(%d) na %d minut\nPowód: %s",Nick(playerid),playerid,PlayerInfo[playa][pJail],text);
		    Info(playa,dstring);
		    GInfo(playa,"~r~wyciszony",1);
		    format(dstring, sizeof(dstring),"~r~(%d)%s zostal wyciszony na %d min~n~~y~przez: (%d)%s~n~~w~Za: %s",playa,Nick(playa),czas,playerid,Nick(playerid),text);
		    NapisText(dstring);
		}
		else
		{
			Info(playerid,"Nie poprawne id gracza!");
		}
		return 1;
	}

	forward Odcisz(playerid);
	public Odcisz(playerid)
	{
	    if(PlayerInfo[playerid][pWyciszony]>=1)
	    {
		    PlayerInfo[playerid][pWyciszony]=0;
			GInfo(playerid,"~w~odciszony",1);
		}
	    return 1;
	}

	CMD:aj(playerid, cmdtext[])
	{
	    if(!ToAdminLevel(playerid,1)) return 1;
		new tmp[64],idx;
		tmp = strtok(cmdtext, idx);
		if(isnull(tmp))
		{
			Info(playerid,"U¿yj: /aj (ID) (czas) (powód)");
			return 1;
 		}
	 	new playa = strval(tmp);
	 	tmp = strtok(cmdtext, idx);
	 	new czas = strval(tmp);
	 	if(playa==playerid){ Info(playerid,"Nie mo¿esz wsadziæ sam siebie!"); return 1; }
	 	if(czas<3||czas>=180){ Info(playerid,"Od 3 do 180 minut!"); return 1; }
		if(IsPlayerConnected(playa)&&Zalogowany[playa]==true)
		{
		    if(PlayerInfo[playa][pAdmin]>PlayerInfo[playerid][pAdmin])
		    {
				Info(playerid,""C_CZERWONY"Nie mo¿esz ukaraæ admina z wiêksz¹ rang¹ od twojej!");
				return 1;
		    }
			new text[80];
			text=strrest(cmdtext,idx);
			if(isnull(text))
			{
				Info(playerid,"U¿yj: /aj (ID) (czas) (powód)");
				return 1;
			}
			SetPlayerPos(playa,264.9535,77.5068,1001.0391);
		    SetPlayerInterior(playa,6);
		    SetPlayerVirtualWorld(playa,playa);
		    SetPlayerWorldBounds(playa,268.5071,261.3936,81.6285,71.8745);
		    dUstawHP(playa,100);
			PlayerInfo[playa][pJail]=czas;
			ZapiszKonto(playa);
		    format(dstring, sizeof(dstring),"Zosta³eœ uwiêziony w admin jailu przez %s(%d) na %d minut\nPowód: %s",Nick(playerid),playerid,PlayerInfo[playa][pJail],text);
		    Info(playa,dstring);
		    GInfo(playa,"~r~admin jail",1);
		    format(dstring, sizeof(dstring),"~r~(%d)%s zostal uwieziony na %d min~n~~y~przez: (%d)%s~n~~w~Za: %s",playa,Nick(playa),czas,playerid,Nick(playerid),text);
		    NapisText(dstring);
		}
		else
		{
			Info(playerid,"Nie poprawne id gracza!");
		}
		return 1;
	}

	CMD:ban(playerid, cmdtext[])
	{
	    if(!ToAdminLevel(playerid,1)) return 1;
		new tmp[64],idx;
		tmp = strtok(cmdtext, idx);
		if(isnull(tmp))
		{
			Info(playerid,"U¿yj: /ban (ID) (powód)");
			return 1;
 		}
	 	new playa = strval(tmp);
	 	if(playa==playerid){ Info(playerid,"Nie mo¿esz zbanowaæ sam siebie!"); return 1; }
		if(IsPlayerConnected(playa))
		{
		    if(PlayerInfo[playa][pAdmin]>PlayerInfo[playerid][pAdmin])
		    {
				Info(playerid,""C_CZERWONY"Nie mo¿esz zbanowaæ admina z wiêksz¹ rang¹ od twojej!");
				return 1;
		    }
			new text[80];
			text=strrest(cmdtext,idx);
			if(isnull(text))
			{
				Info(playerid,"U¿yj: /ban (ID) (powód)");
				return 1;
			}
		    format(dstring, sizeof(dstring),"Zosta³eœ zbanowany przez %s(%d) za: %s",Nick(playerid),playerid,text);
		    Info(playa,dstring);
		    format(dstring, sizeof(dstring),"~r~(%d)%s zostal zbanowany~n~~y~przez: (%d)%s~n~~w~Za: %s",playa,Nick(playa),playerid,Nick(playerid),text);
	    	NapisText(dstring);
		    dBanEx(playa,text);
		}
		else
		{
			Info(playerid,"Nie poprawne id gracza!");
		}
		return 1;
	}

	CMD:blok(playerid, cmdtext[])
	{
	    if(!ToAdminLevel(playerid,1)) return 1;
		new tmp[64],idx;
		tmp = strtok(cmdtext, idx);
		if(isnull(tmp))
		{
			Info(playerid,"U¿yj: /blok (ID) (powód)");
			return 1;
 		}
	 	new playa = strval(tmp);
	 	if(playa==playerid){ Info(playerid,"Nie mo¿esz zablokowaæ sam siebie!"); return 1; }
		if(IsPlayerConnected(playa)&&Zalogowany[playa]==true)
		{
		    if(PlayerInfo[playa][pAdmin]>PlayerInfo[playerid][pAdmin])
		    {
				Info(playerid,""C_CZERWONY"Nie mo¿esz zablokowaæ admina z wiêksz¹ rang¹ od twojej!");
				return 1;
		    }
			new text[80];
			text=strrest(cmdtext,idx);
			if(isnull(text))
			{
				Info(playerid,"U¿yj: /blok (ID) (powód)");
				return 1;
			}
		    format(dstring, sizeof(dstring),"Zosta³eœ zablokowany przez %s(%d) za: %s",Nick(playerid),playerid,text);
		    Info(playa,dstring);
		    format(dstring, sizeof(dstring),"~r~Konto (%d)%s zostalo zablokowane~n~~y~przez: (%d)%s~n~~w~Za: %s",playa,Nick(playa),playerid,Nick(playerid),text);
	    	NapisText(dstring);
		    PlayerInfo[playa][pKonto]=2;
		    dKick(playa);
		}
		else
		{
			Info(playerid,"Nie poprawne id gracza!");
		}
		return 1;
	}

	CMD:warn(playerid, cmdtext[])
	{
	    if(!ToAdminLevel(playerid,1)) return 1;
		new tmp[64],idx;
		tmp = strtok(cmdtext, idx);
		if(isnull(tmp))
		{
			Info(playerid,"U¿yj: /warn (ID) (powód)");
			return 1;
 		}
	 	new playa = strval(tmp);
	 	if(playa==playerid){ Info(playerid,"Nie mo¿esz zwarnowaæ sam siebie!"); return 1; }
		if(IsPlayerConnected(playa)&&Zalogowany[playa]==true)
		{
		    if(PlayerInfo[playa][pAdmin]>PlayerInfo[playerid][pAdmin])
		    {
				Info(playerid,""C_CZERWONY"Nie mo¿esz zwarnowaæ admina z wiêksz¹ rang¹ od twojej!");
				return 1;
		    }
			new text[80];
			text=strrest(cmdtext,idx);
			if(isnull(text))
			{
				Info(playerid,"U¿yj: /warn (ID) (powód)");
				return 1;
			}
			PlayerInfo[playa][pWarny]++;
			if(PlayerInfo[playa][pWarny]>=4)
			{
			    format(dstring, sizeof(dstring),"Otrzyma³eœ warna(4/4) i jednoczeœnie bana od %s(%d)\nPowód: %s",Nick(playerid),playerid,text);
			    Info(playa,dstring);
			    format(dstring, sizeof(dstring),"~r~(%d)%s zostal zbanowany (4/4 warny)~n~~y~przez: (%d)%s~n~~w~Za: %s",playa,Nick(playa),playerid,Nick(playerid),text);
		    	NapisText(dstring);
			    dBanEx(playa,"Otrzymanie 4 warnów");
		    }
			else
			{
			    format(dstring, sizeof(dstring),"Otrzyma³eœ warna(%d/4) od %s(%d)\nPowód: %s",PlayerInfo[playa][pWarny],Nick(playerid),playerid,text);
			    Info(playa,dstring);
			    format(dstring, sizeof(dstring),"~r~(%d)%s zostal ostrzezony (%d/4)~n~~y~przez: (%d)%s~n~~w~Za: %s",playa,Nick(playa),PlayerInfo[playa][pWarny],playerid,Nick(playerid),text);
		    	NapisText(dstring);
			    dKick(playa);
			}
		}
		else
		{
			Info(playerid,"Nie poprawne id gracza!");
		}
		return 1;
	}

	CMD:kick(playerid, cmdtext[])
	{
	    if(!ToAdminLevel(playerid,1)) return 1;
		new tmp[64],idx;
		tmp = strtok(cmdtext, idx);
		if(isnull(tmp))
		{
			Info(playerid,"U¿yj: /kick (ID) (powód)");
			return 1;
 		}
	 	new playa = strval(tmp);
	 	if(playa==playerid){ Info(playerid,"Nie mo¿esz wrzuciæ sam siebie!"); return 1; }
		if(IsPlayerConnected(playa))
		{
		    if(PlayerInfo[playa][pAdmin]>PlayerInfo[playerid][pAdmin])
		    {
				Info(playerid,""C_CZERWONY"Nie mo¿esz wyrzuciæ admina z wiêksz¹ rang¹ od twojej!");
				return 1;
		    }
			new text[80];
			text=strrest(cmdtext,idx);
			if(isnull(text))
			{
				Info(playerid,"U¿yj: /kick (ID) (powód)");
				return 1;
			}
		    format(dstring, sizeof(dstring),"Zosta³eœ wyrzucony przez %s(%d) za: %s",Nick(playerid),playerid,text);
		    Info(playa,dstring);
		    format(dstring, sizeof(dstring),"~r~(%d)%s zostal wyrzucony~n~~y~przez: (%d)%s~n~~w~Za: %s",playa,Nick(playa),playerid,Nick(playerid),text);
		    NapisText(dstring);
		    dKick(playa);
		}
		else
		{
			Info(playerid,"Nie poprawne id gracza!");
		}
		return 1;
	}

	CMD:podglad(playerid, cmdtext[])
	{
		if(!ToAdminLevel(playerid,1)) return 1;
		if(Podglad==true)
		{
		    Podglad=false;
		    Info(playerid,"Podgl¹d CB radia i pw wy³¹czony!");
		}
		else
		{
		    Podglad=true;
		    Info(playerid,"Podgl¹d CB radia i pw wy³¹czony!");
		}
		return 1;
	}

	CMD:lista(playerid, cmdtext[])
	{
		if(!ToAdminLevel(playerid,1)) return 1;
		if(Lista[playerid]==true)
		{
		    Lista[playerid]=false;
		    Info(playerid,"Teraz nie bêdziesz wyœwietlany na liœcie adminów!");
		}
		else
		{
		    Lista[playerid]=true;
		    Info(playerid,"Teraz bêdziesz wyœwietlany na liœcie adminów!");
		}
		return 1;
	}

	CMD:tankuj(playerid, cmdtext[])
	{
	    if(GetPlayerState(playerid)!=PLAYER_STATE_DRIVER)
		{
		    Info(playerid,""C_CZERWONY"Nie jesteœ kierowc¹ pojazdu!");
		    return 1;
		}
    	if(!NaStacjiPaliw(playerid))
		{
			Info(playerid, ""C_CZERWONY"Nie jesteœ na stacji benzynowej!");
			return 1;
		}
		new v=GetPlayerVehicleID(playerid),potrzebne=vPaliwoMax[v]-vPaliwo[v];
		if(potrzebne<1)
		{
			Info(playerid, ""C_CZERWONY"Twój pojazd nie potrzebuje paliwa!");
			return 1;
		}
		new id;
		id=StacjaPaliw(playerid);
		if(id==99)
		{
		    Info(playerid, ""C_CZERWONY"Nie jesteœ na stacji benzynowej!");
			return 1;
		}
		format(dstring, sizeof(dstring), ""C_ZOLTY"Witaj na stacji benzynowej!\n"C_ZIELONY"Do pe³nego baku brakuje Tobie: %d litr/ów.\n1 litr kosztuje %.02f$\n"C_ZOLTY"Ile litrów chcesz zatankowaæ?",potrzebne,StacjaInfo[id][sCena]);
		ShowPlayerDialog(playerid,5,DIALOG_STYLE_INPUT,""C_POMARANCZOWY"Tankowanie",dstring,"Tankuj","Zamknij");
		return 1;
	}

    CMD:pojazd(playerid, cmdtext[])
	{
		if(GetPlayerState(playerid)!=PLAYER_STATE_DRIVER)
		{
		    Info(playerid,""C_CZERWONY"Nie jesteœ kierowc¹ pojazdu!");
		    return 1;
		}
		ShowPlayerDialog(playerid,4,DIALOG_STYLE_LIST,""C_ZOLTY"Zarz¹dzanie pojazdem",""C_ZIELONY"W³¹cz"C_BIALY" / "C_CZERWONY"Wy³¹cz "C_ZOLTY"silnik\n"C_ZIELONY"W³¹cz"C_BIALY" / "C_CZERWONY"Wy³¹cz "C_ZOLTY"lampy\n"C_ZIELONY"Otwórz"C_BIALY" / "C_CZERWONY"Zamknij "C_ZOLTY"maskê\n"C_ZIELONY"Otwórz"C_BIALY" / "C_CZERWONY"Zamknij "C_ZOLTY"baga¿nik\n"C_ZIELONY"Otwórz"C_BIALY"  / "C_CZERWONY"Zamknij "C_ZOLTY"drzwi\n"C_ZOLTY"CB-Radio","Wybierz","Zamknij");
		return 1;
	}

	COMMAND:p(playerid,cmdtext[])
	{
	  return cmd_pojazd(playerid,cmdtext);
	}

	CMD:cb(playerid, cmdtext[])
	{
	    if(PlayerInfo[playerid][pWyciszony]>=1)
		{
		    Info(playerid,""C_CZERWONY"Jesteœ wyciszony!");
			return 1;
		}
		if(!IsPlayerInAnyVehicle(playerid))
		{
		    Info(playerid,""C_CZERWONY"Nie jesteœ w ¿adnym pojeŸdzie!");
		    return 1;
		}
		if(ToRadiowoz(GetPlayerVehicleID(playerid)))
		{
			Info(playerid,""C_CZERWONY"Ten pojazd nie ma CB-Radia!");
		    return 1;
		}
		new kanal=vCB[GetPlayerVehicleID(playerid)];
		if(kanal==0)
		{
		    Info(playerid,""C_CZERWONY"CB-Radio w tym pojeŸdzie jest wy³¹czone, musisz je najpierw uruchomiæ!");
		    return 1;
		}
		new text[80],idx;
		text=strrest(cmdtext,idx);
		if(isnull(text))
		{
			Info(playerid, "U¿yj: /cb (tekst)");
			return 1;
		}
		if(Bluzg(text))
		{
		    format(dstring,sizeof(dstring),"AC: "C_BIALY"(%d) %s zosta³ wyciszony (5 min), za: "C_CZERWONY"wulgaryzmy",playerid,Nick(playerid));
			SendClientMessageToAll(KOLOR_ROZOWY,dstring);
		    KillTimer(MuteTimer[playerid]);
			MuteTimer[playerid]=SetTimerEx("Odcisz",60000*5,false,"i",playerid);
			PlayerInfo[playerid][pWyciszony]=5;
			ZapiszKonto(playerid);
			return 1;
		}
		UpperToLower(text);
		new Float:Pos[3];
		GetPlayerPos(playerid,Pos[0],Pos[1],Pos[2]);
		foreach(Player,i)
		{
		    if(IsPlayerInAnyVehicle(i)&&vCB[GetPlayerVehicleID(i)]==kanal)
		    {
				format(dstring, sizeof(dstring), "[CB:"C_ZIELONY"%d"C_ZOLTY"]: "C_TURKUSOWY"%s",kanal,text);
				SendClientMessage(i,KOLOR_ZOLTY,dstring);
			}
			if(Podglad==true&&PlayerInfo[i][pAdmin]>=1)
			{
			    format(dstring, sizeof(dstring), "[CB:%d][ID:%d]%s: "C_TURKUSOWY"%s",kanal,playerid,Nick(playerid),text);
				SendClientMessage(i,KOLOR_ROZOWY,dstring);
			}
		}
		return 1;
	}

	CMD:konto(playerid, cmdtext[])
	{
        ShowPlayerDialog(playerid,9,DIALOG_STYLE_LIST,""C_POMARANCZOWY"Zarz¹dzanie kontem",""C_ZOLTY"Statystyki\n"C_ZOLTY"Zmieñ has³o\n"C_ZOLTY"Blokada PW","Wybierz","Zamknij");
	    return 1;
	}

	CMD:w(playerid, cmdtext[])
	{
	    if(PlayerInfo[playerid][pWyciszony]>=1)
		{
		    Info(playerid,""C_CZERWONY"Jesteœ wyciszony!");
			return 1;
		}
	    new tmp[64],idx;
		tmp = strtok(cmdtext, idx);
		if(isnull(tmp))
		{
			Info(playerid,"U¿yj: /w (id) (tekst)");
			return 1;
 		}
	 	new playa = strval(tmp);
		if(IsPlayerConnected(playa)&&Zalogowany[playa]==true)
		{
 			if(playa==playerid){ Info(playerid,""C_CZERWONY"Nie mo¿esz pisaæ sam do siebie!"); return 1; }
		 	if(BlokadaPW[playa]==true){ Info(playerid,""C_CZERWONY"Ten gracz zablokowa³ prywatne wiadomoœci!"); return 1; }
		 	if(BlokadaPW[playerid]==true){ Info(playerid,""C_CZERWONY"Zablokowa³eœ prywatne wiadomoœci!"); return 1; }
			new text[80];
			text=strrest(cmdtext,idx);
			if(isnull(text))
			{
				Info(playerid,"U¿yj: /w (id) (tekst)");
				return 1;
			}
			if(Bluzg(text))
			{
			    format(dstring,sizeof(dstring),"AC: "C_BIALY"(%d) %s zosta³ wyciszony (5 min), za: "C_CZERWONY"wulgaryzmy",playerid,Nick(playerid));
				SendClientMessageToAll(KOLOR_ROZOWY,dstring);
			    KillTimer(MuteTimer[playerid]);
				MuteTimer[playerid]=SetTimerEx("Odcisz",60000*5,false,"i",playerid);
				PlayerInfo[playerid][pWyciszony]=5;
				ZapiszKonto(playerid);
				return 1;
			}
			UpperToLower(text);
			format(dstring, sizeof(dstring), "[PW]>>"C_ZIELONY"[%d]%s: "C_BEZOWY"%s",playa,Nick(playa),text);
			SendClientMessage(playerid,KOLOR_BEZOWY, dstring);
			format(dstring, sizeof(dstring), "[PW]<<"C_ZIELONY"[%d]%s: "C_BEZOWY"%s",playerid,Nick(playerid),text);
			SendClientMessage(playa,KOLOR_BEZOWY, dstring);
			if(Podglad==true)
			{
				foreach(Player,i)
				{
				    if(PlayerInfo[i][pAdmin]>=1)
				    {
			    		format(dstring, sizeof(dstring), "[PW] [%d]%s do [%d][%s]: "C_BEZOWY"%s",playerid,Nick(playerid),playa,Nick(playa),text);
						SendClientMessage(i,KOLOR_ROZOWY, dstring);
					}
				}
			}
		}
		else
		{
			Info(playerid,"Poda³eœ nie poprawne ID!");
		}
		return 1;
	}

	CMD:regulamin(playerid, cmdtext[])
	{
	    new s[300],ss[300],str[600];
	    format(s, sizeof(s), ""C_ZOLTY"1. Jest to polski serwer, wiêc u¿ywamy wy³¹cznie polskiego jêzyka.\n2. Zabrania siê jakichkolwiek bluzgów, zachowaj kulturê osobist¹.\n3. Zabrania siê zak³ócania pozosta³ym osobom gry.\n4. Zabrania siê spamowania lub pisania bez takiej potrzeby.");
	    format(ss, sizeof(ss), ""C_ZOLTY"5. Zabrania siê wykorzystywania cheatów lub jakichkolwiek b³êdów skryptu.\n6. Gdy jesteœ œwiadkiem przewinieñ, Twoim obowi¹zkiem jest poinformowanie o tym administracji.\n7. Za z³amanie regulaminu mo¿na otrzymaæ kare, w najgorszym wypadku bana.");
 	   	format(str, sizeof(str), "%s\n%s",s,ss);
 	    Info(playerid,str);
		return 1;
	}

	CMD:autorzy(playerid, cmdtext[])
	{
		Info(playerid,""C_POMARANCZOWY"XxX\n"C_ZOLTY"Autor gamemoda: "C_CZERWONY"Inferno\n"C_ZOLTY"Dziêkujemy za uwagê :-)\nMi³ej gry!");
		return 1;
	}

	CMD:raport(playerid, cmdtext[])
	{
	    if(PlayerInfo[playerid][pWyciszony]>=1)
		{
		    Info(playerid,""C_CZERWONY"Jesteœ wyciszony!");
			return 1;
		}
		new text[80],idx;
		text=strrest(cmdtext,idx);
		if(isnull(text))
		{
			Info(playerid, "U¿yj: /raport (tekst)");
			return 1;
		}
		Info(playerid,""C_ZOLTY"Raport wys³any!");
		UpperToLower(text);
		foreach(Player,i)
		{
		    if(PlayerInfo[i][pAdmin]>=1)
		    {
				format(dstring, sizeof(dstring), ""C_CZERWONY"[Raport:"C_ZIELONY"[%d]%s"C_CZERWONY"]: %s",playerid,Nick(playerid),text);
				SendClientMessage(i,KOLOR_CZERWONY,dstring);
			}
		}
		return 1;
	}

	CMD:premium(playerid, cmdtext[])
	{
		if(PlayerInfo[playerid][pPremium]<1)
		{
		    Info(playerid,""C_CZERWONY"Nie posiadasz konta premium!\n"C_ZOLTY"Informacje na temat konta premium mo¿na znaleŸæ na stronie: "C_ZIELONY"www.xxx.pl");
		    return 1;
		}
		return 1;
	}

	CMD:admini(playerid, cmdtext[])
	{
		new admini=0;
		SendClientMessage(playerid,KOLOR_CZERWONY,"Administracja online:");
		foreach(Player,i)
		{
		    if(PlayerInfo[i][pAdmin]==1&&Lista[i]==true)
		    {
		        admini++;
				format(dstring, sizeof(dstring), "Junior Admin: "C_BIALY"[%d] %s",i,Nick(i));
				SendClientMessage(playerid,KOLOR_BEZOWY,dstring);
			}
			else if(PlayerInfo[i][pAdmin]==2&&Lista[i]==true)
		    {
		        admini++;
				format(dstring, sizeof(dstring), "Administrator: "C_BIALY"[%d] %s",i,Nick(i));
				SendClientMessage(playerid,KOLOR_ZOLTY,dstring);
			}
			else if(PlayerInfo[i][pAdmin]==3&&Lista[i]==true)
		    {
		        admini++;
				format(dstring, sizeof(dstring), "Head Administrator: "C_BIALY"[%d] %s",i,Nick(i));
				SendClientMessage(playerid,KOLOR_CZERWONY,dstring);
			}
		}
		if(admini==0){ SendClientMessage(playerid,KOLOR_ZOLTY,"* Brak administratorów online!"); }
		return 1;
	}

	CMD:dawaj(playerid, cmdtext[])
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        Info(playerid,""C_CZERWONY"Nie mo¿esz u¿ywaæ animacji bêd¹c w pojeŸdzie!");
	        return 1;
	    }
	    ApplyAnimation(playerid,"POLICE","CopTraf_Come",4.1,0,0,0,0,0);
	    return 1;
	}

	CMD:stop(playerid, cmdtext[])
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        Info(playerid,""C_CZERWONY"Nie mo¿esz u¿ywaæ animacji bêd¹c w pojeŸdzie!");
	        return 1;
	    }
	    ApplyAnimation(playerid,"POLICE","CopTraf_Stop",4.1,0,0,0,0,0);
	    return 1;
	}

	CMD:smiech(playerid, cmdtext[])
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        Info(playerid,""C_CZERWONY"Nie mo¿esz u¿ywaæ animacji bêd¹c w pojeŸdzie!");
	        return 1;
	    }
	    ApplyAnimation(playerid,"RAPPING","Laugh_01",4.1,0,0,0,0,0);
	    return 1;
	}

	CMD:daj(playerid, cmdtext[])
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        Info(playerid,""C_CZERWONY"Nie mo¿esz u¿ywaæ animacji bêd¹c w pojeŸdzie!");
	        return 1;
		}
	    ApplyAnimation(playerid,"DEALER","shop_pay",4.1,0,0,0,0,0);
	    return 1;
	}

	CMD:ratuj(playerid, cmdtext[])
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        Info(playerid,""C_CZERWONY"Nie mo¿esz u¿ywaæ animacji bêd¹c w pojeŸdzie!");
	        return 1;
	    }
	    ApplyAnimation(playerid,"MEDIC","CPR",4.1,0,0,0,0,0);
	    return 1;
	}

	CMD:poloz(playerid, cmdtext[])
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        Info(playerid,""C_CZERWONY"Nie mo¿esz u¿ywaæ animacji bêd¹c w pojeŸdzie!");
	        return 1;
	    }
	    ApplyAnimation(playerid,"CARRY","putdwn",4.1,0,0,0,0,0);
	    return 1;
	}

	CMD:podnies(playerid, cmdtext[])
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        Info(playerid,""C_CZERWONY"Nie mo¿esz u¿ywaæ animacji bêd¹c w pojeŸdzie!");
	        return 1;
	    }
	    ApplyAnimation(playerid,"CARRY","liftup",4.1,0,0,0,0,0);
	    return 1;
	}

	CMD:caluj(playerid, cmdtext[])
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        Info(playerid,""C_CZERWONY"Nie mo¿esz u¿ywaæ animacji bêd¹c w pojeŸdzie!");
	        return 1;
	    }
		new tmp[64],idx;
	    tmp = strtok(cmdtext, idx);
		if(isnull(tmp))
		{
			Info(playerid,"U¿yj: /caluj (nr)\nOd 1 do 2");
			return 1;
	 	}
	 	new pkt=strval(tmp);
	 	if(pkt==1)
	 	{
	 	    ApplyAnimation(playerid,"KISSING","Grlfrd_Kiss_02",4.1,0,0,0,0,0);
	 	    return 1;
	 	}
	 	else if(pkt==2)
	 	{
	 	    ApplyAnimation(playerid,"KISSING","Playa_Kiss_01",4.1,0,0,0,0,0);
	 	    return 1;
	 	}
	 	else
	 	{
	 	    Info(playerid,"Nie poprawny numer!");
	 	}
	 	return 1;
	}

	CMD:kibic(playerid, cmdtext[])
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        Info(playerid,""C_CZERWONY"Nie mo¿esz u¿ywaæ animacji bêd¹c w pojeŸdzie!");
	        return 1;
	    }
		new tmp[64],idx;
	    tmp = strtok(cmdtext, idx);
		if(isnull(tmp))
		{
			Info(playerid,"U¿yj: /kibic (nr)\nOd 1 do 2");
			return 1;
	 	}
	 	new pkt=strval(tmp);
	 	if(pkt==1)
	 	{
	 	    ApplyAnimation(playerid,"ON_LOOKERS","shout_02",4.1,0,0,0,0,0);
	 	    return 1;
	 	}
	 	else if(pkt==2)
	 	{
	 	    ApplyAnimation(playerid,"STRIP","PUN_HOLLER",4.1,0,0,0,0,0);
	 	    return 1;
	 	}
	 	else
	 	{
	 	    Info(playerid,"Nie poprawny numer!");
	 	}
	 	return 1;
	}

	CMD:yeah(playerid, cmdtext[])
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        Info(playerid,""C_CZERWONY"Nie mo¿esz u¿ywaæ animacji bêd¹c w pojeŸdzie!");
	        return 1;
	    }
		new tmp[64],idx;
	    tmp = strtok(cmdtext, idx);
		if(isnull(tmp))
		{
			Info(playerid,"U¿yj: /yeah (nr)\nOd 1 do 2");
			return 1;
	 	}
	 	new pkt=strval(tmp);
	 	if(pkt==1)
	 	{
	 	    ApplyAnimation(playerid,"CASINO","manwind",4.1,0,0,0,0,0);
	 	    return 1;
	 	}
	 	else if(pkt==2)
	 	{
	 	    ApplyAnimation(playerid,"CASINO","Slot_win_out",4.1,0,0,0,0,0);
	 	    return 1;
	 	}
	 	else
	 	{
	 	    Info(playerid,"Nie poprawny numer!");
	 	}
	 	return 1;
	}

	CMD:opieraj(playerid, cmdtext[])
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        Info(playerid,""C_CZERWONY"Nie mo¿esz u¿ywaæ animacji bêd¹c w pojeŸdzie!");
	        return 1;
	    }
	    ApplyAnimation(playerid,"GANGS","leanIDLE",4.1,0,0,0,1,0);
	    return 1;
	}

	CMD:siema(playerid, cmdtext[])
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        Info(playerid,""C_CZERWONY"Nie mo¿esz u¿ywaæ animacji bêd¹c w pojeŸdzie!");
	        return 1;
	    }
		new tmp[64],idx;
	    tmp = strtok(cmdtext, idx);
		if(isnull(tmp))
		{
			Info(playerid,"U¿yj: /siema (nr)\nOd 1 do 3");
			return 1;
	 	}
	 	new pkt=strval(tmp);
	 	if(pkt==1)
	 	{
	 	    ApplyAnimation(playerid,"GANGS","hndshkaa",4.1,0,0,0,0,0);
	 	    return 1;
	 	}
	 	else if(pkt==2)
	 	{
	 	    ApplyAnimation(playerid,"GANGS","hndshkba",4.1,0,0,0,0,0);
	 	    return 1;
	 	}
	 	else if(pkt==3)
	 	{
	 	    ApplyAnimation(playerid,"GANGS","hndshkfa",4.1,0,0,0,0,0);
	 	    return 1;
	 	}
	 	else
	 	{
	 	    Info(playerid,"Nie poprawny numer!");
	 	}
	 	return 1;
	}

	CMD:nie(playerid, cmdtext[])
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        Info(playerid,""C_CZERWONY"Nie mo¿esz u¿ywaæ animacji bêd¹c w pojeŸdzie!");
	        return 1;
	    }
	    ApplyAnimation(playerid,"FOOD","EAT_Vomit_SK",4.1,0,0,0,0,0);
	    return 1;
	}

	CMD:tak(playerid, cmdtext[])
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        Info(playerid,""C_CZERWONY"Nie mo¿esz u¿ywaæ animacji bêd¹c w pojeŸdzie!");
	        return 1;
	    }
	    ApplyAnimation(playerid,"GANGS","DEALER_DEAL",4.1,0,0,0,0,0);
	    return 1;
	}

	CMD:turlaj(playerid, cmdtext[])
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        Info(playerid,""C_CZERWONY"Nie mo¿esz u¿ywaæ animacji bêd¹c w pojeŸdzie!");
	        return 1;
	    }
	    ApplyAnimation(playerid,"MD_CHASE","MD_HANG_Lnd_Roll",4.1,0,0,0,0,0);
	    return 1;
	}

	CMD:wymiotuj(playerid, cmdtext[])
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        Info(playerid,""C_CZERWONY"Nie mo¿esz u¿ywaæ animacji bêd¹c w pojeŸdzie!");
	        return 1;
	    }
	    ApplyAnimation(playerid,"FOOD","EAT_Vomit_P",4.1,0,0,0,0,0);
	    return 1;
	}

	CMD:silownia(playerid, cmdtext[])
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        Info(playerid,""C_CZERWONY"Nie mo¿esz u¿ywaæ animacji bêd¹c w pojeŸdzie!");
	        return 1;
	    }
		new tmp[64],idx;
	    tmp = strtok(cmdtext, idx);
		if(isnull(tmp))
		{
			Info(playerid,"U¿yj: /silownia (nr)\n1 (k³adziesz siê na maszynie do æwiczeñ)\n2 (bierzesz sztangê w górê)\n3 (bierzesz sztangê w dó³)\n4 (schodzisz z maszyny do æwiczeñ)");
			return 1;
	 	}
	 	new pkt=strval(tmp);
	 	if(pkt==1)
	 	{
	 	    ApplyAnimation(playerid,"benchpress","gym_bp_geton",4.1,0,0,0,1,0);
	 	    return 1;
	 	}
	 	else if(pkt==2)
	 	{
	 	    ApplyAnimation(playerid,"benchpress","gym_bp_up_A",4.1,0,0,0,1,0);
	 	    return 1;
	 	}
	 	else if(pkt==3)
	 	{
	 	    ApplyAnimation(playerid,"benchpress","gym_bp_down",4.1,0,0,0,1,0);
	 	    return 1;
	 	}
        else if(pkt==4)
	 	{
	 	    ApplyAnimation(playerid,"benchpress","gym_bp_getoff",4.1,0,0,0,0,0);
	 	    return 1;
	 	}
	 	else
	 	{
	 	    Info(playerid,"Nie poprawny numer!");
	 	}
	 	return 1;
	}

	CMD:lez(playerid, cmdtext[])
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        Info(playerid,""C_CZERWONY"Nie mo¿esz u¿ywaæ animacji bêd¹c w pojeŸdzie!");
	        return 1;
	    }
		new tmp[64],idx;
	    tmp = strtok(cmdtext, idx);
		if(isnull(tmp))
		{
			Info(playerid,"U¿yj: /lez (nr)\nOd 1 do 3");
			return 1;
	 	}
	 	new pkt=strval(tmp);
	 	if(pkt==1)
	 	{
	 	    ApplyAnimation(playerid,"BEACH","bather",4.1,0,0,0,1,0);
	 	    return 1;
	 	}
	 	else if(pkt==2)
	 	{
	 	    ApplyAnimation(playerid,"BEACH","ParkSit_W_loop",4.1,0,0,0,1,0);
	 	    return 1;
	 	}
	 	else if(pkt==3)
	 	{
	 	    ApplyAnimation(playerid,"BEACH","SitnWait_loop_W",4.1,0,0,0,1,0);
	 	    return 1;
	 	}
	 	else
	 	{
	 	    Info(playerid,"Nie poprawny numer!");
	 	}
	 	return 1;
	}

	CMD:pij(playerid, cmdtext[])
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        Info(playerid,""C_CZERWONY"Nie mo¿esz u¿ywaæ animacji bêd¹c w pojeŸdzie!");
	        return 1;
	    }
	    ApplyAnimation(playerid,"BAR","dnk_stndF_loop",4.1,0,0,0,0,0);
	    return 1;
	}

	CMD:jedz(playerid, cmdtext[])
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        Info(playerid,""C_CZERWONY"Nie mo¿esz u¿ywaæ animacji bêd¹c w pojeŸdzie!");
	        return 1;
	    }
	    ApplyAnimation(playerid,"FOOD","EAT_Burger",4.1,0,0,0,0,0);
	    return 1;
	}

	CMD:bar(playerid, cmdtext[])
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        Info(playerid,""C_CZERWONY"Nie mo¿esz u¿ywaæ animacji bêd¹c w pojeŸdzie!");
	        return 1;
	    }
		new tmp[64],idx;
	    tmp = strtok(cmdtext, idx);
		if(isnull(tmp))
		{
			Info(playerid,"U¿yj: /bar (nr)\n1 (bierzesz napój z lady)\n2 (s³uchasz zamówienia)\n3 (wyci¹gasz coœ spod lady)\n4 (podajesz coœ)\n5 (nalewasz coœ z maszyny)\n6 (sk³adasz zamówienie)\n7 (opierasz siê przy ladzie[1])\n8 (opierasz siê przy ladzie[2])");
			return 1;
	 	}
	 	new pkt=strval(tmp);
	 	if(pkt==1)
	 	{
	 	    ApplyAnimation(playerid,"BAR","Barcustom_get",4.1,0,0,0,0,0);
	 	    return 1;
	 	}
	 	else if(pkt==2)
	 	{
	 	    ApplyAnimation(playerid,"BAR","Barcustom_order",4.1,0,0,0,0,0);
	 	    return 1;
	 	}
	 	else if(pkt==3)
	 	{
	 	    ApplyAnimation(playerid,"BAR","Barserve_bottle",4.1,0,0,0,0,0);
	 	    return 1;
	 	}
	 	else if(pkt==4)
	 	{
	 	    ApplyAnimation(playerid,"BAR","Barserve_give",4.1,0,0,0,0,0);
	 	    return 1;
	 	}
	 	else if(pkt==5)
	 	{
	 	    ApplyAnimation(playerid,"BAR","Barserve_glass",4.1,0,0,0,0,0);
	 	    return 1;
	 	}
	 	else if(pkt==6)
	 	{
	 	    ApplyAnimation(playerid,"BAR","Barserve_order",4.1,0,0,0,0,0);
	 	    return 1;
	 	}
	 	else if(pkt==7)
	 	{
	 	    ApplyAnimation(playerid,"BAR","Barserve_in",4.1,0,0,0,1,0);
	 	    return 1;
	 	}
	 	else if(pkt==8)
	 	{
	 	    ApplyAnimation(playerid,"BAR","BARman_idle",4.1,0,0,0,1,0);
	 	    return 1;
	 	}
	 	else
	 	{
	 	    Info(playerid,"Nie poprawny numer!");
	 	}
	 	return 1;
	}

	CMD:spij(playerid, cmdtext[])
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        Info(playerid,""C_CZERWONY"Nie mo¿esz u¿ywaæ animacji bêd¹c w pojeŸdzie!");
	        return 1;
	    }
	    ApplyAnimation(playerid,"CRACK","crckidle2",4.1,0,0,0,1,0);
	    return 1;
	}

	CMD:ranny(playerid, cmdtext[])
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        Info(playerid,""C_CZERWONY"Nie mo¿esz u¿ywaæ animacji bêd¹c w pojeŸdzie!");
	        return 1;
	    }
		new tmp[64],idx;
	    tmp = strtok(cmdtext, idx);
		if(isnull(tmp))
		{
			Info(playerid,"U¿yj: /ranny (nr)\nOd 1 do 2");
			return 1;
	 	}
	 	new pkt=strval(tmp);
	 	if(pkt==1)
	 	{
	 	    ApplyAnimation(playerid,"CRACK","crckidle1",4.1,0,0,0,1,0);
	 	    return 1;
	 	}
	 	else if(pkt==2)
	 	{
	 	    ApplyAnimation(playerid,"SWAT","gnstwall_injurd",4.1,0,0,0,1,0);
	 	    return 1;
	 	}
	 	else
	 	{
	 	    Info(playerid,"Nie poprawny numer!");
	 	}
	 	return 1;
	}

	CMD:mysl(playerid, cmdtext[])
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        Info(playerid,""C_CZERWONY"Nie mo¿esz u¿ywaæ animacji bêd¹c w pojeŸdzie!");
	        return 1;
	    }
	    ApplyAnimation(playerid,"COP_AMBIENT","Coplook_think",4.1,0,0,0,0,0);
	    return 1;
	}

	CMD:szafka(playerid, cmdtext[])
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        Info(playerid,""C_CZERWONY"Nie mo¿esz u¿ywaæ animacji bêd¹c w pojeŸdzie!");
	        return 1;
	    }
		new tmp[64],idx;
	    tmp = strtok(cmdtext, idx);
		if(isnull(tmp))
		{
			Info(playerid,"U¿yj: /szafka (nr)\n1 (otwierasz szafke)\n2 (znajdujesz dokument w szafce)\n3 (zamykasz szafke)");
			return 1;
	 	}
	 	new pkt=strval(tmp);
	 	if(pkt==1)
	 	{
	 	    ApplyAnimation(playerid,"COP_AMBIENT","Copbrowse_in",4.1,0,0,0,0,0);
	 	    return 1;
	 	}
	 	else if(pkt==2)
	 	{
	 	    ApplyAnimation(playerid,"COP_AMBIENT","Copbrowse_nod",4.1,0,0,0,0,0);
	 	    return 1;
	 	}
	 	else if(pkt==3)
	 	{
	 	    ApplyAnimation(playerid,"COP_AMBIENT","Copbrowse_out",4.1,0,0,0,0,0);
	 	    return 1;
	 	}
	 	else
	 	{
	 	    Info(playerid,"Nie poprawny numer!");
	 	}
	 	return 1;
	}

	CMD:tancz(playerid, cmdtext[])
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        Info(playerid,""C_CZERWONY"Nie mo¿esz u¿ywaæ animacji bêd¹c w pojeŸdzie!");
	        return 1;
	    }
		new tmp[64],idx;
	    tmp = strtok(cmdtext, idx);
		if(isnull(tmp))
		{
			Info(playerid,"U¿yj: /tancz (nr)\nOd 1 do 4");
			return 1;
	 	}
	 	new pkt=strval(tmp);
	 	if(pkt==1)
	 	{
	 	    SendClientMessage(playerid,KOLOR_ZOLTY,"Klawisz 'enter' zatrzyma animacjê");
	 	    SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE1);
	 	    return 1;
	 	}
	 	else if(pkt==2)
	 	{
	 	    SendClientMessage(playerid,KOLOR_ZOLTY,"Klawisz 'enter' zatrzyma animacjê");
	 	    SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE2);
	 	    return 1;
	 	}
	 	else if(pkt==3)
	 	{
	 	    SendClientMessage(playerid,KOLOR_ZOLTY,"Klawisz 'enter' zatrzyma animacjê");
	 	    SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE3);
	 	    return 1;
	 	}
	 	else if(pkt==4)
	 	{
	 	    SendClientMessage(playerid,KOLOR_ZOLTY,"Klawisz 'enter' zatrzyma animacjê");
	 	    SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE4);
	 	    return 1;
	 	}
	 	else
	 	{
	 	    Info(playerid,"Nie poprawny numer!");
	 	}
	 	return 1;
	}

	CMD:lawka(playerid, cmdtext[])
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        Info(playerid,""C_CZERWONY"Nie mo¿esz u¿ywaæ animacji bêd¹c w pojeŸdzie!");
	        return 1;
	    }
		new tmp[64],idx;
	    tmp = strtok(cmdtext, idx);
		if(isnull(tmp))
		{
			Info(playerid,"U¿yj: /lawka (nr)\n1 (siadasz na ³awce)\n2 (wstajesz z ³awki)");
			return 1;
	 	}
	 	new pkt=strval(tmp);
	 	if(pkt==1)
	 	{
	 	    ApplyAnimation(playerid,"Attractors","Stepsit_in",4.1,0,0,0,1,0);
	 	    return 1;
	 	}
	 	else if(pkt==2)
	 	{
	 	    ApplyAnimation(playerid,"Attractors","Stepsit_out",4.1,0,0,0,1,0);
	 	    return 1;
	 	}
	 	else
	 	{
	 	    Info(playerid,"Nie poprawny numer!");
	 	}
	 	return 1;
	}

	CMD:krzeslo(playerid, cmdtext[])
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        Info(playerid,""C_CZERWONY"Nie mo¿esz u¿ywaæ animacji bêd¹c w pojeŸdzie!");
	        return 1;
	    }
		new tmp[64],idx;
	    tmp = strtok(cmdtext, idx);
		if(isnull(tmp))
		{
			Info(playerid,"U¿yj: /krzeslo (nr)\n1 (siadasz na krzes³o)\n2 (wstajesz z krzes³a)\n3 (siadasz przy stoliku - prawa)\n4 (siadasz przy stoliku - lewa)\n5 (wstajesz od stolika - lewa)\n6 (wstajesz od stolika - prawa)\n7 (wyskakujesz z krzes³a)");
			return 1;
	 	}
	 	new pkt=strval(tmp);
	 	if(pkt==1)
	 	{
	 	    ApplyAnimation(playerid,"PED","SEAT_down",4.1,0,0,0,1,0);
	 	    return 1;
	 	}
	 	else if(pkt==2)
	 	{
	 	    ApplyAnimation(playerid,"PED","SEAT_up",4.1,0,0,0,1,0);
	 	    return 1;
	 	}
	 	else if(pkt==3)
	 	{
	 	    ApplyAnimation(playerid,"FOOD","FF_Sit_In_L",4.1,0,0,0,1,0);
	 	    return 1;
	 	}
	 	else if(pkt==4)
	 	{
	 	    ApplyAnimation(playerid,"FOOD","FF_Sit_In_R",4.1,0,0,0,1,0);
	 	    return 1;
	 	}
	 	else if(pkt==5)
	 	{
	 	    ApplyAnimation(playerid,"FOOD","FF_Sit_Out_L_180",4.1,0,0,0,1,0);
	 	    return 1;
	 	}
	 	else if(pkt==6)
	 	{
	 	    ApplyAnimation(playerid,"FOOD","FF_Sit_Out_R_180",4.1,0,0,0,1,0);
	 	    return 1;
	 	}
	 	else if(pkt==7)
	 	{
	 	    ApplyAnimation(playerid,"CRIB","PED_Console_Win",4.1,0,0,0,1,0);
	 	    return 1;
	 	}
	 	else
	 	{
	 	    Info(playerid,"Nie poprawny numer!");
	 	}
	 	return 1;
	}

	CMD:zmeczony(playerid, cmdtext[])
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        Info(playerid,""C_CZERWONY"Nie mo¿esz u¿ywaæ animacji bêd¹c w pojeŸdzie!");
	        return 1;
	    }
	    ApplyAnimation(playerid,"PED","IDLE_tired",4.1,0,0,0,0,0);
	    return 1;
	}

	CMD:salutuj(playerid, cmdtext[])
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        Info(playerid,""C_CZERWONY"Nie mo¿esz u¿ywaæ animacji bêd¹c w pojeŸdzie!");
	        return 1;
	    }
	    ApplyAnimation(playerid,"ON_LOOKERS","panic_in",4.1,0,0,0,0,0);
	    return 1;
	}

	CMD:taxi(playerid, cmdtext[])
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        Info(playerid,""C_CZERWONY"Nie mo¿esz u¿ywaæ animacji bêd¹c w pojeŸdzie!");
	        return 1;
	    }
	    ApplyAnimation(playerid,"PED","IDLE_taxi",4.1,0,0,0,0,0);
	    return 1;
	}

	CMD:bacznosc(playerid, cmdtext[])
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        Info(playerid,""C_CZERWONY"Nie mo¿esz u¿ywaæ animacji bêd¹c w pojeŸdzie!");
	        return 1;
	    }
	    ApplyAnimation(playerid,"PED","Idlestance_fat",4.1,0,0,0,1,0);
	    return 1;
	}

	CMD:odejdz(playerid, cmdtext[])
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        Info(playerid,""C_CZERWONY"Nie mo¿esz u¿ywaæ animacji bêd¹c w pojeŸdzie!");
	        return 1;
	    }
	    ApplyAnimation(playerid,"PED","handscower",4.1,0,0,0,0,0);
	    return 1;
	}

	CMD:tam(playerid, cmdtext[])
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        Info(playerid,""C_CZERWONY"Nie mo¿esz u¿ywaæ animacji bêd¹c w pojeŸdzie!");
	        return 1;
	    }
	    ApplyAnimation(playerid,"ON_LOOKERS","point_loop",4.1,0,0,0,0,0);
	    return 1;
	}

	CMD:poddajsie(playerid, cmdtext[])
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        Info(playerid,""C_CZERWONY"Nie mo¿esz u¿ywaæ animacji bêd¹c w pojeŸdzie!");
	        return 1;
	    }
	    ApplyAnimation(playerid,"PED","handsup",4.1,0,0,0,1,0);
	    return 1;
	}

	CMD:fuckyou(playerid, cmdtext[])
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        Info(playerid,""C_CZERWONY"Nie mo¿esz u¿ywaæ animacji bêd¹c w pojeŸdzie!");
	        return 1;
	    }
	    ApplyAnimation(playerid,"PED","fucku",4.1,0,0,0,0,0);
	    return 1;
	}

	CMD:sikaj(playerid, cmdtext[])
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        Info(playerid,""C_CZERWONY"Nie mo¿esz u¿ywaæ animacji bêd¹c w pojeŸdzie!");
	        return 1;
	    }
	    SetPlayerSpecialAction(playerid, 68);
	    return 1;
	}

	CMD:tupnij(playerid, cmdtext[])
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        Info(playerid,""C_CZERWONY"Nie mo¿esz u¿ywaæ animacji bêd¹c w pojeŸdzie!");
	        return 1;
	    }
	    ApplyAnimation(playerid,"PED","FALL_land",4.1,0,0,0,0,0);
	    return 1;
	}

	CMD:odskocz(playerid, cmdtext[])
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        Info(playerid,""C_CZERWONY"Nie mo¿esz u¿ywaæ animacji bêd¹c w pojeŸdzie!");
	        return 1;
	    }
	    ApplyAnimation(playerid,"PED","EV_step",4.1,0,0,0,0,0);
	    return 1;
	}

	CMD:machaj(playerid, cmdtext[])
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        Info(playerid,""C_CZERWONY"Nie mo¿esz u¿ywaæ animacji bêd¹c w pojeŸdzie!");
	        return 1;
	    }
		new tmp[64],idx;
	    tmp = strtok(cmdtext, idx);
		if(isnull(tmp))
		{
			Info(playerid,"U¿yj: /machaj (nr)\n1 (machasz[1])\n2 (machasz[2])\n3 (machasz kucaj¹c)");
			return 1;
	 	}
	 	new pkt=strval(tmp);
	 	if(pkt==1)
	 	{
	 	    ApplyAnimation(playerid,"PED","endchat_03",4.1,0,0,0,0,0);
	 	    return 1;
	 	}
	 	else if(pkt==2)
	 	{
	 	    ApplyAnimation(playerid,"KISSING","gfwave2",4.1,0,0,0,0,0);
	 	    return 1;
	 	}
	 	else if(pkt==3)
	 	{
	 	    ApplyAnimation(playerid,"CAMERA","camcrch_cmon",4.1,0,0,0,0,0);
	 	    return 1;
	 	}
	 	else
	 	{
	 	    Info(playerid,"Nie poprawny numer!");
	 	}
	 	return 1;
	}

	CMD:rece(playerid, cmdtext[])
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        Info(playerid,""C_CZERWONY"Nie mo¿esz u¿ywaæ animacji bêd¹c w pojeŸdzie!");
	        return 1;
	    }
		new tmp[64],idx;
	    tmp = strtok(cmdtext, idx);
		if(isnull(tmp))
		{
			Info(playerid,"U¿yj: /rece (nr)\n1 (wystawiasz rêce do przodu)\n2 (trzymasz rêkê na biodrze)\n3 (zak³adasz rêce)\n4 (myjesz rêce)\n5 (rozstawiasz szeroko rêce)\n6 (stajesz na rêkach)");
			return 1;
	 	}
	 	new pkt=strval(tmp);
	 	if(pkt==1)
	 	{
	 	    ApplyAnimation(playerid,"PED","DRIVE_BOAT",4.1,0,0,0,1,0);
	 	    return 1;
	 	}
	 	else if(pkt==2)
	 	{
	 	    ApplyAnimation(playerid,"PED","woman_idlestance",4.1,0,0,0,1,0);
	 	    return 1;
	 	}
	 	else if(pkt==3)
	 	{
	 	    ApplyAnimation(playerid,"COP_AMBIENT","Coplook_in",4.1,0,0,0,1,0);
	 	    return 1;
	 	}
	 	else if(pkt==4)
	 	{
	 	    ApplyAnimation(playerid,"INT_HOUSE","wash_up",4.1,0,0,0,0,0);
	 	    return 1;
	 	}
	 	else if(pkt==5)
	 	{
	 	    ApplyAnimation(playerid,"BSKTBALL","BBALL_def_loop",4.1,0,0,0,1,0);
	 	    return 1;
	 	}
	 	else if(pkt==6)
	 	{
	 	    ApplyAnimation(playerid,"DAM_JUMP","DAM_Dive_Loop",4.1,0,0,0,1,0);
	 	    return 1;
	 	}
	 	else
	 	{
	 	    Info(playerid,"Nie poprawny numer!");
	 	}
	 	return 1;
	}

	CMD:kryj(playerid, cmdtext[])
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        Info(playerid,""C_CZERWONY"Nie mo¿esz u¿ywaæ animacji bêd¹c w pojeŸdzie!");
	        return 1;
	    }
	    ApplyAnimation(playerid,"PED","cower",4.1,0,0,0,1,0);
	    return 1;
	}

	CMD:raczkuj(playerid, cmdtext[])
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        Info(playerid,""C_CZERWONY"Nie mo¿esz u¿ywaæ animacji bêd¹c w pojeŸdzie!");
	        return 1;
	    }
	    ApplyAnimation(playerid,"PED","CAR_crawloutRHS",4.1,0,0,0,0,0);
	    return 1;
	}

	CMD:gleba(playerid, cmdtext[])
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	        Info(playerid,""C_CZERWONY"Nie mo¿esz u¿ywaæ animacji bêd¹c w pojeŸdzie!");
	        return 1;
	    }
		new tmp[64],idx;
	    tmp = strtok(cmdtext, idx);
		if(isnull(tmp))
		{
			Info(playerid,"U¿yj: /gleba (nr)\n1 (wywalasz siê na ziemie)\n2 (k³adziesz siê na plecach)\n3 (k³adziesz siê twarz¹ do ziemi)\n4 (padasz na plecy)\n5 (padasz na twarz)\n6 (padasz na ziemie trzymaj¹c siê za brzuch)\n7 (le¿ysz naæpany[1])\n8 (le¿ysz naæpany[2])\n9 (le¿ysz naæpany[3])\n10 (le¿ysz naæpany[4])");
			return 1;
	 	}
	 	new pkt=strval(tmp);
	 	if(pkt==1)
	 	{
	 	    ApplyAnimation(playerid,"PED","BIKE_fall_off",4.1,0,0,0,1,0);
	 	    return 1;
	 	}
	 	else if(pkt==2)
	 	{
	 	    ApplyAnimation(playerid,"PED","FLOOR_hit",4.1,0,0,0,1,0);
	 	    return 1;
	 	}
	 	else if(pkt==3)
	 	{
	 	    ApplyAnimation(playerid,"PED","FLOOR_hit_f",4.1,0,0,0,1,0);
	 	    return 1;
	 	}
	 	else if(pkt==4)
	 	{
	 	    ApplyAnimation(playerid,"PED","KO_shot_face",4.1,0,0,0,1,0);
	 	    return 1;
	 	}
	 	else if(pkt==5)
	 	{
	 	    ApplyAnimation(playerid,"PED","KO_shot_front",4.1,0,0,0,1,0);
	 	    return 1;
	 	}
	 	else if(pkt==6)
	 	{
	 	    ApplyAnimation(playerid,"PED","KO_shot_stom",4.1,0,0,0,1,0);
	 	    return 1;
	 	}
	 	else if(pkt==7)
	 	{
	 	    ApplyAnimation(playerid,"CRACK","crckdeth1",4.1,0,0,0,1,0);
	 	    return 1;
	 	}
	 	else if(pkt==8)
	 	{
	 	    ApplyAnimation(playerid,"CRACK","crckdeth2",4.1,0,0,0,1,0);
	 	    return 1;
	 	}
	 	else if(pkt==9)
	 	{
	 	    ApplyAnimation(playerid,"CRACK","crckdeth3",4.1,0,0,0,1,0);
	 	    return 1;
	 	}
	 	else if(pkt==10)
	 	{
	 	    ApplyAnimation(playerid,"CRACK","crckdeth4",4.1,0,0,0,1,0);
	 	    return 1;
	 	}
	 	else
	 	{
	 	    Info(playerid,"Nie poprawny numer!");
	 	}
	 	return 1;
	}
	
forward UstalLadownosc(v);
public UstalLadownosc(v)
{
	new m=GetVehicleModel(v);
    if(m==435)//wieksza przyczepka
    {
        vLadownosc[v]=1200;
	    vLadownoscMax[v]=1800;
	    return 1;
    }
    else if(m==591)//ta mniejsza troche
    {
        vLadownosc[v]=1000;
	    vLadownoscMax[v]=1500;
	    return 1;
    }
    else if(m==413||m==482||m==440)//busy
    {
        vLadownosc[v]=200;
	    vLadownoscMax[v]=400;
	    return 1;
    }
    else if(m==414||m==456||m==499)//te wieksze troche busy
    {
        vLadownosc[v]=500;
	    vLadownoscMax[v]=750;
	    return 1;
    }
    else if(m==498||m==609)//te duze busy
    {
        vLadownosc[v]=700;
	    vLadownoscMax[v]=1050;
	    return 1;
    }
    else
    {
        vLadownosc[v]=0;
	    vLadownoscMax[v]=0;
    }
	return 1;
}

forward UstalPaliwo(v);
public UstalPaliwo(v)
{
	if(ToRower(v)||ToPrzyczepa(v)||ToRC(v))
	{
	    vPaliwo[v]=0;
	    vPaliwoMax[v]=0;
	    return 1;
	}
	if(ToAutobus(v))
	{
	    vPaliwo[v]=500;
	    vPaliwoMax[v]=500;
	    return 1;
	}
	if(ToBus(v))
	{
	    vPaliwo[v]=80;
	    vPaliwoMax[v]=80;
	    return 1;
	}
	if(ToCiezarowka(v))
	{
	    vPaliwo[v]=350;
	    vPaliwoMax[v]=350;
	    return 1;
	}
	if(ToHelikopter(v))
	{
	    vPaliwo[v]=300;
	    vPaliwoMax[v]=300;
	    return 1;
	}
	if(ToSamolot(v))
	{
	    vPaliwo[v]=500;
	    vPaliwoMax[v]=500;
	    return 1;
	}
	if(ToLodz(v))
	{
	    vPaliwo[v]=150;
	    vPaliwoMax[v]=150;
	    return 1;
	}
	if(ToMotor(v))
	{
	    vPaliwo[v]=10;
	    vPaliwoMax[v]=10;
	    return 1;
	}
	if(ToOsobowy(v))
	{
	    vPaliwo[v]=50;
	    vPaliwoMax[v]=50;
	    return 1;
	}
	return 1;
}

forward ToOsobowy(id);
public ToOsobowy(id)
{
	new m=GetVehicleModel(id);
	if(!ToAutobus(m)
	&&!ToBus(m)
	&&!ToCiezarowka(m)
	&&!ToHelikopter(m)
	&&!ToSamolot(m)
	&&!ToLodz(m)
	&&!ToMotor(m)
	&&!ToRC(m)
	&&!ToPrzyczepa(m)
	&&!ToRower(m))
	{
		return 1;
	}
	return 0;
}

forward ToRower(id);
public ToRower(id)
{
	new m=GetVehicleModel(id);
	if(m==481//bmx
	||m==509//bike
	||m==510)//mountain bike
	{
		return 1;
	}
	return 0;
}

forward ToPrzyczepa(id);
public ToPrzyczepa(id)
{
	new m=GetVehicleModel(id);
	if(m==435//
	||m==450//
	||m==569//
	||m==570//
	||m==584//
	||m==590//
	||m==591//
	||m==606//
	||m==607//
	||m==608//
	||m==610//
	||m==611)//
	{
		return 1;
	}
	return 0;
}

forward ToRC(id);
public ToRC(id)
{
	new m=GetVehicleModel(id);
	if(m==441//rcbandit
	||m==594//rccam
	||m==564//rctiger
	||m==465//rcrider
	||m==501//rcgobiln
	||m==464)//rcbarron
	{
		return 1;
	}
	return 0;
}

forward ToMotor(id);
public ToMotor(id)
{
	new m=GetVehicleModel(id);
	if(m==448//pizzaboy
	||m==461//pcj600
	||m==462//faggio
	||m==463//freeway
	||m==468//sanchez
	||m==521//fcr900
	||m==522//nrg500
	||m==523//copbike
	||m==581//bf400
	||m==586)//wayfarer
	{
		return 1;
	}
	return 0;
}

forward ToLodz(id);
public ToLodz(id)
{
	new m=GetVehicleModel(id);
	if(m==430//predator
	||m==446//squalo
	||m==452//speeder
	||m==453//refeer
	||m==454//tropic
	||m==472//coast guard
	||m==473//dinghy
	||m==484//marquis
	||m==493//jetmax
	||m==595)//launch
	{
		return 1;
	}
	return 0;
}

forward ToSamolot(id);
public ToSamolot(id)
{
	new m=GetVehicleModel(id);
	if(m==460//skimmer
	||m==476//rustler
	||m==511//beagle
	||m==512//cropdust
	||m==513//stuntplane
	||m==519//shmal
	||m==520//hydra
	||m==553//nevada
	||m==577//at400
	||m==592//andromeda
	||m==593)//dodo
	{
		return 1;
	}
	return 0;
}

forward ToHelikopter(id);
public ToHelikopter(id)
{
	new m=GetVehicleModel(id);
	if(m==417//leviathan
	||m==425//hunter
	||m==447//seasparrow
	||m==469//sparrow
	||m==487//maverick
	||m==488//san news maverick
	||m==497//police maverick
	||m==548//cargojob
	||m==563)//raindanc
	{
		return 1;
	}
	return 0;
}

forward ToCiezarowka(id);
public ToCiezarowka(id)
{
	new m=GetVehicleModel(id);
	if(m==403//linerunner
	||m==406//dumper
    ||m==408//trash
    ||m==433//baraccks
    ||m==443//packer
    ||m==455//flatbed
    ||m==486//dozer
    ||m==514//petro
    ||m==515//roadtrain
    ||m==524//cement truck
    ||m==531//traktor
    ||m==532//kombajn
    ||m==573//duneride
    ||m==578//ctf30
    ||m==407//firetruck
    ||m==544//firela
    ||m==432//czolg rhino
    ||m==601)//swatvan
	{
		return 1;
	}
	return 0;
}

forward ToAutobus(id);
public ToAutobus(id)
{
	new m=GetVehicleModel(id);
	if(m==431//bus
	||m==437)//coach
	{
		return 1;
	}
	return 0;
}

forward ToBus(id);
public ToBus(id)
{
	new m=GetVehicleModel(id);
	if(m==413//pony
	||m==414//mule
	||m==418//moonbeam
	||m==440//rumpo
	||m==456//yankee
	||m==482//burrito
	||m==483//camper
	||m==498//boxville
	||m==499//benson
	||m==508//yourney
	||m==559//topfun
	||m==416//ambulans
	||m==423//mr. whoopie
	||m==427//enforcer
	||m==428//securica
	||m==582//news van
	||m==588//hotdog
	||m==609)//boxburg
	{
		return 1;
	}
	return 0;
}
