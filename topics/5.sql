-- reset to defaults
alter system set autovacuum_naptime = '1min';
select pg_reload_conf();

\! clear

drop table if exists t;

\echo\echo

create table t(n int) 
  with (autovacuum_enabled = off);

\echo\echo

insert into t values (0), (1), (2);

\prompt x
\! clear

analyze verbose t;

\echo\echo

create index on t(n);

\echo\echo

insert into t select generate_series(0,999);

\prompt x
\! clear

select * from c('select * from t where n=5');

\echo\echo

analyze t;

\echo\echo

select * from c('select * from t where n=5');

\echo\echo

\prompt x
\! clear

\echo ps -ef | grep -v grep | grep postgres
\echo\echo
\! ps -ef | grep -v grep | grep postgres

\prompt x
\! clear


select * from pg_settings where name = 'autovacuum_naptime';

\prompt x
\! clear

alter system set autovacuum_naptime = '1s';

\echo\echo

select pg_reload_conf();

select pg_sleep(1);

\echo\echo

show autovacuum_naptime;

\prompt x
\! clear

drop table if exists t;

\echo\echo

create table t(n int) 
  with (
    autovacuum_enabled = on,
    autovacuum_analyze_scale_factor = 0, 
    autovacuum_analyze_threshold = 1
  );

\echo\echo

insert into t select mod(generate_series(0,99999),4);

\echo\echo

select last_analyze, last_autoanalyze 
  from pg_stat_user_tables 
  where relname = 't';

\prompt x

select last_analyze, last_autoanalyze 
  from pg_stat_user_tables 
  where relname = 't';

\prompt x

select * from c('select * from t where n=3');

\prompt x