
main()
{
	precacheFX();
	spawnFX();
}
precacheFX()
{
	level._effect["explosion_wall"] 				= loadfx("explosions/wall_explosion_sniperescape");
	level._effect["heli_main"] 						= loadfx("fire/fire_vhc_dl_aftermath");
	level._effect["wall_heli"] 						= loadfx("smoke/wall_explosion_smoke");
	level._effect["dust_wind_fast"]				= loadfx ("dust/dust_wind_fast");
	//level._effect["dust_wind_slow"]					= loadfx ("dust/dust_wind_slow_yel_loop");
	level._effect["dust_wind_spiral"]				= loadfx ("dust/dust_spiral_runner");
	//level._effect["bird_seagull_flock_large"]		= loadfx ("misc/bird_seagull_flock_large");
	level._effect["hawk"]							= loadfx ("weather/hawk");
}
spawnFX()
{
	playLoopedFx(level._effect["heli_main"], 4, (904, -1512, 104), 0);
	playLoopedFx(level._effect["wall_heli"], 4, (819, -1736, 6), 0);
	

	playLoopedFx(level._effect["dust_wind_spiral"], 4, (2040, -360, 40), 0);
	playLoopedFx(level._effect["dust_wind_fast"], 4, (2040, -360, 40), 0);

	ent = maps\mp\_utility::createOneshotEffect( "hawk" );     
	ent.v[ "origin" ] = (2140, -536, 1000);      	
	ent.v[ "angles" ] = ( 270, 0, 0 );      	
	ent.v[ "fxid" ] = "hawk";      	
	ent.v[ "delay" ] = -15; 
}

