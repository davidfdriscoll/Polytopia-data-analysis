SELECT id, name, notes,
        cast((regexp_matches(name, '[PpJj]?[Ss]([0-9])'))[1] as int) as season_from_name,
		cast((regexp_matches(notes, '[PpJj][Ss]([0-9])'))[1] as int) as season_from_notes
  from game
 order by id