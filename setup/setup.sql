\set cow '\033[31m\n  \\ \n    (__)\n    (oo)-----/\n    (__)    ||\n       ||---||\n\033[0m'

drop schema if exists public cascade;

create schema public;

set search_path to public;

-- https://wiki.postgresql.org/wiki/Count_estimate
create or replace function c(
  in query text,
  out scan text, out estimate text, out actual text
)
returns record language plpgsql as $$
declare
  jsn jsonb;
  plan jsonb;
begin
  execute format('explain (analyze, format json) %s', query)
    into jsn;
  select jsn->0->'Plan' into plan;
  
  scan := plan->>'Node Type';
  estimate := plan->>'Plan Rows';
  actual := plan->>'Actual Rows';
end;
$$;