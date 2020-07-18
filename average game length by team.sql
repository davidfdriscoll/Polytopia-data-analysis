select min(team.name), 
	justify_hours(avg(a.game_length))
  from (select gameside.team_id, game.completed_ts - game.date as game_length from gameside join game on gameside.game_id = game.id) a
   join team on a.team_id = team.id
  group by a.team_id
  order by a.team_id