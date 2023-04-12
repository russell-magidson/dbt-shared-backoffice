{{ config(
    tags = ["psoprdefn"], 
    alias = "psoprdefn"
    )
}}

select *, current_timestamp() as insert_datetime
from {{ ref( 'stg_psoprdefn')}}
