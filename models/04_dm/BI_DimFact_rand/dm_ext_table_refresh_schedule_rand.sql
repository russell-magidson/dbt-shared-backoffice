{{ config(
    tags = ["ext_table_refresh_schedule"], 
    alias = "ext_table_refresh_schedule"
    )
}}

select *
from {{ ref( 'dm_ext_table_refresh_schedule')}}
