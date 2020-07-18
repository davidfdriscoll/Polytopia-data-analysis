with seasons as
(select id as game_id, 
        cast(coalesce(substring(name from '%[PpJj]?[Ss]#"[0-9]#"%' for '#'),
		substring(notes from '%[PpJj][Ss]#"[0-9]#"%' for '#')) as int) as season,
 		cast(coalesce(substring(name from '%[PpJj]?[Ss][0-9][Ww]#"[0-9]#"%' for '#'),
		substring(notes from '%[PpJj][Ss][0-9][Ww]#"[0-9]#"%' for '#')) as int) as week
  from game)
  
select team.name, seasons.season,
		count(*) filter (where game.winner_id = gameside.id) as wins,
		count(*) filter (where game.winner_id <> gameside.id) as losses,
        count(*) as season_games_played,
		cast((count(*) filter (where game.winner_id = gameside.id)) as float)
		/COALESCE(NULLIF((count(*) filter (where game.winner_id <> gameside.id)), 0), 1) as win_loss_ratio,
		100*(count(*) filter (where game.winner_id = gameside.id))/(count(*)) as percentage_won
  from gameside
  join seasons on gameside.game_id = seasons.game_id
  join team on gameside.team_id = team.id
  join game on gameside.game_id = game.id
 where seasons.season is not null
   and seasons.week is not null
   and game.completed_ts is not null
 group by team.name, seasons.season
 order by 100*(count(*) filter (where game.winner_id = gameside.id))/(count(*))
  