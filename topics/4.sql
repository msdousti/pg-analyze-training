\! clear

delete from t where n < 0.2;

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
\! cowsay combine them!

\echo\echo\echo
\prompt x

vacuum (analyze, verbose) t;

\prompt x


