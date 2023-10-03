SELECT DISTINCT
  start_time::DATE AS query_run_ds -- this is test
  , user_name                      -- this is test
  , query_tag                      -- this is test
  , schema_name                    -- this is test
  , execution_status               -- this is test
  , query_type                     -- this is test
FROM snowflake_usage.account_usage.query_history
WHERE
  1 = 1
  --   date filters
  AND YEAR(start_time) = 2023
  --   remove databases and DMC users
  AND LOWER(user_name) NOT IN ('anomalo', 'mellisor', 'mfazza', 'lakehouse',
                               'app_cash_3pr', 'app_datamart_cco',
                               'fivetran', 'v1_edge_collibra', 'dmc_pii', 'app_cash_cs')
  --   database.schema.table filter
  AND query_text ILIKE '%app_cash_cs.public.tiktok_inapp_cases%'
  --   column filter
  AND query_text ILIKE '%summary_of_action_take%'
  -- GROUP BY 1,2,3
ORDER BY 1 DESC
;