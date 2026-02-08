-- Enable UUID extension
create extension if not exists "uuid-ossp";

-- =========================
-- PROFILES TABLE
-- =========================
create table public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  email text,
  created_at timestamp with time zone default now()
);

-- =========================
-- QUERIES TABLE
-- =========================
create table public.queries (
  id uuid primary key default uuid_generate_v4(),
  user_id uuid references auth.users(id) on delete cascade,
  query_text text not null,
  created_at timestamp with time zone default now()
);

-- =========================
-- RESOURCES TABLE
-- =========================
create table public.resources (
  id uuid primary key default uuid_generate_v4(),
  title text not null,
  type text check (type in ('ppt', 'video')) not null,
  file_url text not null,
  topic text not null,
  created_at timestamp with time zone default now()
);

-- =========================
-- ENABLE RLS
-- =========================
alter table public.profiles enable row level security;
alter table public.queries enable row level security;
alter table public.resources enable row level security;

-- =========================
-- RLS POLICIES
-- =========================

-- Profiles
create policy "Users can view their profile"
on public.profiles
for select
using (auth.uid() = id);

create policy "Users can insert their profile"
on public.profiles
for insert
with check (auth.uid() = id);

-- Queries
create policy "Users can insert their queries"
on public.queries
for insert
with check (auth.uid() = user_id);

create policy "Users can view their queries"
on public.queries
for select
using (auth.uid() = user_id);

-- Resources
create policy "Authenticated users can read resources"
on public.resources
for select
using (auth.role() = 'authenticated');

-- =========================
-- AUTO SET user_id FOR QUERIES
-- =========================
create or replace function set_query_user_id()
returns trigger as $$
begin
  new.user_id := auth.uid();
  return new;
end;
$$ language plpgsql security definer;

create trigger set_query_user
before insert on public.queries
for each row execute procedure set_query_user_id();