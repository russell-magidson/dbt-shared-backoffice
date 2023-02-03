{{ config(
    tags = ["ps_assignment", "backoffice"], 
    alias = 'ps_assignment'
    )
}}

with source_ps_assignment as (
    select *
    from {{ ref( 'stg_ps_assignment')}}
)

, final as (
    select *, current_timestamp() AS insert_datetime
    from source_ps_assignment
)

select *
from final
