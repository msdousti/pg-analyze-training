reset default_statistics_target;

drop table if exists t;

create or replace function beautify (arr anyarray, per_line int)
    returns setof text
    language plpgsql
    immutable strict
    as $$
declare
    i integer := array_lower(arr, 1);
    len constant integer := array_upper(arr, 1);
begin
    while i <= len loop
        return next array_to_string(arr[i:i + per_line - 1], ',');
        i := i + per_line;
    end loop;
end
$$;

\! clear

create table t(n) 
  with (autovacuum_enabled = off)
  as select generate_series(1, i)
     from generate_series(1, 1000) as i;

\prompt x
\echo\echo

select n, count(*) from t
group by n order by 1;

\prompt x
\! clear

select 
  percentile_cont(0.5) within group (order by n) as median
from t;

\prompt x

select 
  count(*) filter (where n <= 294) 
  /
  count(*)::numeric
  as ratio 
from t;

\prompt x
\! clear

analyze verbose t;

\prompt x
select * from c('select * from t where n <= 294');

\prompt x
\echo\echo

analyze verbose t;

\echo\echo

select * from c('select * from t where n <= 294');

\prompt x
\! clear

select
  beautify(histogram_bounds::text::int[], 20) as histogram_bounds
from pg_stats
where schemaname = 'analyze_training' and tablename = 't';

\prompt x

\! clear

show default_statistics_target;

\prompt x
\! clear

analyze verbose t;

\echo\echo
\prompt x

set default_statistics_target = 2;

\echo\echo

analyze verbose t;

\prompt x
\! clear

select
  histogram_bounds
from pg_stats 
  where schemaname = 'analyze_training' and tablename = 't';

\echo\echo

select min(n), 
  percentile_cont(0.5) 
    within group (order by n) as median,
  max(n)
  from t;

\prompt x
\! clear

select * from c('select * from t where n <= 294');

\echo\echo

select * from c('select * from t where n < 700');

\prompt x
\! clear

alter table t alter column n set statistics 10;

\echo\echo

analyze verbose t;

\echo\echo

select * from c('select * from t where n < 700');

\prompt x
\! clear

reset default_statistics_target;

\prompt x
\echo\echo

show default_statistics_target;

\prompt x
\echo\echo

-- In PG17, you can use "default" instead of -1
-- Setting it to 0 disables statistics gathering on this column
alter table t alter column n set statistics -1;

\prompt x
\echo\echo

analyze verbose t;

\prompt x
\echo\echo

select array_length(histogram_bounds, 1) from pg_stats 
  where schemaname = 'analyze_training' and tablename = 't';


\prompt x
