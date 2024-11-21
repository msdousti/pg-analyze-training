\! clear

drop table if exists t;

\echo\echo

create table t(n int, m int) 
  with (autovacuum_enabled = off);

\echo\echo

insert into t
  select mod(n,2), mod(n,4) from generate_series(1,1000) as n;

\prompt x
\! clear

analyze t;

\echo\echo

select * from c('select * from t where n=1');

\echo\echo

select * from c('select * from t where m=1');

\echo\echo

select * from c('select * from t where n=1 and m=1');

\prompt x
\! clear

\! cowsay Index will not help!

\prompt x
\echo\echo

create index on t(n,m);

\echo\echo

select * from c('select * from t where n=1 and m=1');

\prompt x
\! clear

drop statistics if exists t_m_n;

\echo\echo

create statistics t_m_n on n,m from t;

\echo\echo

analyze t;

\echo\echo

select * from c('select * from t where n=1 and m=1');

\prompt x
\! clear

select * from pg_stats_ext where statistics_name = 't_m_n';

\prompt x
