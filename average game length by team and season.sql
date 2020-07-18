with seasons as
(select id as game_id, 
        cast(coalesce(substring(name from '%[PpJj]?[Ss]#"[0-9]#"%' for '#'),
		substring(notes from '%[PpJj][Ss]#"[0-9]#"%' for '#')) as int) as season
  from game)
select min(team.name), 
	justify_hours(avg(a.game_length))
  from (select gameside.team_id, gameside.game_id, game.completed_ts - game.date as game_length from gameside join game on gameside.game_id = game.id) a
   join team on a.team_id = team.id
   join seasons on a.game_id = seasons.game_id
  where seasons.season = 6
  group by a.team_id
  order by a.team_id