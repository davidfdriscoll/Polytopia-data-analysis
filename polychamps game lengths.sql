select id, name, notes, (completed_ts - date) as length from game 
 where (lower(name) like '%s%' or lower(notes) like '%s%')
   and guild_id = 447883341463814144
   order by (completed_ts - date)