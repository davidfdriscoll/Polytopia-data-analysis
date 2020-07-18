select id, name, notes from game 
 where lower(name) like 'ps7%' or lower(notes) like '%ps7%' 
 order by id