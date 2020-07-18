with player_elo_over_time as 
(select lineup.player_id, game.date 
   from lineup 
    join game on lineup.game_id = game.id
   where game.guild_id = 283436219780825088)
   
, date_range as
(select generate_series(
	min(date), 
	max(date), 
	'1 day'::interval) as date
   from player_elo_over_time
 )
   
select date, count(*) from

(select distinct date_range.date, 
         player_elo_over_time.player_id
   from date_range
   cross join player_elo_over_time
   where player_elo_over_time.date < date_range.date
     and player_elo_over_time.date + interval '30 days' > date_range.date
) a
	 
  group by a.date