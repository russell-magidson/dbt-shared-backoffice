{{ config(
    tags = ["ps_bi_hdr_line"], 
    alias = 'ps_bi_hdr_line'
    )
}}

select *, current_timestamp() AS insert_datetime
from {{ ref( 'stg_ps_bi_hdr_line')}}
