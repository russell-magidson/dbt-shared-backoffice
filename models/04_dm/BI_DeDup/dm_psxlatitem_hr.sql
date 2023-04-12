{{ config(
    tags = ["psxlatitem_hr"], 
    alias = "psxlatitem_hr"
    )
}}

select *, current_timestamp() AS insert_datetime
from {{ ref( 'stg_psxlatitem_hr')}}
