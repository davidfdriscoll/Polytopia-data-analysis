with seasons as
(select id as game_id, 
        cast(coalesce(substring(name from '%[PpJj]?[Ss]#"[0-9]#"%' for '#'),
		substring(notes from '%[PpJj][Ss]#"[0-9]#"%' for '#')) as int) as season
  from game)
select player.name, seasons.season, count(*) as wins 
  from gameside
  join seasons on gameside.game_id = seasons.game_id
  join squadmember on gameside.squad_id = squadmember.squad_id
  join player on squadmember.player_id = player.id
  join game on gameside.game_id = game.id
 where game.winner_id = gameside.id
   and season is not null
 group by player.name, seasons.season
 order by count(*) desc, player.name
  