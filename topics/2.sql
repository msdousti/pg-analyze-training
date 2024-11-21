\! clear

explain (analyze, format json) 
  select * from t;

\prompt x
\! clear

drop type if exists pln cascade;

\echo\echo

create type pln as (scan text, estimate text, actual text);

\echo\echo

-- https://wiki.postgresql.org/wiki/Count_estimate
create or replace function c(query text)
returns pln language plpgsql as $$
declare
  jsn jsonb;
  plan jsonb;
begin
  execute format('explain (analyze, format json) %s', query)
    into jsn;
  select jsn->0->'Plan' into plan;
  return row(plan->>'Node Type', plan->>'Plan Rows', plan->>'Actual Rows');
end;
$$;

\prompt x

\! clear

select * from c('select * from t');
select * from c('select * from t where n=0');
select * from c('select * from t where n=10');

\prompt x