drop table if exists t;

\! clear

create table t(n)
  with (autovacuum_enabled = off)
  as select mod(generate_series(0, 999), 5);

\! clear

explain (analyze, format json) 
  select * from t;

\prompt x
\! clear

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


\prompt x

\! clear

select * from c('select * from t');
select * from c('select * from t where n=0');
select * from c('select * from t where n=10');

\prompt x