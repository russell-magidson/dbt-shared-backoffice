{{ config(
    tags = ["ps_assignment", "backoffice"], 
    alias = 'ps_assignment'
    )
}}

select *, current_timestamp() AS insert_datetime
from {{ ref( 'stg_ps_assignment')}}
