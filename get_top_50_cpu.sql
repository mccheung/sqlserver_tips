--占用CPU最多
SELECT TOP 50
  total_worker_time / execution_count AS [Avg CPU Time],
  (SELECT Substring(text, statement_start_offset / 2, ( CASE
        WHEN statement_end_offset = -1 THEN Len(CONVERT(NVARCHAR(max), text)) * 2
        ELSE statement_end_offset
        END - statement_start_offset ) / 2)
    FROM   sys.Dm_exec_sql_text(sql_handle)) AS query_text,  *
FROM   sys.dm_exec_query_stats
ORDER  BY [Avg CPU Time] DESC
