select team_name, count(*) as number_of_players from (select player.name, team.name as team_name from gameside
  join team on gameside.team_id = team.id
  join squadmember on gameside.squad_id = squadmember.squad_id
  join player on squadmember.player_id = player.id
  where team.id in (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 220, 221)
  group by player.name, team.name
  order by player.name, team.name) a group by team_name order by count(*) desc