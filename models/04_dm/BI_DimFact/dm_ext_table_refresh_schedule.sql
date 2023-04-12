{{ config(
    tags = ["ext_table_refresh_schedule"], 
    alias = "ext_table_refresh_schedule"
    )
}}

select *, current_timestamp() AS insert_datetime
from {{ ref( "stg_ext_table_refresh_schedule")}}
