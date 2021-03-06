-- vim: set expandtab shiftwidth=2 syntax=pgsql tabstop=2 :

--
DO $$ BEGIN RAISE INFO 'benchmark'; END $$;
--
CREATE SERVER benchmark FOREIGN DATA WRAPPER go_test_fdw
OPTIONS (test 'benchmark');

--
CREATE FOREIGN TABLE one_column (col1 text) SERVER benchmark;
DO $$ BEGIN PERFORM * FROM one_column; END; $$;
DO $$ BEGIN PERFORM go_test_fdw_benchmark_begin(); END; $$;
DO $$ BEGIN PERFORM * FROM one_column; END; $$;
SELECT go_test_fdw_benchmark_end();

--
CREATE FOREIGN TABLE four_columns (col1 text, col2 text, col3 text, col4 text) SERVER benchmark;
DO $$ BEGIN PERFORM * FROM four_columns; END; $$;
DO $$ BEGIN PERFORM go_test_fdw_benchmark_begin(); END; $$;
DO $$ BEGIN PERFORM * FROM four_columns; END; $$;
SELECT go_test_fdw_benchmark_end();

--
-- cleanup
--
DROP SERVER benchmark CASCADE;
