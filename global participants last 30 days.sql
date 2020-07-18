select count(*) from (select distinct discordmember.id
  from lineup
  join game on lineup.game_id = game.id
  join player on lineup.player_id = player.id
  join discordmember on player.discord_member_id = discordmember.id
 where game.date > now() -  interval '30 days') a