select id, name, (completed_ts - date) as longest_pro_game from game 
 where completed_ts - date = 
 (select max(completed_ts - date) as longest_game 
  from game
  where lower(name) like '%js%' or lower(notes) like '%js%')