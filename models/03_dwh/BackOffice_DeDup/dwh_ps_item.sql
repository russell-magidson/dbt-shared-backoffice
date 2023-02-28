{{ config(
    tags = ["ps_item", "dedup", "backoffice"], 
    alias = "ps_item"
    )
}}

select *, current_timestamp() as insert_datetime
from {{ ref( 'stg_ps_item')}}
