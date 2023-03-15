{% macro log_record_count( schema = None, table_list = "n/a" ) -%}

{{ 
    config( 

        pre_hook = 
            "create table if not exists {{ var( 'tblRecordCount_location')}}.tblRecordCount
            (
            DataSet STRING,
            TableName STRING,
            devRowCount INT64,
            qaRowCount INT64,
            prdRowCount INT64,
            dev_qa_DiffPct FLOAT64,
            dev_prd_DiffPct FLOAT64,
            qa_prd_DiffPct FLOAT64,
            devTableLastModifiedTS TIMESTAMP,
            qaTableLastModifiedTS TIMESTAMP,
            prdTableLastModifiedTS TIMESTAMP,
            insert_datetime TIMESTAMP
            );
            ", 

        post_hook = 
            "insert into {{ var( 'tblRecordCount_location' )}}.tblRecordCount
            select * from {{ this }} " 
    )
}}

with devTables as (
    select dataset_id as devDataSet, table_id as devTableName, row_count as devRowCount 
        , TIMESTAMP_MILLIS(creation_time) AS devTableCreationTS, TIMESTAMP_MILLIS(last_modified_time) AS devTableLastModifiedTS
    from 
        {%- if schema == "eBI_DimFact" -%} `us-atldm-test-dev-9198.eBI_DimFact`
            {% elif schema == "eBI_DeDup "%} `rand-rusaweb.eBI_DeDup`
            {% elif schema == "PO_Assignments"%} `us-atldm-test-dev-9198.tst_data_mart_BI_PO_Assignments`
            {% else %} `rand-rusaweb.eBI_DeDup`
        {%- endif -%}
        .__TABLES__
    )
, qaTables as (
    select dataset_id as qaDataSet, table_id as qaTableName, row_count as qaRowCount
        , TIMESTAMP_MILLIS(creation_time) AS qaTableCreationTS, TIMESTAMP_MILLIS(last_modified_time) AS qaTableLastModifiedTS
    from 
        {%- if schema == "eBI_DimFact" -%} `us-atldm-test-qa-2114.eBI_DimFact`
            {% elif schema == "eBI_DeDup "%} `us-ergbq-qa-e523.eBI_DeDup`
            {% elif schema == "PO_Assignments"%} `us-atldm-test-qa-2114.acc_data_mart_BI_PO_Assignments`
            {% else %}  `us-ergbq-qa-e523.eBI_DeDup`
        {%- endif -%}
        .__TABLES__
    )
, prdTables as (
    select dataset_id as prdDataSet, table_id as prdTableName, row_count as prdRowCount
        , TIMESTAMP_MILLIS(creation_time) AS prdTableCreationTS, TIMESTAMP_MILLIS(last_modified_time) AS prdTableLastModifiedTS
    from 
        {%- if schema == "eBI_DimFact" -%} `us-atldm-test-prd-99b5.eBI_DimFact`
            {% elif schema == "eBI_DeDup "%} `us-ergbq-prd-3693.eBI_DeDup`
            {% elif schema == "PO_Assignments"%} `us-atldm-test-prd-99b5.prd_data_mart_BI_PO_Assignments`
            {% else %} `us-ergbq-prd-3693.eBI_DeDup`
        {%- endif -%}
        .__TABLES__
    )
, finalData as (
    select 
        "{{ schema }}" as DataSet
        {# coalesce( prdDataSet, qaDataSet, devDataSet) as DataSet #}
        , coalesce( prdTableName, qaTableName, devTableName) as TableName
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
