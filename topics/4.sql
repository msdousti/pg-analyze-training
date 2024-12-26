\! clear

delete from t where n <= 294;

\echo\echo

analyze verbose t;

\echo\echo

analyze verbose t;

\prompt x
\! clear

vacuum verbose t;

\echo\echo

analyze verbose t;

\prompt x

\! clear
\echo combine them! :cow

\echo\echo\echo
\prompt x

vacuum (analyze, verbose) t;

\prompt x


