{{ config(
    tags = ["psxlatitem_hr", "psxlatitem", "backoffice"], 
    materialized = 'incremental', 
    schema = 'rlm_dwh_tables_None', 
    alias = 'psxlatitem_hr'
    )
}}

select *, current_timestamp() AS insert_datetime
from {{ ref( 'stg_psxlatitem_hr')}}
