{{ config(
    tags = ["ps_assignment", "backoffice"], 
    materialized = 'incremental', 
    schema = 'rlm_dwh_tables_None', 
    alias = 'ps_assignment'
    )
}}

select *, current_timestamp() AS insert_datetime
from {{ ref( 'stg_ps_assignment')}}
