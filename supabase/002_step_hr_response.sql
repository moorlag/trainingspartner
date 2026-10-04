-- Extra kolommen voor de hartslagreactie per oefening en de volgorde
alter table public.training_steps
  add column if not exists offset_sec   integer,
  add column if not exists prev_name    text,
  add column if not exists prev_type    text,
  add column if not exists start_hr     integer,
  add column if not exists end_hr       integer,
  add column if not exists min_hr       integer,
  add column if not exists peak_at_sec  integer,
  add column if not exists hr_rise      integer,
  add column if not exists hr_drop      integer;
