{{ config(
    tags = ["ext_table_refresh_schedule"], 
    alias = "ext_table_refresh_schedule"
    )
}}

select *
from {{ ref( 'dwh_ext_table_refresh_schedule')}}
where insert_datetime = ( SELECT max( insert_datetime)
                        from {{ ref( 'dwh_ext_table_refresh_schedule')}}
                        )
