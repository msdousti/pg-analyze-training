\! clear

drop table if exists t;
\echo\echo

create table t(n int) 
  with (autovacuum_enabled = off);
\echo\echo

insert into t 
  select mod(generate_series(0,999),5);
\echo\echo


select reltuples from pg_class 
  where relname = 't';

\prompt x
\! clear

select * from pg_stats 
  where tablename = 't';

\prompt x
\! clear

analyze t;

\echo\echo

select reltuples from pg_class 
  where relname = 't';

\prompt x
\! clear

select * from pg_stats 
  where tablename = 't';

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