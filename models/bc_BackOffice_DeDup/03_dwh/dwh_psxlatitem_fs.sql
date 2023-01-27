{{ config(
    tags = ["psxlatitem_fs", "psxlatitem", "backoffice"], 
    materialized = 'incremental', 
    schema = 'rlm_dwh_tables_None', 
    alias = 'psxlatitem_fs'
    )
}}

select *, current_timestamp() AS insert_datetime
from {{ ref( 'stg_psxlatitem_fs')}}
