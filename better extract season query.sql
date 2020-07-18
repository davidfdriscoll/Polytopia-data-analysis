select * from
(select id, name, notes,
        cast(coalesce(substring(name from '%[PpJj]?[Ss]#"[0-9]#"%' for '#'),
		substring(notes from '%[PpJj][Ss]#"[0-9]#"%' for '#')) as int) as season
  from game) seasons
 where season is not null
 order by id
