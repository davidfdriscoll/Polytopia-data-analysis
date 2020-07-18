with seasons as
(select id as game_id, 
        cast(coalesce(substring(name from '%[PpJj]?[Ss]#"[0-9]#"%' for '#'),
		substring(notes from '%[PpJj][Ss]#"[0-9]#"%' for '#')) as int) as season
  from game)
  
select player.name, 
		count(*) filter (where game.winner_id = gameside.id) as wins,
		count(*) filter (where game.winner_id <> gameside.id) as losses,
        count(*) as season_games_played,
		100*(count(*) filter (where game.winner_id = gameside.id))/(count(*)) as percentage_won
  from gameside
  join seasons on gameside.game_id = seasons.game_id
  join squadmember on gameside.squad_id = squadmember.squad_id
  join player on squadmember.player_id = player.id
  join game on gameside.game_id = game.id
 where season is not null
   and game.completed_ts is not null
 group by player.name
 having count(*) > 7
 order by (100*(count(*) filter (where game.winner_id = gameside.id))/(count(*))) asc
  