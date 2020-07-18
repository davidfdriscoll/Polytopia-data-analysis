select date, 
justify_hours(avg(completed_ts - date)) as avg_length_of_game 
from game 
group by date
order by date