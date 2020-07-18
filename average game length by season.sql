with seasons as
(select id as game_id, 
        cast(coalesce(substring(name from '%[PpJj]?[Ss]#"[0-9]#"%' for '#'),
		substring(notes from '%[PpJj][Ss]#"[0-9]#"%' for '#')) as int) as season
  from game)
select seasons.season, 
	justify_hours(avg(a.game_length)) as average_game_length
  from (select gameside.team_id, gameside.game_id, game.completed_ts - game.date as game_length from gameside join game on gameside.game_id = game.id) a
   join seasons on a.game_id = seasons.game_id
  where seasons.season is not null
  group by seasons.season
  order by seasons.season