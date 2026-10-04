-- Geschatte verbranding per training
alter table public.training_sessions
  add column if not exists kcal integer,
  add column if not exists kcal_method text;
