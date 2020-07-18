select id, name, (completed_ts - date) as median_game from game 
 where completed_ts - date = 
 (select PERCENTILE_DISC(.5) within group (order by completed_ts - date)
  from game)