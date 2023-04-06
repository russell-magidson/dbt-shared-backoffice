{{ config(
    tags = ["ps_names"], 
    alias = 'ps_names'
    )
}}

select *, current_timestamp() as insert_datetime
from {{ ref( 'stg_ps_names')}}
