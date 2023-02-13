{{ config(
    tags = ["ps_bi_hdr", "backoffice"], 
    materialized = 'incremental', 
    alias = 'ps_bi_hdr'
    )
}}

with source_ps_bi_hdr as (
    select *
    from {{ ref( 'stg_ps_bi_hdr')}}
)

, final as (
    select *, current_timestamp() AS insert_datetime
    from source_ps_bi_hdr
)

select *
from final
