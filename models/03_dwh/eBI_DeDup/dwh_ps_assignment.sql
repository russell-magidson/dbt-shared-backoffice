{{ config(
    tags = ["ps_assignment"], 
    alias = 'ps_assignment', 
    partition_by = { 
        "field": "insert_datetime", 
        "data_type": "timestamp", 
        "granularity": "day"
    }
    )
}}

select *, current_timestamp() AS insert_datetime
from {{ ref( 'stg_ps_assignment')}}
