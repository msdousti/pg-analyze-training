drop table if exists t;

\! clear

create table t(n)
  with (autovacuum_enabled = off)
  as select mod(generate_series(0, 999), 5);

\prompt x
\! clear

explain select * from t;
explain select * from t where n = 0;
explain select * from t where n = 10;

\prompt x
\! clear

select reltuples from pg_class 
  where oid = 't'::regclass;

\prompt x
\! clear

create index t_n_idx on t(n);

\prompt x
\! clear

select reltuples from pg_class 
  where oid = 't'::regclass;

\prompt x
\! clear

explain select * from t;
explain select * from t where n = 0;
explain select * from t where n = 10;

\prompt x