drop table if exists t;

-- reset to defaults
alter system reset autovacuum_naptime;
select pg_reload_conf();

\! clear


create table t(n int primary key)
  with (autovacuum_enabled = off);

\echo\echo

insert into t values (0), (1), (2);

\echo\echo

analyze t;

\echo\echo

insert into t select generate_series(3, 999);

\prompt x
\! clear

select scan from c('select * from t where n<5');

\prompt x
\echo\echo

analyze t;

\prompt x
\echo\echo

select scan from c('select * from t where n<5');

\echo\echo

\prompt x
\! clear

\echo pstree $(pgrep -xo postgres)
\echo\echo
\! pstree $(pgrep -xo postgres)

\prompt x
\! clear


select * from pg_settings where name = 'autovacuum_naptime';

\prompt x
\! clear

alter system set autovacuum_naptime = '1s';

\echo\echo

select pg_reload_conf();

\prompt x
\echo\echo

show autovacuum_naptime;

\prompt x

drop table if exists t;

\echo\echo
\! clear

create table t(n) 
  with (
    autovacuum_enabled = on,
    autovacuum_analyze_scale_factor = 0, 
    autovacuum_analyze_threshold = 1
  )
  as select mod(generate_series(0, 99999), 4);

\prompt x
\echo\echo

select n_mod_since_analyze, last_analyze, last_autoanalyze, 
       analyze_count, autoanalyze_count
  from pg_stat_user_tables
  where relname = 't';

\prompt x
\echo\echo

select n_mod_since_analyze, last_analyze, last_autoanalyze, 
       analyze_count, autoanalyze_count
  from pg_stat_user_tables
  where relname = 't';

\prompt x
\! clear

select * from c('select * from t where n=3');

\prompt x