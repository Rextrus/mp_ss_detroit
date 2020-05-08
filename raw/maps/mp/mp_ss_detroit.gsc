// __/\\\________/\\\_______________________________________________________________________/\\\\\\\\\__/\\\\\\_________________________________        
//  _\/\\\_______\/\\\____________________________________________________________________/\\\////////__\////\\\_________________________________       
//   _\//\\\______/\\\___/\\\__________________/\\\_______/\\\___________________________/\\\/______________\/\\\_________________________________      
//   __\//\\\____/\\\___\///___/\\\\\\\\\\__/\\\\\\\\\\\_\///______/\\\\\\\\____________/\\\________________\/\\\_____/\\\\\\\\\_____/\\/\\\\\\___     
//    ___\//\\\__/\\\_____/\\\_\/\\\//////__\////\\\////___/\\\___/\\\//////____________\/\\\________________\/\\\____\////////\\\___\/\\\////\\\__    
//     ____\//\\\/\\\_____\/\\\_\/\\\\\\\\\\____\/\\\______\/\\\__/\\\___________________\//\\\_______________\/\\\______/\\\\\\\\\\__\/\\\__\//\\\_   
//      _____\//\\\\\______\/\\\_\////////\\\____\/\\\_/\\__\/\\\_\//\\\___________________\///\\\_____________\/\\\_____/\\\/////\\\__\/\\\___\/\\\_  
//       ______\//\\\_______\/\\\__/\\\\\\\\\\____\//\\\\\___\/\\\__\///\\\\\\\\______________\////\\\\\\\\\__/\\\\\\\\\_\//\\\\\\\\/\\_\/\\\___\/\\\_ 
//        _______\///________\///__\//////////______\/////____\///_____\////////__________________\/////////__\/////////___\////////\//__\///____\///__
/*
         _   ________   ___       __             _
        | | / / ___( ) / _ | ____/ /_____ ____  (_)
        | |/ / /__ |/ / __ |/ __/  '_/ _ `/ _ \/ /
        |___/\___/   /_/ |_/_/ /_/\_\\_,_/_//_/_/  
    Website: rextrus.com
	(C) mp_ss_detroit BY Rextrus

    Special Thanks to SheepWizard for helping me with the key function! :D
*/

main()
{
	maps\mp\_explosive_barrels::main();
    maps\mp\_load::main();

    level.detroitglow=(randomfloat(1),randomfloat(1),randomfloat(1));

    thread onPlayerConnect();
    thread house_door();
    thread office_door();
    thread key();
    thread nope();
    thread wall();
    thread credit();
    maps\mp\mp_ss_detroit_fx::main();	


    game["allies"] = "marines";
    game["axis"] = "opfor";
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    game["allies_soldiertype"] = "desert";
    game["axis_soldiertype"] = "desert";
    
    setdvar("env_fog", "0");
    setdvar("r_glowbloomintensity0",".1");
    setdvar("r_glowbloomintensity1",".1");
    setdvar("r_glowskybleedintensity0",".1");
    setdvar( "r_specularcolorscale", "1.86" );
    setdvar("ss_compassEnabled","0");
}
onPlayerConnect()
{
    level endon("game_ended");
    
    for(;;)
    {
        level waittill("connected", who);
        
        level.doorkey = false;

    }
}
house_door()
{
	door = getent("door", "targetname");
	door2 = getent("door2", "targetname");
	trig = getent("door_trigger", "targetname"); 
	
	for(;;)
	{
		trig waittill("trigger", who);

		if(isdefined(level.doorkey) && level.doorkey == true)
		{
			trig delete();
			door playSound("door1");
			door rotateyaw(90, 1.5, 0.7, 0.7);
			door2 rotateyaw(-90, 1.5, 0.7, 0.7);
			who iprintlnbold("You opened the door!");
			iprintlnbold(who.name+" opened the door!");
		}
		else 
			who iprintlnbold("You need to find the ^1key^7!");
	}
}


wall()
{
    trigger = getent("wall_explode_trigger", "targetname");
    wall = getent("wall_explode", "targetname");
    origin = getent("wall_explode_origin", "targetname");
    for(;;)
    {
        trigger waittill("trigger", who);
        trigger delete();
        if(who.pers["team"]=="axis")
		{
            playFx(level._effect["explosion_wall"],origin.origin);
            wall delete();
		}
    }
}
office_door()
{
	trigger = getent("office_door_trig", "targetname");
	door1 = getent("office_door1", "targetname");
	door2 = getent("office_door2", "targetname");

	for(;;)
	{
		trigger waittill("trigger");

		//door1 playSound("door1");
		door1 rotateyaw(90, 1.5, 0.7, 0.7);
		door2 rotateyaw(-90, 1.5, 0.7, 0.7);
		wait 10;
		door1 rotateyaw(-90, 1.5, 0.7, 0.7);
		door2 rotateyaw(90, 1.5, 0.7, 0.7);
		wait 2;
	}
}
nope()
{
	trigger = getent("nope", "targetname");

	for(;;)
	{
		trigger waittill("trigger", who);

		who iprintlnbold("nope.");
	}
}

key()
{
	key = getent("key", "targetname");
	ori = getEntArray("keyorigin", "targetname");
	keytrig = getent("keytrigger", "targetname");

	keytrig enableLinkTo();
    keytrig linkTo(key);

	key moveTo(ori[randomInt(5)].origin, 0.1);

	keytrig waittill("trigger", who);
	iprintlnbold(who.name+" found a ^1key^7!");
	level.doorkey = true;
	keytrig delete();
	key delete();
}
credit()
{
	level endon("intermission");

	if(isdefined(level.hud_creator))
		level.hud_creator destroy();

	level.hud_creator=newhudelem();
	level.hud_creator.x=110;
	level.hud_creator.y=(6*13);
	level.hud_creator.alignx="left";
	level.hud_creator.horzalign="left";
	level.hud_creator.fontscale=1.4;
	level.hud_creator.alpha=1;
	level.hud_creator.glowalpha=1;
	if(isdefined(level.randomcolor))
		level.hud_creator.glowcolor=level.randomcolor;
	else 
		level.hud_creator.glowcolor=level.detroitglow;
	level.hud_creator.hidewheninmenu=true;

	level.hud_creator settext("Map by Rextrus\nRextrus.com");
}