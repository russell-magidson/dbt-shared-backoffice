{{ config(
    tags = ["ps_item_activity"], 
    alias = 'ps_item_activity'
    )
}}

select *, current_timestamp() as insert_datetime
from {{ ref( 'stg_ps_item_activity')}}
