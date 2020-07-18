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
 
, players_dates as (select distinct date_range.date, 
         player_elo_over_time.player_id
   from date_range
   cross join player_elo_over_time
   where player_elo_over_time.date < date_range.date
     and player_elo_over_time.date + interval '30 days' > date_range.date
)
   
select string_agg(player.name, ', ') from players_dates 
   join player on players_dates.player_id = player.id
 where players_dates.date = '2019-07-15' 
    and players_dates.player_id not in (select player_id from players_dates where date = '2019-06-13')
