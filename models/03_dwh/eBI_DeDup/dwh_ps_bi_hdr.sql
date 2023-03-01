{{ config(
    tags = ["ps_bi_hdr"], 
    alias = 'ps_bi_hdr'
    )
}}

select *, current_timestamp() AS insert_datetime
from {{ ref( 'stg_ps_bi_hdr')}}
