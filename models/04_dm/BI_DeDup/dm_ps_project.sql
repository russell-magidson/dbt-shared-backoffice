{{ config(
    tags = ["ps_project"], 
    alias = "ps_project"
    )
}}

select *, current_timestamp() as insert_datetime
from {{ ref( 'stg_ps_project')}}
