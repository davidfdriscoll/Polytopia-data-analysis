select t.name, 
        min(p.elo) as team_min_elo, 
		max(p.elo) as team_max_elo, 
		max(p.elo) - min(p.elo) as team_elo_range 
  from player as p
  join team as t on p.team_id = t.id
 where p.guild_id = 447883341463814144 
    and (team_id between 13 and 22
		 or team_id = 220)
 group by p.team_id, t.name
 order by team_elo_range desc