\! clear

drop table if exists t;

\echo\echo

create table t(n int) 
  with (autovacuum_enabled = off);

\prompt x
\! clear

insert into t 
  select mod(generate_series(0,999),5);

\prompt x
\! clear

explain select * from t;
explain select * from t where n = 0;
explain select * from t where n = 10;

\prompt x
\! clear

select reltuples from pg_class 
  where relname = 't';

\prompt x
\! clear

create index t_n_idx on t(n);

\prompt x
\! clear

select reltuples from pg_class 
  where relname = 't';

\prompt x
\! clear

explain select * from t;
explain select * from t where n = 0;
explain select * from t where n = 10;

\prompt x