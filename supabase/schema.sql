-- Trainingspartner: tabellen voor opgeslagen trainingen.
-- Uitvoeren in Supabase: SQL Editor > New query > plakken > Run.

create table if not exists public.training_sessions (
  id              uuid primary key,
  user_id         uuid not null default auth.uid() references auth.users (id) on delete cascade,
  started_at      timestamptz not null,
  ended_at        timestamptz,
  duration_sec    integer,
  completed       boolean not null default false,
  max_hr_setting  integer,
  avg_hr          integer,
  max_hr          integer,
  hr_samples      jsonb not null default '[]'::jsonb,  -- [[seconden sinds start, bpm], ...]
  created_at      timestamptz not null default now()
);

create table if not exists public.training_steps (
  id           bigint generated always as identity primary key,
  session_id   uuid not null references public.training_sessions (id) on delete cascade,
  user_id      uuid not null default auth.uid() references auth.users (id) on delete cascade,
  seq          integer not null,          -- volgorde binnen de training
  idx          integer not null,          -- positie in het trainingsschema
  block        text,
  name         text not null,
  type         text not null check (type in ('box', 'work', 'rest')),
  planned_sec  integer,
  actual_sec   integer,
  started_at   timestamptz,
  avg_hr       integer,
  max_hr       integer,
  unique (session_id, seq)
);

create index if not exists training_sessions_user_started_idx on public.training_sessions (user_id, started_at desc);
create index if not exists training_steps_session_idx on public.training_steps (session_id);
create index if not exists training_steps_user_idx on public.training_steps (user_id);

alter table public.training_sessions enable row level security;
alter table public.training_steps enable row level security;

-- Alleen de eigenaar mag zijn eigen trainingen lezen en schrijven
create policy "eigen sessies lezen"     on public.training_sessions for select to authenticated using ((select auth.uid()) = user_id);
create policy "eigen sessies toevoegen" on public.training_sessions for insert to authenticated with check ((select auth.uid()) = user_id);
create policy "eigen sessies wijzigen"  on public.training_sessions for update to authenticated using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);
create policy "eigen sessies wissen"    on public.training_sessions for delete to authenticated using ((select auth.uid()) = user_id);

create policy "eigen stappen lezen"     on public.training_steps for select to authenticated using ((select auth.uid()) = user_id);
create policy "eigen stappen toevoegen" on public.training_steps for insert to authenticated with check ((select auth.uid()) = user_id);
create policy "eigen stappen wijzigen"  on public.training_steps for update to authenticated using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);
create policy "eigen stappen wissen"    on public.training_steps for delete to authenticated using ((select auth.uid()) = user_id);
