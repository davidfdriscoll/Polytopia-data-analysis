with player_elo_over_time as 
(select lineup.player_id, game.id, game.completed_ts, lineup.elo_after_game as elo 
   from lineup 
    join game on lineup.game_id = game.id
   where game.guild_id = 447883341463814144)
   
select id, min(game_ts), avg(elo) from

(select game.id, game.completed_ts as game_ts, 
         player_elo_over_time.player_id, 
		 player_elo_over_time.completed_ts as player_ts, 
		 rank() over (partition by game.id, player_elo_over_time.player_id order by player_elo_over_time.completed_ts desc) as rank,
		 player_elo_over_time.elo 
   from game
   cross join player_elo_over_time
   where player_elo_over_time.completed_ts < game.completed_ts
     and player_elo_over_time.completed_ts + interval '30 days' > game.completed_ts
     and game.guild_id = 447883341463814144
) a
	 
  where a.rank = 1
  group by a.id
  order by a.id