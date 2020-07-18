with seasons as
(select id as game_id, 
        cast(coalesce(substring(name from '%[PpJj]?[Ss]#"[0-9]#"%' for '#'),
		substring(notes from '%[PpJj][Ss]#"[0-9]#"%' for '#')) as int) as season,
 		cast(coalesce(substring(name from '%[PpJj]?[Ss][0-9][Ww]#"[0-9]#"%' for '#'),
		substring(notes from '%[PpJj][Ss][0-9][Ww]#"[0-9]#"%' for '#')) as int) as week
  from game)
  
select team.name, seasons.season, seasons.week, gameside.game_id, game.name,
   case when game.winner_id = gameside.id then 'W' else 'L' end as win_loss
  from gameside
  join seasons on gameside.game_id = seasons.game_id
  join team on gameside.team_id = team.id
  join game on gameside.game_id = game.id
 where season is not null
   and game.completed_ts is not null
   and lower(team.name) like '%craw%'
   and seasons.season = 3
 order by seasons.season, seasons.week, gameside.game_id
  