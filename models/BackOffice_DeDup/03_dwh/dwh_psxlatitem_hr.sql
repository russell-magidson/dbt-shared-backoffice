{{ config(
    tags = ["psxlatitem_hr", "psxlatitem", "backoffice"], 
    materialized = 'incremental', 
    alias = 'psxlatitem_hr'
    )
}}

with source_psxlatitem_hr as (
    select *
    from {{ ref( 'stg_psxlatitem_hr')}}
)

, final as ( 
    select *, current_timestamp() AS insert_datetime
    from source_psxlatitem_hr
)

select *
from final
