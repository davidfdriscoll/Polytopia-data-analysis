select game.id as game_id, game.name as game_name, 
        host.player_id as host_id, host.elo_after_game as host_elo,
		opponent.player_id as opponent_id, opponent.elo_after_game as opponent_elo
  from game 
   join
		(select game_id, count(*) as count from lineup group by game_id) game_participant
	 on game.id = game_participant.game_id
   join lineup as host
     on game.id = host.game_id
   join lineup as opponent
     on game.id = opponent.game_id
   join gameside as gameside_of_winner
     on game.winner_id = gameside_of_winner.id
  where game.host_id = host.player_id
    and game.host_id != opponent.player_id
    and game_participant.count = 2
    and host.elo_after_game is not null
	and opponent.gameside_id = gameside_of_winner.id