drop table if exists t;

\! clear

create table t(n)
  with (autovacuum_enabled = off)
  as select mod(generate_series(0, 999), 5);

\echo\echo

select reltuples from pg_class 
  where oid = 't'::regclass;

\prompt x
\! clear

select * from pg_stats 
  where schemaname = 'analyze_training' and tablename = 't';

\prompt x
\! clear

analyze t;

\echo\echo

select reltuples from pg_class 
  where oid = 't'::regclass;

\prompt x
\! clear

select * from pg_stats 
  where schemaname = 'analyze_training' and tablename = 't';

\prompt x
\! clear

explain select * from t;
explain select * from t where n = 0;
explain select * from t where n = 10;

\prompt x
\! clear

explain analyze select * from t;
explain analyze select * from t where n = 0;
explain analyze select * from t where n = 10;

\prompt x