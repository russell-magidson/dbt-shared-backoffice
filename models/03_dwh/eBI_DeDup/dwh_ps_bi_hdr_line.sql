{{ config(
    tags = ["ps_bi_hdr_line"], 
    alias = 'ps_bi_hdr_line', 
    partition_by = { 
        "field": "insert_datetime", 
        "data_type": "timestamp", 
        "granularity": "day"
    }
    )
}}

select *, current_timestamp() AS insert_datetime
from {{ ref( 'stg_ps_bi_hdr_line')}}
