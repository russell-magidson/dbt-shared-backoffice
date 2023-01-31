{{ config(
    tags = ["psxlatitem_fs", "psxlatitem", "backoffice"], 
    materialized = 'incremental', 
    alias = 'psxlatitem_fs'
    )
}}

with source_psxlatitem_fs as (
    select *
    from {{ ref( 'stg_psxlatitem_fs')}}
)

, final as ( 
    select *, current_timestamp() AS insert_datetime
    from source_psxlatitem_fs
)

select *
from final
