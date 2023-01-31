{% macro log_record_counts( schema = None, table_list = "n/a" ) -%}

{{ 
    config( 
        post_hook = 
            "insert into {{ var( 'tblRecordCounts_location' )}}
            select * from {{ this }} " 
    )
}}

with devTables as (
    select dataset_id as devDataSet, table_id as devTableName, row_count as devRowCount 
        , TIMESTAMP_MILLIS(creation_time) AS devTableCreationTS, TIMESTAMP_MILLIS(last_modified_time) AS devTableLastModifiedTS
    from `rand-rusaweb`.{{ schema }}.__TABLES__
    )
, qaTables as (
    select dataset_id as qaDataSet, table_id as qaTableName, row_count as qaRowCount
        , TIMESTAMP_MILLIS(creation_time) AS qaTableCreationTS, TIMESTAMP_MILLIS(last_modified_time) AS qaTableLastModifiedTS
    from `rand-rusaweb`.{{ schema }}.__TABLES__
    )
, prdTables as (
    select dataset_id as prdDataSet, table_id as prdTableName, row_count as prdRowCount
        , TIMESTAMP_MILLIS(creation_time) AS prdTableCreationTS, TIMESTAMP_MILLIS(last_modified_time) AS prdTableLastModifiedTS
    from `rand-rusaweb`.{{ schema }}.__TABLES__
    )
, finalData as (
    select coalesce( devDataSet, qaDataSet, prdDataSet) as DataSet, coalesce( devTableName, qaTableName, prdTableName) as TableName
        , devRowCount, qaRowCount, prdRowCount
        , devTableLastModifiedTS, qaTableLastModifiedTS, prdTableLastModifiedTS
    from devTables dev
    full outer join qaTables qa on dev.devTableName = qa.qaTableName
    full outer join prdTables prd on dev.devTableName = prd.prdTableName
    )
select 
    DataSet, TableName
    , sum( devRowCount) as devRowCount, sum( qaRowCount) as qaRowCount, sum( prdRowCount) as prdRowCount
    , abs( round( safe_divide( sum( devRowCount) - sum( qaRowCount), sum( devRowCount)) * 100, 2)) as dev_qa_DiffPct
    , abs( round( safe_divide( sum( devRowCount) - sum( prdRowCount), sum( devRowCount)) * 100, 2)) as dev_prd_DiffPct
    , abs( round( safe_divide( sum( qaRowCount) - sum( prdRowCount), sum( qaRowCount)) * 100, 2)) as qa_prd_DiffPct
    , max( devTableLastModifiedTS) as devTableLastModifiedTS, max( qaTableLastModifiedTS) as qaTableLastModifiedTS, max( prdTableLastModifiedTS) as prdTableLastModifiedTS
    , current_timestamp() as insert_datetime 
from finalData

WHERE TableName in ( 
    {{ table_list }} 
    )

group by DataSet, TableName

{%- endmacro %}
