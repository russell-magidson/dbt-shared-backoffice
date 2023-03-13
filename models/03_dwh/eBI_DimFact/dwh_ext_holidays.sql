{{ config(
    tags = ["ext_holidays"], 
    alias = "ext_holidays"
    )
}}

select *, current_timestamp() AS insert_datetime
from {{ ref( "stg_ext_holidays")}}

